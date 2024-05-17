<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\restaurant_products;
use DB;

class ResProController extends Controller
{
    //
     //
     public function index()
     {
         $restaurantProducts = restaurant_products::all()
         ->groupBy('restaurant_name')
         ->map(function ($items) {
             return $items->pluck('product_name')->unique();
         });

         return response()->json($restaurantProducts);
     }
}
