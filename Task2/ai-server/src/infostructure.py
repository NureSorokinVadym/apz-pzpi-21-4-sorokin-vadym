from psycopg import AsyncConnection


class ConnManager:
    def __init__(self):
        self.conn: AsyncConnection

    async def connect(self):
        self.conn = await AsyncConnection.connect(
            "postgresql://user:password@database/db"
        )

    async def __del__(self):
        await self.conn.close()


database = ConnManager()


async def get_exercise(iot_id: int):
    query = "select next_exercise_id from iot_user where id = %s"
    async with database.conn.cursor() as cur:
        await cur.execute(query, (iot_id,))
        return await cur.fetchone()


async def save_duration(exercise_id: int, duration: int) -> None:
    query = "update exercice_user set duration = %s where id = %s"
    print(exercise_id, duration)
    async with database.conn.cursor() as cur:
        print(await cur.execute(query, (duration, exercise_id)))


async def get_user_id(iot_id: int) -> int:
    query = "select user_id from iot_user where id = %s"
    async with database.conn.cursor() as cur:
        await cur.execute(query, (iot_id,))
        result = await cur.fetchone()
        print(result)
        return result[0]
