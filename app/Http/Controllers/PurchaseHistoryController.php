<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Models\Order;
use Jenssegers\Date\Date;
use Illuminate\Support\Facades\Auth;

class PurchaseHistoryController extends Controller
{
    public function getOrderFromDate(Request $request)
    {
        if (empty($request->dateDish)) return response()->json('выберите дату');

        $getDate = Carbon::parse($request->dateDish)->format('Y-m-d');
        Date::setLocale('ru');
        $getDateForHeadTable =  Date::parse($request->dateDish)->format('j F');

        $orders = Order::with('dishes')
            ->where('date', $getDate)
            ->get();

        $requirements = Order::with('requirements')
            ->where('date', $getDate)
            ->get();

        if (empty($orders)) return response()->json('В эту дату не было заказов');

        if (empty($requirements)) return response()->json('В эту дату не было заказов');

        $ordersData = $this->prepareData($orders);

        $formattedRequirementData = $this->formatRequirementsData($requirements);

        $perUserInfo = $formattedRequirementData['perUserInfo'];
        $ordersInfoRequirements = $formattedRequirementData['ordersInfoRequirements'];

        foreach ($ordersData['perUserInfo'] as $key => $ordersDatum) {
            $ordersData['perUserInfo'][$key]['totalSumUser'] =
                number_format($ordersData['perUserInfo'][$key]['totalSumUser'] +
                    $perUserInfo[$key]['totalSumUser'], 2);
        }

        foreach($ordersInfoRequirements as $orderByDish) {
            $ordersInfoRequirements['totalSum'] = number_format( $ordersInfoRequirements['totalSum'] +
                $orderByDish['total'], 2 );
        }

        $ordersData['ordersInfo']['totalSum'] = number_format($ordersData['ordersInfo']['totalSum'] +
            $ordersInfoRequirements['totalSum'], 2);

        return response()->json([
            'ordersInfo' => $ordersData['ordersInfo'],
            'perUserInfo' => $ordersData['perUserInfo'],
            'dateOrders' => $getDateForHeadTable,
            'ordersInfoRequirements' => $ordersInfoRequirements
        ]);
    }

    public function getOrdersForBake(Request $request)
    {
        if (empty($request->dateBake)) return response()->json('выберите дату');

        $getDate = Carbon::parse($request->dateBake)->format('Y-m-d');
        Date::setLocale('ru');
        $getDateForHeadTable =  Date::parse($request->dateBake)->format('j F');
        $orders = Order::with('dishes')
            ->where('date', $getDate)
            ->get();

        if (empty($orders)) return response()->json('В эту дату не было заказов');

        $ordersData = $this->prepareData($orders, true);

        return response()->json([
            'ordersInfo' => $ordersData['ordersInfo'],
            'perUserInfo' => $ordersData['perUserInfo'],
            'dateOrders' => $getDateForHeadTable,
        ]);
    }

    private function prepareData($orders, $onlyBake = false)
    {
        $perUserInfo = [];
        $ordersInfo = [
            'totalSum' => 0,
        ];

        foreach ($orders as $userOrder) {
            $userOrderInfo = [
                'totalSumUser' => 0
            ];
            $userOrderDishes = $userOrder->dishes->groupBy('id');

            if (empty($userOrderDishes)) continue;

            foreach ($userOrderDishes as $orderDishes) {
                $dishInfo = $orderDishes->first();

                if (!$onlyBake && $dishInfo->type_id == 5) continue;

                if ($onlyBake && $dishInfo->type_id != 5) continue;

                $dishInfo->count = $orderDishes->count();
                $dishInfo->total = number_format($dishInfo->count * $dishInfo->price, 2);
                $userOrderInfo[$dishInfo->id] = $dishInfo;
                $userOrderInfo['totalSumUser'] = number_format($userOrderInfo['totalSumUser'] +
                    $dishInfo->total, 2);
                $dish = clone $dishInfo;

                if (!empty($ordersInfo[$dish->id])) $dish->count += $ordersInfo[$dish->id]->count;

                $dish->total = $dish->count * $dish->price;
                $ordersInfo[$dish->id] = $dish;
            }

            $perUserInfo[$userOrder->user_id] = $userOrderInfo;
        }

        foreach($ordersInfo as $orderByDish) {
            $ordersInfo['totalSum'] = number_format( $ordersInfo['totalSum'] + $orderByDish['total'], 2 );
        }

        return [
            'perUserInfo' => $perUserInfo,
            'ordersInfo' => $ordersInfo
        ];
    }

