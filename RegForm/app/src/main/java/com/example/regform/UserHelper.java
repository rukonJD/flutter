package com.example.regform;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

public class UserHelper extends SQLiteOpenHelper {

    public UserHelper(@Nullable Context context) {
        super(context, "easyfood", null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, username TEXT, email TEXT, phone TEXT, password TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS users");
        onCreate(db);
    }

    public long saveUser(User user) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues cv = new ContentValues();
        cv.put("name", user.getName());
        cv.put("username", user.getUsername());
        cv.put("email", user.getEmail());
        cv.put("phone", user.getPhone());
        cv.put("password", user.getPassword());
        long result = db.insert("users", null, cv);
        db.close();
        return result;
    }

    public boolean validateUser(String usernameOrEmail, String password) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?", new String[]{usernameOrEmail, usernameOrEmail, password});
        boolean isValid = cursor.getCount() > 0;
        cursor.close();
        db.close();
        return isValid;
    }
}