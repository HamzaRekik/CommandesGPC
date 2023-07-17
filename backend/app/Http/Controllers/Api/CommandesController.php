<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Commande;

class CommandesController extends Controller
{
    function index(){
        try{
            return Commande::All();
        }catch(Exception $e){
           echo "An error occured ".$e->getMessage();
        }
        
    }


    function create(){
        try{
            Commande::create([
                "user_id" =>request('user_id'),
                "nom" =>request('nom'),
                "prenom" =>request('prenom'),
                "region" =>request('region'),
                "adresse" =>request('adresse'),
                "puissance" =>request('puissance'),
                "etat" =>request('etat'),
    
            ]);
                return "Commande Created Successfuly";
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }

    }
    function update(Commande $commande){
        try{
            $commande->update([
                "user_id" =>request('user_id'),
                "nom" =>request('nom'),
                "prenom" =>request('prenom'),
                "region" =>request('region'),
                "adresse" =>request('adresse'),
                "puissance" =>request('puissance'),
                "etat" =>request('etat'),
            ]);
                return "Commande ".$commande->id." Updated Successfuly";
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }
       
    }

    function delete(Commande $commande){
        try{
            $commande->delete();
                return "Commande ".$commande->id." Deleted Successfuly";
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }
        
    }

    function getCommandeByID(Commande $commande){

        try {
            $commande = Commande::find($commande);
            return $commande;
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         } 
    }
}
