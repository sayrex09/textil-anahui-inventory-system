<?php

namespace Database\Seeders;

use App\Models\Empresa;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class EmpresaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Empresa::insert([
            'nombre' => 'Textil Anahui SAC',
            'propietario' => 'Textil Anahui SACa',
            'ruc' => '20338996706',
            'porcentaje_impuesto' => '18',
            'abreviatura_impuesto' => 'IGV',
            'direccion' => 'Av. Aviacion Nro. 476 Int. 308',
            'moneda_id' => 1
        ]);
    }
}
