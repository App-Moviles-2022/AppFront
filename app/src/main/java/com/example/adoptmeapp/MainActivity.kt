package com.example.adoptmeapp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import com.example.adoptmeapp.controllers.activities.SignInActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

    }
    fun appInitSesion(view: View){
        val intent= Intent(this, SignInActivity::class.java).apply {  }
        startActivity(intent)
    }
}