<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DaysForDish extends Model
{
    protected $fillable = ['day_number', 'dish_id', 'name'];

    public function dishes()
    {
        return $this->belongsTo(Dish::class);
    }

    public static function deleteOrCreate(array $find, array $create)
    {
        if (empty($instance = DaysForDish::where($find)->first())) {
            DaysForDish::create($create);
        } else {
            $instance->delete();
        }
    }
}