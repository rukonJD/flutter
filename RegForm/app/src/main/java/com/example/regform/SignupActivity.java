package com.example.regform;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class SignupActivity extends AppCompatActivity {

    private EditText fullname, username, email, phone, password, confirmpassword;
    private UserHelper userHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);

        fullname = findViewById(R.id.fullname);
        username = findViewById(R.id.username);
        email = findViewById(R.id.email);
        phone = findViewById(R.id.phone);
        password = findViewById(R.id.password);
        confirmpassword = findViewById(R.id.confirmpassword);

        userHelper = new UserHelper(this);
    }

    public void signup(View view) {
        String name = fullname.getText().toString();
        String user = username.getText().toString();
        String mail = email.getText().toString();
        String phoneNumber = phone.getText().toString();
        String pass = password.getText().toString();
        String confirmPass = confirmpassword.getText().toString();

        if (pass.equals(confirmPass)) {
            User newUser = new User(name, user, mail, phoneNumber, pass);
            long result = userHelper.saveUser(newUser);
            if (result != -1) {
                Toast.makeText(this, "User registered successfully", Toast.LENGTH_SHORT).show();
                Intent intent = new Intent(this, LoginActivity.class);
                startActivity(intent);
                finish();
            } else {
                Toast.makeText(this, "Registration failed", Toast.LENGTH_SHORT).show();
            }
        } else {
            Toast.makeText(this, "Passwords do not match", Toast.LENGTH_SHORT).show();
        }
    }
}