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


@router.get("/setting")
async def setting(req: Request) -> dto.Settings:
    try:
        print(req.headers)
        id = int(req.headers["Authorization"])
        return await application.get_settings(id)
    except Exception as e:
        print(f"Error: {e}")
        raise HTTPException(status_code=401, detail=f"Invalid IOT_ID, {e}")


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
        print(f"Errror: {e}")
        raise HTTPException(status_code=401, detail=f"Invalid token, {e}")


@router.post("/make_light_prediction")
async def make_light_prediction(data: dto.IotData) -> float:
    return await application.make_light_prediction(data)


@router.patch("/end_exercise")
async def end_exercise(req: Request, iot_id: dto.IotId) -> dto.DefaultResponse:
    try:
        user_id = get_user_id(req)
        return await application.end_exercise(user_id, iot_id.iot_id)
    except Exception as e:
        raise HTTPException(status_code=401, detail=f"Invalid token, {e}")
