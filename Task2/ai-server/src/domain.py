from datetime import datetime

from pydantic import BaseModel, Field


class IotData(BaseModel):
    pulse: int = Field(..., title="Pulse rate", ge=0, le=200)
    temperature: float = Field(..., title="Temperature", ge=25, le=50)


class UserExercise(BaseModel):
    id: int
    user_id: int
    start_time: datetime = Field(..., title="Start time", default_factory=datetime.now)


class ExerciseDuration(BaseModel):
    duration: int


class DefaultResponse(BaseModel):
    id: int | None = None
    message: str


class Settings(BaseModel):
    token: str


class IotId(BaseModel):
    iot_id: int


# user_id -> UserExercise
exercises: dict[int, UserExercise] = {}
