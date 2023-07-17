<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Produit;

class ProduitsController extends Controller
{
    function index(){
        try{
            return Produit::All();
        }catch(Exception $e){
           echo "An error occured ".$e->getMessage();
        }
        
    }


    function create(){
        try{
            Produit::create([
                "type" =>request('type'),
                "name" =>request('name'),

            ]);
                return "Product Created Successfuly";
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }

    }
    function update(Produit $produit){
        try{
            $produit->update([
                "type" =>request('type'),
                "name" =>request('name'),
                
            ]);
                return "Product ".$produit->id." Updated Successfuly";
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }
       
    }

    function delete(Produit $produit){
        try{
            $produit->delete();
                return "Product ".$produit->id." Deleted Successfuly";
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }
        
    }

    function getProductByID(Produit $produit){

        try {
            $produit = Produit::find($produit);
            return $produit;
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         } 
    }
}