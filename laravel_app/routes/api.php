<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RestaurantController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ResProController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


// Route::post('/auth/register', [AuthController::class, 'register']);
// Route::post('/auth/login', [AuthController::class, 'login']);
// routes/api.php



Route::post('/login', [AuthController::class, 'login']);
Route::post('/signup', [AuthController::class, 'signup']);
Route::post('/signup/check-email', [AuthController::class, 'checkEmail']);

//Route::apiResource('restaurants', RestaurantController::class);

// Define a GET route for listing all restaurants
Route::get('/list', [RestaurantController::class, 'index']);
// Define a POST route for creating a new restaurant
Route::post('/store', [RestaurantController::class, 'store']);
// Define a GET route for listing all products
Route::get('/products', [ResProController::class, 'index']);
// Define a GET route for listing all products
Route::get('/productsss', [ProductController::class, 'index']);

Route::get('/restaurants-by-product', [RestaurantController::class, 'getRestaurantsByProduct']);

