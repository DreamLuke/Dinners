<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Models\Order;

class Dish extends Model
{
    public function orders() {
        return $this->belongsToMany('App\Order', 'orders_to_dishes', 'dish_id','order_id');
    }
}
