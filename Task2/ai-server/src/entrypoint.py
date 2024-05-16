from fastapi import HTTPException
from fastapi.routing import APIRouter

from . import application, dto

router = APIRouter()


@router.post("/exercises")
async def create_exercise(exercise: dto.CreateExercise):
    try:
        await application.create_exercise(exercise)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.put("/exercises/{exercise_id}")
async def update_exercise(
    update: dto.UpdateUserExercise, exercise_id: int
) -> dto.AIResponse:
    try:
        return await application.update_exercise(exercise_id, update)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
