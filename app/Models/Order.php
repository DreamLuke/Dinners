<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    public function dishes() {
        return $this->belongsToMany('App\Models\Dish', 'orders_to_dishes', 'order_id','dish_id');
    }

    public function requirements() {
        return $this->belongsToMany('App\Models\Requirement', 'orders_to_requirements', 'order_id','requirement_id');
    }

    public function orderToDish()
    {
        return $this->hasMany('App\Models\OrdersToDish');
    }

    public function orderToRequirement()
    {
        return $this->hasMany('App\Models\OrdersToRequirement');
    }
}
