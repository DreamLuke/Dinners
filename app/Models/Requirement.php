<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Requirement extends Model
{
    public function orders()
    {
        return $this->belongsToMany('App\Models\Order', 'orders_to_requirements', 'requirement_id','order_id');
    }
}
