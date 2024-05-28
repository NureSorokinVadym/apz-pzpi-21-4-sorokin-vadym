package com.nicourrrn.sportchanger.application

import android.content.Context
import android.widget.TabHost
import androidx.core.content.edit
import com.nicourrrn.sportchanger.domain.Exercise
import com.nicourrrn.sportchanger.domain.ExerciseRepository
import com.nicourrrn.sportchanger.domain.ExerciseType
import com.nicourrrn.sportchanger.domain.ExerciseUser
import com.nicourrrn.sportchanger.domain.User
import com.nicourrrn.sportchanger.domain.UserRepository
import com.nicourrrn.sportchanger.domain.emptyUser
import com.nicourrrn.sportchanger.domain.prefStoreKey
import com.nicourrrn.sportchanger.domain.url
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.logging.Logging
import io.ktor.client.request.get
import io.ktor.client.request.headers
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.http.ContentType
import io.ktor.http.HttpHeaders
import io.ktor.http.append
import io.ktor.http.contentType
import io.ktor.serialization.kotlinx.json.json


class UserRepositoryHttp(private val context: Context) : UserRepository {
    private val client = HttpClient(OkHttp) {
        expectSuccess = true
        install(Logging)
        install(ContentNegotiation) {
            json()
        }
    }

    private val sharedPref = context.getSharedPreferences(prefStoreKey, Context.MODE_PRIVATE)

    override fun getToken(): String? {
       return sharedPref.getString("token", null)
    }

    override suspend fun userInfo(token: String?): User {
        try {
            val finalToken = token ?: getToken()
            println("User token: $finalToken")
            if (finalToken == null) {
                throw Error("Token is null")
            }
            val user: User = client.get("$url/api/auth/user_info") {
                headers {
                    append(HttpHeaders.Authorization,  "Bearer $finalToken")
                }
            }.body()
            print("User: ${user.name}")
            return user
        } catch (e: Throwable) {
            println(e)
            return emptyUser()
        }


    }
    override suspend fun setToken(token: String?) {
        if (token != null) {
            sharedPref.edit {
                putString("token", token)
                apply()
            }
        } else {
            sharedPref.edit {
                this.remove("token")
            }
        }
    }
    override suspend fun logIn(user: User): String? {
        try {
            val token: String = client.post("$url/api/auth/log_in") {
                contentType(ContentType.Application.Json)
                setBody(user)
            }.body<String>().drop(1).dropLast(1)

            setToken(token)
            return token
        } catch (e: Throwable) {
            return null
        }
    }

    override suspend fun registration(user: User): String? {
        try {
            val token: String = client.post("$url/api/auth/log_in") {
                contentType(ContentType.Application.Json)
                setBody(user)
            }.body<String>().drop(1).dropLast(1)

            setToken(token)
            return token
        } catch (e: Throwable) {
            return null
        }

    }
}

class ExerciseRepositoryHttp(private val userRepository: UserRepository) : ExerciseRepository {
    private val client = HttpClient(OkHttp) {
        expectSuccess = true
        install(Logging)
        install(ContentNegotiation) {
            json()
        }
    }
    override suspend fun getExerciseTypes(): Map<Int, String> {
        val exerciseTypes: Map<Int, String> = client.get("$url/api/personal/get_exercise_types")
            .body()

        println(exerciseTypes)
        return exerciseTypes
    }

    override suspend fun getUserExercises(): List<ExerciseUser> {
        val token = userRepository.getToken()
        println("User token from exercise repository: $token")
        try {
            val exercises: List<ExerciseUser> = client.get("$url/api/user/get_exercises") {
                headers {
                    append(HttpHeaders.Authorization, "Bearer $token")
                }
            }.body()
            return exercises
        } catch (e: Throwable) {
            println(e)
            return listOf()
        }

    }

}