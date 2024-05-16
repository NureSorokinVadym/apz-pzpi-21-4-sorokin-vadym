from . import dto, infostructure
from .domain import UserExercise, user_exercises


async def create_exercise(exercise: dto.CreateExercise):
    if infostructure.exercise_present(exercise.id):
        user_exercises[exercise.id] = UserExercise()
    else:
        raise ValueError("Exercise not exists")


async def update_exercise(
    exercise_id: int, update: dto.UpdateUserExercise
) -> dto.AIResponse:
    try:
        user_exercises[exercise_id].states.append(update.user_state)
        if update.add_count is not None:
            count = user_exercises[exercise_id].count or 0
            user_exercises[exercise_id].count = count + update.add_count
    except KeyError:
        raise ValueError("Exercise not exists")

    return dto.AIResponse(will_continue=1)
