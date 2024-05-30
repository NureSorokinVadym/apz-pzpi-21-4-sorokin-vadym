from psycopg import AsyncConnection

from . import dto


class ConnManager:
    def __init__(self):
        self.conn: AsyncConnection

    async def create(self):
        self.conn = await AsyncConnection.connect(
            "postgresql://user:password@database/db"
        )

    async def close(self):
        await self.conn.close()


conn_manager = ConnManager()


async def exercise_present(exercise_id: int) -> bool:
    async with conn_manager.conn.cursor() as cursor:
        await cursor.execute("SELECT 1 FROM exercises WHERE id = %d", (exercise_id,))
        return bool(await cursor.fetchone())


async def get_last_exercise() -> tuple[int]:
    async with conn_manager.conn.cursor() as cursor:
        await cursor.execute(
            "SELECT id FROM exercice_user WHERE user_id = 1 ORDER BY id DESC LIMIT 1"
        )
        return await cursor.fetchone()


async def get_iot_exercise(iot_id: int) -> tuple[int, int]:
    async with conn_manager.conn.cursor() as cursor:
        await cursor.execute(
            "SELECT id, user_id FROM exercice_user WHERE iot_id = %d", (iot_id,)
        )
        return await cursor.fetchone()


async def get_user_exercise(exercise_user_id: int) -> dto:
    async with conn_manager.conn.cursor() as cursor:
        await cursor.execute(
            "SELECT * FROM exercice_user WHERE id = %d", (exercise_user_id,)
        )
        return UserExercise(**(await cursor.fetchone()))
