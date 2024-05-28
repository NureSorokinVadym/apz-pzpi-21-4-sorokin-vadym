package com.nicourrrn.sportchanger

import android.annotation.SuppressLint
import android.app.Application
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.nicourrrn.sportchanger.application.AuthenticationViewModel
import com.nicourrrn.sportchanger.application.exerciseAppModule
import com.nicourrrn.sportchanger.application.userAppModule
import com.nicourrrn.sportchanger.ui.screens.AuthorizationScreen
import com.nicourrrn.sportchanger.ui.screens.UserScreen
import com.nicourrrn.sportchanger.ui.theme.SportChangerTheme
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.androidx.compose.koinViewModel
import org.koin.core.context.GlobalContext.startKoin

@Composable
fun MainScreen(authViewMode: AuthenticationViewModel = koinViewModel()) {
    val navController = rememberNavController()

    authViewMode.init(navController)

    NavHost(navController = navController, startDestination = "/authorization") {
        composable("/authorization") {
            AuthorizationScreen(authViewMode)
        }
        composable("/") {
            UserScreen(authViewMode)
        }
    }
}


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            SportChangerTheme {
                Surface(modifier = Modifier.fillMaxSize()) {
                    MainScreen()
                }
            }
        }
    }
}

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        startKoin {
            androidLogger()
            androidContext(this@MainApplication)
            modules(userAppModule, exerciseAppModule)
        }
    }
}
