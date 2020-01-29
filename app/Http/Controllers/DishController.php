<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Dish;
use App\Models\DaysForDish;
use App\Models\DishesType;
use App\Models\DishesToRequirement;

class DishController extends Controller
{
    public function getDaysForDishes()
    {
        return DaysForDish::all();
    }

    public function getDishesTypes()
    {
        return DishesType::all();
    }

    public function getDishesToRequirements()
    {
        return DishesToRequirement::all();
    }

    public function index()
    {
        /*$daysForDishes = DaysForDish::all();
        dd($daysForDishes); die;*/
        return Dish::all();
    }
}
