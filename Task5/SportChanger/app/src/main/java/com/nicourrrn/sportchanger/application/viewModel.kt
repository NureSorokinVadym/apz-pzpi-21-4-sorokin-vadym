package com.nicourrrn.sportchanger.application

import android.view.View
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavController
import com.nicourrrn.sportchanger.domain.ExerciseRepository
import com.nicourrrn.sportchanger.domain.ExerciseType
import com.nicourrrn.sportchanger.domain.ExerciseUser
import com.nicourrrn.sportchanger.domain.User
import com.nicourrrn.sportchanger.domain.UserIotPair
import com.nicourrrn.sportchanger.domain.UserRepository
import com.nicourrrn.sportchanger.domain.emptyUser
import kotlinx.coroutines.launch
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

class AuthenticationViewModel(private val userRepository: UserRepository) : ViewModel() {
    private var _user: MutableState<User> = mutableStateOf(emptyUser())
    val user: State<User> = _user
    private var _userHaveIot = mutableStateOf(false)
    val userHaveIot: State<Boolean> = _userHaveIot
    private var _token: MutableState<String?> = mutableStateOf(null)
    val token: State<String?> = _token
    var navController: MutableState<NavController?> = mutableStateOf(null)

    fun init(nav: NavController) {
        navController.value = nav
    }

    fun updateUserMain(email: String? = null, password: String? = null) {
        val u = _user.value
        _user.value = u.copy(email = email ?: u.email, password = password ?: u.password)
    }

    fun updateUserAdditional(name: String? = null, surname: String? = null) {
        val u = _user.value
        _user.value = u.copy(name = name ?: u.name, surname = surname ?: u.surname)
    }

    fun findToken(){
        viewModelScope.launch {
            _token.value = userRepository.getToken()
            if (_token.value != null) {
                navController.value?.navigate("/")
            }
        }
    }

    fun login() {
        viewModelScope.launch {
            _token.value = userRepository.logIn(_user.value)
            if (_token.value != null) {
                navController.value?.navigate("/")
            }
        }
    }

    fun registration() {
        viewModelScope.launch {
            _token.value = userRepository.registration(_user.value)
            if (_token.value != null) {
                navController.value?.navigate("/")
            }
        }
    }

    fun logOut() {
        viewModelScope.launch {
            userRepository.setToken(null)
            navController.value?.navigate("/authorization")
        }
    }

    fun getUserInfo() {
        viewModelScope.launch {
            _user.value = userRepository.userInfo()
            _userHaveIot.value = userRepository.haveIot()
        }
    }

}

val userAppModule = module {
    single<UserRepository> { UserRepositoryHttp(get()) }
    viewModel { AuthenticationViewModel(get()) }
}

class ExerciseViewModel(private val exerciseRepository: ExerciseRepository) : ViewModel(){
    private var _exerciseTypes: MutableState<Map<Int, String>> = mutableStateOf(mapOf())
    val exerciseType: State<Map<Int, String>> = _exerciseTypes

    private var _exercises: MutableState<List<ExerciseUser>> = mutableStateOf(listOf())
    val exercises: State<List<ExerciseUser>> = _exercises

    private var _nextExerciseId = mutableStateOf(-1)
    val nextExerciseId: State<Int> = _nextExerciseId

    fun init() {
        viewModelScope.launch {
            _exerciseTypes.value = exerciseRepository.getExerciseTypes()
            _exercises.value = exerciseRepository.getUserExercises()
            _nextExerciseId.value = exerciseRepository.getNextExercise().id
        }
    }

    fun makePair(iotId: Int) {
        viewModelScope.launch {
            exerciseRepository.makePair(UserIotPair(iotId = iotId))
        }
    }

    fun newNextExercise(exerciseId: Int) {
        viewModelScope.launch {
            exerciseRepository.setNextExercise(exerciseId)
            _nextExerciseId.value = exerciseId
        }
    }



}

val exerciseAppModule = module {
    single<ExerciseRepository> { ExerciseRepositoryHttp(get()) }
    viewModel { ExerciseViewModel(get()) }
}