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


async def save_duration(exercise_id: int, duration: int) -> None:
    query = "update exercice_user set duration = $1 where id = $2"
    await database.conn.execute(query, (duration, exercise_id))
