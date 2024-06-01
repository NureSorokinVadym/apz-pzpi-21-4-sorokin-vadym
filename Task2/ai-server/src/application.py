from datetime import datetime

import jwt
import numpy as np

from . import infostructure as db
from .domain import (DefaultResponse, ExerciseDuration, IotData, Settings,
                     UserExercise, exercises)


async def get_settings(iot_id: int) -> Settings:
    user_id = await db.get_user_id(iot_id)
    print(f"user_id: {user_id}")
    return Settings(
        token=jwt.encode({"user_id": user_id}, "secret_key", algorithm="HS256")
    )


async def start_exercise(user_id: int) -> DefaultResponse:
    if user_id in exercises:
        return DefaultResponse(message="Exercise already started")

    exercises[user_id] = UserExercise(id=user_id, user_id=user_id)
    return DefaultResponse(message="Exercise started")


async def predict(user_id: int, iot_data: IotData) -> DefaultResponse:
    exercise = exercises[user_id]
    pulse = iot_data.pulse
    temperature = iot_data.temperature
    duration = (datetime.now() - exercise.start_time).seconds
    prediction = predictor.predict(temperature, pulse, duration)
    return DefaultResponse(message=f"Scope: {prediction}")


async def end_exercise(user_id: int, iot_id: int) -> DefaultResponse:
    exercise = exercises.pop(user_id)
    duration = (datetime.now() - exercise.start_time).seconds
    exercise_id = await db.get_exercise(iot_id)
    await db.save_duration(exercise_id, duration)
    return DefaultResponse(message=f"Duration: {duration}")


async def make_light_prediction(iot_data: IotData) -> float:
    return predictor.predict(iot_data.temperature, iot_data.pulse, 3)


class Predictor:
    def __init__(self):
        temperatures = np.array([36, 36, 36, 37, 35])
        pulses = np.array([70, 75, 80, 90, 95])
        durations = np.array([30, 45, 60, 75, 90])
        scope = np.array([0.8, 0.7, 0.6, 0.4, 0.2])

        X = np.column_stack((temperatures, pulses, durations))

        y = scope.reshape(-1, 1)

        X_T = X.T
        X_T_X_inv = np.linalg.pinv(X_T @ X)
        self.weights = X_T_X_inv @ X_T @ y

    def predict(self, temp, pulse, duration) -> float:
        features = np.array([temp, pulse, duration])
        prediction = (
            self.weights[0] * features[0]
            + self.weights[1] * features[1]
            + self.weights[2] * features[2]
        )
        return prediction


predictor = Predictor()
