<?php

namespace App\Http\Controllers;

use App\Models\DishesType;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Order;

class DiagramController extends Controller
{
    public function getInfoForDiagram(Request $request)
    {
        if (empty($request->date)) return response()->json('выберите дату');

        if (empty($request->dateSecondInRange)) return response()->json('выберите диапазон');

        if (empty($request->dish_type)) return response()->json('выберите тип блюда');

        $ordersInfo = [];
        $getDate = Carbon::parse($request->date)->format('Y-m-d');
        $getDateSecond = Carbon::parse($request->dateSecondInRange)->format('Y-m-d');
        $dish_type = $request->dish_type;

        $orders = Order::with('dishes')
            ->whereBetween('date', [$getDate, $getDateSecond])
            ->get();

        foreach ($orders as $userOrder) {
            $userOrderDishes = $userOrder->dishes->where('type_id', $dish_type)->groupBy('id');
            if (empty($userOrderDishes)) continue;

            foreach ($userOrderDishes as $orderDishes) {
                $dishInfo = $orderDishes->first();
                $dishInfo->count = $orderDishes->count();

                if (!empty($ordersInfo[$dishInfo->id])) $dishInfo->count += $ordersInfo[$dishInfo->id]->count;
                $ordersInfo[$dishInfo->id] = $dishInfo;
            }
        }

        $nameCount[] = ['name', 'count'];
        foreach ($ordersInfo as $key => $item) {
            $nameCount[] = [
                $item->name,
                $item->count
            ];
        }

        return response()->json([
            'ordersInfo' => $nameCount,
        ]);
    }

    public function getDishTypeForDiagram()
    {
        return json_encode(DishesType::all('id', 'name'));
    }
}