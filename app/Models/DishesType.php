<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DishesType extends Model
{
    protected $fillable = ['name'];

    public function dishes()
    {
        return $this->hasMany(Dish::class, 'type_id', 'id');
    }
}
