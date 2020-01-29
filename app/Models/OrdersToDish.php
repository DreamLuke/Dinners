<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrdersToDish extends Model
{
    public function dishes()
    {
        //у заказа может быть несколько блюд
        return $this->belongsTo('App\Models\Dish');
    }

    public function order()
    {
        return $this->belongsTo('App\Models\Order');
    }
}
