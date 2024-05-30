from fastapi import HTTPException, Request
from fastapi.routing import APIRouter

from . import application, dto

router = APIRouter()


@router.get("/exercises")
async def create_exercise() -> dto.CreateExercise:
    try:
        id = await application.create_exercise()
        return dto.CreateExercise(id=id)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.put("/exercises/{exercise_id}")
async def update_exercise(
    update: dto.UpdateUserExercise, exercise_id: int
) -> dto.AIResponse:
    try:
        await application.update_exercise(exercise_id, update)
        return await application.create_predict(exercise_id)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))


@router.get("/start_exercise")
async def start_exercise(request: Request):
    try:
        id = await application.start_exercise(
            request.headers["Authorization"].split(" ")[1]
        )
        return dto.Id(id=id)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
