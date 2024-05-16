from contextlib import asynccontextmanager

from fastapi import FastAPI
from psycopg import AsyncConnection

from src import conn_manager, router


@asynccontextmanager
async def lifespan(app: FastAPI):
    await conn_manager.create()
    yield
    await conn_manager.close()


app = FastAPI(lifespan=lifespan)
app.include_router(router)
