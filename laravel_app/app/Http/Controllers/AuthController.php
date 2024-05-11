<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
// app/Http/Controllers/AuthController.php


class AuthController extends Controller
{
    public function login(Request $req)
    {
        $req->validate([
            'email' => 'required|email',
            'password' => 'required|min:8',
        ]);

        if (!auth()->attempt($req->only('email', 'password'))) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        return response()->json(['message' => 'Login successful']);
    }

    public function signup(Request $req)
{
    $rules = [
        'name' => 'required|string',
        'gender' => 'nullable|in:male,female', // Assuming 'gender' is a string field with values 'male' or 'female'
        'email' => 'required|email|unique:users',
        'level' => 'nullable|in:1,2,3,4', // Assuming 'level' is an integer field with values 1, 2, 3, or 4
        'password' => 'required|min:8|confirmed',
    ];

    $validator = Validator::make($req->all(), $rules);
     // Check if the user already exists with the provided email
         if (User::where('email', $req->email)->exists()) {
        return response()->json(['message' => 'The email has already been taken.'], 409);}
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }
        
    // If the user doesn't exist, create a new user
    User::create([
        'name' => $req->name,
        'gender' => $req->gender,
        'email' => $req->email,
        'level' => $req->level,
        'password' => Hash::make($req->password),
    ]);

    return response()->json(['message' => 'Signup successful']);
}
public function checkEmail(Request $request)
{
    $request->validate([
        'email' => 'required|email',
    ]);

    // Check if the email already exists in the database
    if (User::where('email', $request->email)->exists()) {
        return response()->json(['message' => 'Email is already in use'], 409);
    }

    return response()->json(['message' => 'Email is available'], 200);
}

}
