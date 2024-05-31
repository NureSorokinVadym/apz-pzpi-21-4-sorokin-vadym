from contextlib import asynccontextmanager

from fastapi import FastAPI

from src import database, router


@asynccontextmanager
async def lifespan(app: FastAPI):
    await database.connect()
    yield


app = FastAPI(lifespan=lifespan)
app.include_router(router)
