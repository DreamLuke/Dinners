<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrdersToRequirement extends Model
{
	function requirements()
    {
//        return $this->belongsToMany('App\Models\Requirement', 'orders_to_requirements', 'order_id', 'requirement_id');
    }

    public function order()
    {
        return $this->belongsTo('App\Models\Order');
    }
}
