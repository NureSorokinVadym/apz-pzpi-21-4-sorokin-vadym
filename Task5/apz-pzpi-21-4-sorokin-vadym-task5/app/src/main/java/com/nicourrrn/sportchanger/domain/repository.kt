package com.nicourrrn.sportchanger.domain

interface UserRepository {
    fun getToken() : String?
    suspend fun setToken(token: String?)
    suspend fun logIn(user: User) : String?
    suspend fun registration(user: User): String?
    suspend fun userInfo(token: String? = null) : User
    suspend fun haveIot() : Boolean
}

interface ExerciseRepository {
    suspend fun getExerciseTypes() : Map<Int, String>
    suspend fun getUserExercises() : List<ExerciseUser>
    suspend fun makePair(pair: UserIotPair)
    suspend fun setNextExercise(exerciseUserId: Int)
    suspend fun getNextExercise() : Id
}