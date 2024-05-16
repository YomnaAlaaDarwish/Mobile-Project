<?php

namespace App\Http\Controllers;

use App\Models\Restaurant;
use Illuminate\Http\Request;

class RestaurantController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Restaurant::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Validate the request data
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'latitude' => 'required|numeric|between:-90.00000000,90.00000000',
            'longitude' => 'required|numeric|between:-180.00000000,180.00000000',
            'type' => 'required|string|max:255'
        ]);

        // Create a new restaurant record in the database
        $restaurant = Restaurant::create($validated);

        // Return the newly created restaurant with a 201 HTTP status code
        return response()->json($restaurant, 201);
    }
}
