from datetime import datetime

from pydantic import BaseModel, Field


class UserState(BaseModel):
    pulse: int
    temperature: float


class UserExercise(BaseModel):
    states: list[UserState] = Field(default_factory=list)
    count: int | None = None
    weight: int | None = None
    start_at: datetime = Field(default_factory=datetime.now)


# user_exercise_id -> UserExercise
user_exercises: dict[int, UserExercise] = {}
