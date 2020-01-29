<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Models\Dish;

class Order extends Model
{
    public function dishes() {
        return $this->belongsToMany('App\Dish', 'orders_to_dishes', 'order_id','dish_id');
    }
}
