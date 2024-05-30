from pydantic import BaseModel

from .domain import UserState


class Id(BaseModel):
    id: int


class Sensors(BaseModel):
    pulse: int
    temperature: float


class AIResponse(BaseModel):
    will_continue: int


class EndResponse(BaseModel):
    seconds: int


class CreateExercise(BaseModel):
    id: int


class UpdateUserExercise(BaseModel):
    user_state: UserState
    add_count: int | None = None