    private function formatRequirementsData($requirements)
    {
        $perUserInfo = [];
        $ordersInfoRequirements = [
            'totalSum' => 0,
        ];
        foreach ($requirements as $userOrders) {
            $userOrderInfos = [
                'totalSumUser' => 0
            ];
            $userOrderRequirements = $userOrders->requirements->groupBy('id');

            if (empty($userOrderRequirements)) continue;

            foreach ($userOrderRequirements as $orderRequirements) {
                $requirementsInfo = $orderRequirements->first();

                $requirementsInfo->count = $orderRequirements->count();
                $requirementsInfo->total = number_format($requirementsInfo->count *
                    $requirementsInfo->price, 2);
                $userOrderInfos[$requirementsInfo->id] = $requirementsInfo;
                $userOrderInfos['totalSumUser'] = number_format($userOrderInfos['totalSumUser'] +
                    $requirementsInfo->total, 2);
                $requirements = clone $requirementsInfo;

                if (!empty($ordersInfoRequirements[$requirements->id])) {
                    $requirements->count = number_format($requirements->count +
                        $ordersInfoRequirements[$requirements->id]->count, 2);
                }

                $requirements->total = number_format($requirements->count * $requirements->price, 2);
                $ordersInfoRequirements[$requirements->id] = $requirements;
            }
            $perUserInfo[$userOrders->user_id] = $userOrderInfos;
        }

        return [
            'perUserInfo' => $perUserInfo,
            'ordersInfoRequirements' => $ordersInfoRequirements
        ];
    }

    public function getOrderForDateByUser(Request $request)
    {
        if (empty($request->dateDish)) return response()->json('выберите дату');

        $getDate = Carbon::parse($request->dateDish)->format('Y-m-d');
        Date::setLocale('ru');
        $getDateForHeadTable =  Date::parse($request->dateDish)->format('j F');

        $orders = Order::with('dishes')
            ->where('user_id', Auth::user()->id)
            ->where('date', $getDate)
            ->get();

        // dd('orders ' . $orders);

        $requirements = Order::with('requirements')
            ->where('date', $getDate)
            ->get();

        if (empty($orders)) return response()->json('В эту дату не было заказов');

        if (empty($requirements)) return response()->json('В эту дату не было заказов');

        $ordersData = $this->prepareData($orders);

        $formattedRequirementData = $this->formatRequirementsData($requirements);
        $perUserInfo = $formattedRequirementData['perUserInfo'];
        $ordersInfoRequirements = $formattedRequirementData['ordersInfoRequirements'];

        foreach ($ordersData['perUserInfo'] as $key => $ordersDatum) {
            $ordersData['perUserInfo'][$key]['totalSumUser'] =
                number_format($ordersData['perUserInfo'][$key]['totalSumUser'] +
                    $perUserInfo[$key]['totalSumUser'], 2);
        }

        foreach($ordersInfoRequirements as $orderByDish) {
            $ordersInfoRequirements['totalSum'] = number_format( $ordersInfoRequirements['totalSum'] +
                $orderByDish['total'], 2 );
        }

        $ordersData['ordersInfo']['totalSum'] = number_format($ordersData['ordersInfo']['totalSum'] +
            $ordersInfoRequirements['totalSum'], 2);

        return response()->json([
            'ordersInfo' => $ordersData['ordersInfo'],
            'perUserInfo' => $ordersData['perUserInfo'],
            'dateOrders' => $getDateForHeadTable,
            'ordersInfoRequirements' => $ordersInfoRequirements
        ]);
    }
}