<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
Use App\Http\Controllers\Api\CommandesController;
Use App\Http\Controllers\Api\ProduitsController;
Use App\Http\Controllers\Api\CommandesDetailsController;
Use App\Http\Controllers\Api\AuthController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::post('/signup', [AuthController::class, 'sign_up']);//Sign up route
Route::post('/login', [AuthController::class, 'login']);// login route


//Commandes Routes
Route::get('/commandes' , [CommandesController::class,'index']); //Get All Commandes
Route::get('/commandes/{commande}' , [CommandesController::class,'GetCommandeByID']); //Single Commande
Route::post('/commandes/create' , [CommandesController::class,'create']); //Create Commande
Route::put('/commandes/update/{commande}' , [CommandesController::class,'update']); //Update Commande
Route::delete('/commandes/delete/{commande}' , [CommandesController::class,'delete']); //delete Commande
//-----------------------------------------------------------------------------------//

//Produits Routes
Route::get('/produits' , [ProduitsController::class,'index']); //Get All Products
Route::get('/produits/{produit}' , [ProduitsController::class,'GetProductByID']); //Single Product
Route::post('/produits/create' , [ProduitsController::class,'create']); //Create Product
Route::put('/produits/update/{produit}' , [ProduitsController::class,'update']); //Update Product
Route::delete('/produits/delete/{produit}' , [ProduitsController::class,'delete']); //delete Product
//-----------------------------------------------------------------------------------//

//Commandes Details
Route::get('/c_details' , [CommandesDetailsController::class,'index']); //Get All Details
Route::get('/c_details/{id}' , [CommandesDetailsController::class,'GetDetailByID']); //Single Detail
Route::post('/c_details/create' , [CommandesDetailsController::class,'create']); //Create Detail
Route::put('/c_details/update/{detail}' , [CommandesDetailsController::class,'update']); //Update Detail
Route::delete('/c_details/delete/{detail}' , [CommandesDetailsController::class,'delete']); //delete Detail
//-----------------------------------------------------------------------------------//




Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::post('/logout', [AuthController::class, 'logout']);// Logout route
    });