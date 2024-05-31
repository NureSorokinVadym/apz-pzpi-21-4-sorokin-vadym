import jwt
from fastapi import HTTPException, Request
from fastapi.routing import APIRouter

from . import application
from . import domain as dto

router = APIRouter()


def get_user_id(req: Request) -> int:
    token = req.headers["Authorization"]
    payload = jwt.decode(token, "secret_key", algorithms=["HS256"])
    return payload["user_id"]


@router.patch("/start_exercise")
async def start_exercise(req: Request) -> dto.DefaultResponse:
    try:
        user_id = get_user_id(req)
        response = await application.start_exercise(user_id)
        return response
    except Exception as e:
        raise HTTPException(status_code=401, detail=f"Invalid token, {e}")


@router.post("/predict")
async def predict(req: Request, data: dto.IotData) -> dto.DefaultResponse:
    try:
        user_id = get_user_id(req)
        return await application.predict(user_id, data)
    except Exception as e:
        raise HTTPException(status_code=401, detail=f"Invalid token, {e}")


@router.patch("/end_exercise")
async def end_exercise(req: Request) -> dto.ExerciseDuration:
    try:
        user_id = get_user_id(req)
        return await application.end_exercise(user_id)
    except Exception as e:
        raise HTTPException(status_code=401, detail=f"Invalid token, {e}")
