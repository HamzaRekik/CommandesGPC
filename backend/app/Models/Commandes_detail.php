<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Commandes_detail extends Model
{
    use HasFactory;
    protected $fillable=[
        "id_demande",
        "produit",
        "qte",
    ];
}
