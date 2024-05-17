<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use DB;

class ProductController extends Controller
{
    //
    public function index()
    {
        $products = Product::all();  // Fetches all products from the database
        return response()->json($products);  // Returns products as JSON
    }
}
