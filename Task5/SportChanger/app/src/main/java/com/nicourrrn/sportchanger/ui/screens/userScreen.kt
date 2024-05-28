package com.nicourrrn.sportchanger.ui.screens

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.Done
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.outlined.Refresh
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import com.nicourrrn.sportchanger.application.AuthenticationViewModel
import com.nicourrrn.sportchanger.application.ExerciseViewModel
import org.koin.androidx.compose.koinViewModel
import kotlin.time.Duration
import kotlin.time.DurationUnit
import kotlin.time.toDuration

enum class ScreenType {
    Setting, Exercises
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun UserScreen(userViewModel: AuthenticationViewModel = koinViewModel(), exerciseViewModel: ExerciseViewModel = koinViewModel()) {
    SideEffect {
        userViewModel.getUserInfo()
        exerciseViewModel.init()
    }

    val screen = remember {mutableStateOf(ScreenType.Exercises)}

    Scaffold(
        topBar = {
                 TopAppBar(title = { Text(if (screen.value == ScreenType.Exercises) "Exercises" else "Settings") })
        },
        bottomBar = {
            NavigationBar {
                NavigationBarItem(selected = screen.value == ScreenType.Exercises, onClick = { screen.value = ScreenType.Exercises },
                    icon = { Icon(Icons.Filled.Done, "Exercise") })
                NavigationBarItem(selected = screen.value == ScreenType.Setting, onClick = { screen.value = ScreenType.Setting },
                    icon = { Icon(Icons.Filled.Settings, "Settings") })
            }
        },
        floatingActionButton = { FloatingActionButton(onClick = { exerciseViewModel.init() }) {
            Icon(Icons.Outlined.Refresh, "Update")
        } }

    ) {padding ->
        val modifier = Modifier.padding(padding)
        if (screen.value == ScreenType.Exercises) ExerciseScreen(
            modifier = modifier,
            exerciseViewModel = exerciseViewModel,
            userViewModel = userViewModel
        ) else SettingScreen(modifier = modifier,
            userViewModel = userViewModel,
            exerciseViewModel = exerciseViewModel)

    }
}

@Composable
fun ExerciseScreen(modifier: Modifier, exerciseViewModel: ExerciseViewModel, userViewModel: AuthenticationViewModel) {
    Column(modifier = modifier.verticalScroll(rememberScrollState())) {
        exerciseViewModel.exercises.value.map {
            val duration = if (it.duration == null) "Not Started" else it.duration.toDuration(DurationUnit.SECONDS)
            ListItem(headlineContent = { Text(
                it.exercise.name +
                        " [${it.exercise.measurement}]" +
                        " of ${exerciseViewModel.exerciseType.value[it.exercise.exerciseTypeId]} type")
            }, supportingContent = { Text("$duration") })
        }
    }
}

@Composable
fun SettingScreen(modifier: Modifier, userViewModel: AuthenticationViewModel, exerciseViewModel: ExerciseViewModel) {
    Column(modifier) {
        Text("Name: ${userViewModel.user.value.name}")
        Text("Token: ${userViewModel.token.value}")
        TextButton(onClick = { userViewModel.logOut() }) {
            Text("Clear token")
        }
    }
}