<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function show(Request $req)
    {
        $user = $req->user();
        return response()->json(['user' => $user]);
    }

    public function uploadPhoto(Request $req)
    {
        // Handle photo upload here
        return response()->json(['message' => 'Photo uploaded successfully']);
    }
}
