from psycopg import AsyncConnection


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
