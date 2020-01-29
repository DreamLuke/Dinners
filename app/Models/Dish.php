<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Dish extends Model
{
    protected $fillable = [
        'id',
        'name',
        'composition',
        'price',
        'calories',
        'type_id',
        'weight',
    ];

    public function daysForDishes()
    {
        //у блюда может быть несколько дней
//        return $this->hasMany(DaysForDish::class, 'id', 'dish_id');
        return $this->hasMany(DaysForDish::class, 'dish_id');
    }

    public function dishesToRequirements()
    {
        //у блюда может быть одна тара
        return $this->hasOne('App\Models\DishesToRequirement');
    }

    public function ordersToDish()
    {
        //у блюда может быть несколько заказов
        return $this->hasMany('App\Models\OrdersToDish');
    }

    public function orders() {
        return $this->belongsToMany('App\Models\Order', 'orders_to_dishes', 'dish_id','order_id');
    }

    public static function deleteFromCollection($collection)
    {
        if (!empty($collection)) {
            foreach ($collection as $key) {
                $key->delete();
            }
        }
    }

}
