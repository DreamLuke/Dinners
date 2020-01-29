<?php

namespace App\Http\Controllers\Menu;

use App\Models\Dish;
use App\Models\DishesType;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class DishesTypeController extends Controller
{
    public function create(Request $request)
    {
        DishesType::create(['name' => $request->name]);
    }

    public function update(Request $request)
    {
        DishesType::findOrFail($request->id)->update(['name' => $request->name]);
    }

    public function destroy(Request $request)
    {
        return Dish::where('type_id', $request->id)->get();

        //чтобы удалить тип нужно удалить:
        // days_for_dishes
        // dishes
        // dishes_types
        // orders_to_dishes
        // dishes_to_requirements
        // orders_to_dishes
    }
}
