package com.example.regform;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class LoginActivity extends AppCompatActivity {

    private EditText usernameOrEmail, password;
    private UserHelper userHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        usernameOrEmail = findViewById(R.id.username);
        password = findViewById(R.id.password);

        userHelper = new UserHelper(this);
    }

    public void login(View view) {
        String user = usernameOrEmail.getText().toString();
        String pass = password.getText().toString();

        if (userHelper.validateUser(user, pass)) {
            Toast.makeText(this, "Login successful", Toast.LENGTH_SHORT).show();
            Intent intent = new Intent(this, HomeActivity.class);
            startActivity(intent);
            finish();
        } else {
            Toast.makeText(this, "Invalid username/email or password", Toast.LENGTH_SHORT).show();
        }
    }
}