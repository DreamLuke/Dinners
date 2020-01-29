<?php

namespace App\Http\Controllers\Menu;

use App\Http\Requests\Menu\DishAddRequest;
use App\Models\DaysForDish;
use App\Models\Dish;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

//удаление/создание/редактирование блюд
class DishesController extends Controller
{
    public function create(DishAddRequest $request)
    {
        Dish::updateOrCreate(['id' => $request->id],[
            'composition' => $request->composition,
            'name'        => $request->name,
            'price'       => $request->price,
            'calories'    => $request->calories,
            'type_id'     => $request->type,
            'weight'      => $request->count,
            'updated_at'  => date('Y-m-d H:i:s')
        ]);
    }

    public function update(Request $request)
    {
        $daysOfWeek = ['','понедельник','вторник','среда','четверг','пятница'];

        DaysForDish::deleteOrCreate([
            'day_number' => $request->day_num,
            'dish_id'    => $request->dish_id
        ], [
            'name'       => $daysOfWeek[$request->day_num],
            'day_number' => $request->day_num,
            'dish_id'    => $request->dish_id,
            'created_at' => date('Y-m-d H:i:s')
        ]);
    }

    public function destroy(Request $request)
    {
        Dish::deleteFromCollection(Dish::find($request->id)->ordersToDish);
        Dish::deleteFromCollection(Dish::find($request->id)->daysForDishes);

        if (!empty($dish = Dish::find($request->id)->dishesToRequirements)) {
            $dish->delete();
        }

        Dish::findOrFail($request->id)->delete();
    }
}
