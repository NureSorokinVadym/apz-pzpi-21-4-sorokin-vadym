from pydantic import BaseModel

from .domain import UserState


class CreateExercise(BaseModel):
    id: int


class UpdateUserExercise(BaseModel):
    user_state: UserState
    add_count: int | None = None


class AIResponse(BaseModel):
    will_continue: int
