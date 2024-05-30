package com.nicourrrn.sportchanger.domain

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class User (
    val id: Int?,
    val email: String,
    val name: String?,
    val surname: String?,
    val password: String?
)
fun emptyUser(): User{
    return User(
        id = null,
        email = "",
        name = null,
        surname = null,
        password = null,
    )
}


@Serializable
data class Exercise(
    val id: Int? = null,
    val name: String,
    val measurement: String,
    @SerialName("exerciseTypeId")
    val exerciseTypeId: Int,
    @SerialName("date")
    val createAt: String? = null
)

@Serializable
data class ExerciseType(
    val id: Int? = null,
    val name: String
)

@Serializable
data class ExerciseUser(
    val id: Int? = null,
    val exercise: Exercise,
    val duration: Int? = null,
    val number: Int? = null,
    val weight: Int? = null,
    val pulse: Int? = null,
    @SerialName("date")
    val createAt: String
)

@Serializable
data class UserIotPair(
    @SerialName("user_id")
    val userId: Int? = null,
    @SerialName("iot_id")
    val iotId: Int
)

@Serializable
data class Id(val id: Int)