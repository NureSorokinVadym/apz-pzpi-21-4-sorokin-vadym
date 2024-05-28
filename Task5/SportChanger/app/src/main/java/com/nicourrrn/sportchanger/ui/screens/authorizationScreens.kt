package com.nicourrrn.sportchanger.ui.screens

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material3.BottomAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.navigation.NavController
import androidx.navigation.Navigation.findNavController
import com.nicourrrn.sportchanger.application.AuthenticationViewModel
import org.koin.androidx.compose.koinViewModel

enum class AuthType {
    Login, Registration
}

@Composable
fun AuthorizationScreen(viewModel: AuthenticationViewModel = koinViewModel()) {
    var screen = remember { mutableStateOf(AuthType.Login) }

    SideEffect {
        viewModel.findToken()
    }

    Scaffold(
        bottomBar = {
            NavigationBar {
                NavigationBarItem(selected = screen.value == AuthType.Login, onClick = { screen.value = AuthType.Login },
                    icon = { Icon(Icons.Filled.CheckCircle, "Login") })
                NavigationBarItem(selected = screen.value == AuthType.Registration, onClick = { screen.value = AuthType.Registration },
                    icon = { Icon(Icons.Filled.AccountCircle, "Registration") })
            }
        }
    ) {padding ->
        val modifier = Modifier
            .padding(padding)
            .fillMaxSize()
        if (screen.value == AuthType.Login)
            LoginScreen(modifier, viewModel)
        else RegistrationScreen(modifier, viewModel)

        }
}

@Composable
fun LoginScreen(modifier: Modifier, viewModel: AuthenticationViewModel = koinViewModel()) {
    Column(modifier, horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        TextField(value = viewModel.user.value.email,
            onValueChange = { viewModel.updateUserMain(email = it) },
            label = { Text("Email") })
        TextField(value = viewModel.user.value.password ?: ""  ,
            onValueChange = {viewModel.updateUserMain(password = it)},
            label = { Text("Password") })
        TextButton(onClick = { viewModel.login() }) {
            Text("Log in")
        }
    }
}

@Composable
fun RegistrationScreen(modifier: Modifier, viewModel: AuthenticationViewModel = koinViewModel()) {
    Column(modifier, horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
        TextField(value = viewModel.user.value.email,
            onValueChange = { viewModel.updateUserMain(email = it) },
            label = { Text("Email") })
        TextField(value = viewModel.user.value.name ?: "",
            onValueChange = {viewModel.updateUserAdditional(name = it)}, label = { Text("Name") })
        TextField(value = viewModel.user.value.surname ?: "",
            onValueChange = {viewModel.updateUserAdditional(surname = it)}, label = { Text("Surname") })
        TextField(value = viewModel.user.value.password ?: ""  ,
            onValueChange = {viewModel.updateUserMain(password = it)},
            label = { Text("Password") })
        TextButton(onClick = { viewModel.registration() }) {
            Text("Registration")
        }
    }
}