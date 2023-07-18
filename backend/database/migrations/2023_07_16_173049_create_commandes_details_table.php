<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('commandes_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_demande')->constrained('commandes')->onDelete('cascade');
            $table->foreignId('produit')->constrained('produits')->onDelete('cascade');
            $table->integer('qte');
            $table->timestamps();

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('commandes_details');
    }
};
