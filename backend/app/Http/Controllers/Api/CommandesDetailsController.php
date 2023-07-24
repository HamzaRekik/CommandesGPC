<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Commandes_detail;

class CommandesDetailsController extends Controller
{
    function index(){
        try{
            return Commandes_detail::All();
        }catch(Exception $e){
           echo "An error occured ".$e->getMessage();
        }
        
    }


    function create(){
        try{
            $commandeDetail=Commandes_detail::create([
                "id_demande" =>request('id_demande'),
                "produit" =>request('produit'),
                "qte" =>request('qte'),

            ]);

            return response()->json($commandeDetail);
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }

    }
    function update(Commandes_detail $detail){
        try{
            $detail->update([
                "type" =>request('type'),
                "name" =>request('name'),
                
            ]);
                return "Commande Detail ".$detail->id." Updated Successfuly";
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }
       
    }

    function delete(Commandes_detail $detail){
        try{
            $detail->delete();
                return "Commande Detail ".$detail->id." Deleted Successfuly";
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         }
        
    }

    function getDetailByID(Commandes_detail $id){

        try {
            $detail = Commandes_detail::find($id);
            return $detail;
        }catch(Exception $e){
            echo "An error occured ".$e->getMessage();
         } 
    }
}
