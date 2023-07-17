<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
Use App\Http\Controllers\Api\CommandesController;
Use App\Http\Controllers\Api\ProduitsController;


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
//Commandes Routes
Route::get('/commandes' , [CommandesController::class,'index']); //Get All Commandes
Route::get('/commandes/{commande}' , [CommandesController::class,'GetCommandeByID']); //Single Commande
Route::post('/commandes/create' , [CommandesController::class,'create']); //Create Commande
Route::put('/commandes/update/{commande}' , [CommandesController::class,'update']); //Update Commande
Route::delete('/commandes/delete/{commande}' , [CommandesController::class,'delete']); //delete Commande
//-----------------------------------------------------------------------------------//

//Produits Routes
Route::get('/commandes' , [CommandesController::class,'index']); //Get All Commandes
Route::get('/commandes/{commande}' , [CommandesController::class,'GetCommandeByID']); //Single Commande
Route::post('/commandes/create' , [CommandesController::class,'create']); //Create Commande
Route::put('/commandes/update/{commande}' , [CommandesController::class,'update']); //Update Commande
Route::delete('/commandes/delete/{commande}' , [CommandesController::class,'delete']); //delete Commande

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
