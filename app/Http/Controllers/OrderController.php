<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Models\Order;
use App\Models\Dish;
use App\Models\Requirement;
use App\Models\OrdersToDish;
use App\Models\OrdersToRequirement;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class OrderController extends Controller
{
    public function index()
    {
        return Order::all();
    }

    public function store(Request $request)
    {
        // Проверка того, существует ли уже заказ на данную дату от пользователя
        $existOrder = Order::where('user_id', $request->user_id)->where('date', $request->date)->take(1)->get();

        if (count($existOrder) == 0) { // заказа не существует, создаём новый
            if (Auth::user() != null) {
                $order = new Order();
                $order->user_id = Auth::user()->id;
                $order->date = $request->date;  //date('Y-m-d');
                $order->save();

                foreach ($request->dishes_id as $dish_id) {
                    $ordersToDish = new OrdersToDish();
                    $ordersToDish->order_id = $order->id;
                    $ordersToDish->dish_id = $dish_id; // $request->dishes[$i];
                    $ordersToDish->save();
                }

                foreach ($request->requirements_id as $requirement_id) {
                    $ordersToRequirement = new OrdersToRequirement();
                    $ordersToRequirement->order_id = $order->id;
                    $ordersToRequirement->requirement_id = $requirement_id;
                    $ordersToRequirement->save();
                }

                $user = User::find(Auth::user()->id);
                $user->personalBalance = $request->personal_balance_after_order;
                $user->save();

                return ['status' => 'success'];
            }
        } else { // заказ уже существует
            return ['status' => 'alreadyExist', 'exist_order_id' => $existOrder[0]->id];
        }
    }

    public function destroy($id)
    {
        $ordersToDishes = OrdersToDish::where('order_id', $id);
        $ordersToDishes->delete();

        $ordersToRequirements = OrdersToRequirement::where('order_id', $id);
        $ordersToRequirements->delete();


        Order::where('id', $id)->delete();
    }

    public function getTodayDayOfWeek()
    {
        $today = new Carbon();
        return $today->dayOfWeek;
    }

    public function getDates()
    {
        // $carbon = new Carbon('+1 day');
        $carbonOrderDay = new Carbon();
        // $carbonOrderDay = new Carbon('+3 days');
        // $carbonOrderDay = new Carbon('+6 days');
        $weekDaysWithDates = [];

        // расчёт дня заказа в зависимости от текущего дня недели
        if ($carbonOrderDay->dayOfWeek == 5) { // пятнца заказ надо делать на понедельник
            $carbonOrderDay = $carbonOrderDay->addDays(3);

            for ($i = 1; $i <= 5; $i++) {
                $carbonOrderDay = $carbonOrderDay->addDays($i - 1);
                $weekDaysWithDates[$i] = [
                    'день недели' => $carbonOrderDay->dayOfWeek,
                    // 'число'       => $carbonOrderDay->day,
                    'число'       => $carbonOrderDay->isoFormat('DD'),
                    'месяц'       => $carbonOrderDay->isoFormat('MM'),
                    'год'         => $carbonOrderDay->year
                ];
                $carbonOrderDay = $carbonOrderDay->addDays(-($i - 1));
            }
        } else if ($carbonOrderDay->dayOfWeek == 6) { // суббота заказ надо делать на понедельник
            $carbonOrderDay = $carbonOrderDay->addDays(2);

            for ($i = 1; $i <= 5; $i++) {
                $carbonOrderDay = $carbonOrderDay->addDays($i - 1);
                $weekDaysWithDates[$i] = [
                    'день недели' => $carbonOrderDay->dayOfWeek,
                    // 'число'       => $carbonOrderDay->day,
                    'число'       => $carbonOrderDay->isoFormat('DD'),
                    'месяц'       => $carbonOrderDay->isoFormat('MM'),
                    'год'         => $carbonOrderDay->year
                ];
                $carbonOrderDay = $carbonOrderDay->addDays(-($i - 1));
            }
        } else if ($carbonOrderDay->dayOfWeek == 0) { // воскресенье заказ надо делать на понедельник
            $carbonOrderDay = $carbonOrderDay->addDays(1);

            for ($i = 1; $i <= 5; $i++) {
                $carbonOrderDay = $carbonOrderDay->addDays($i - 1);
                $weekDaysWithDates[$i] = [
                    'день недели' => $carbonOrderDay->dayOfWeek,
                    // 'число'       => $carbonOrderDay->day,
                    'число'       => $carbonOrderDay->isoFormat('DD'),
                    'месяц'       => $carbonOrderDay->isoFormat('MM'),
                    'год'         => $carbonOrderDay->year
                ];
                $carbonOrderDay = $carbonOrderDay->addDays(-($i - 1));
            }
        } else { // заказ надо делать на следующий день
            // тут задаём даты на дни, которые будут на текущей неделе
            $startDay = $carbonOrderDay->dayOfWeek;
            for ($i = $startDay; $i <= 5; $i++) {
                $carbonOrderDay = $carbonOrderDay->addDays($i - $startDay);
                $weekDaysWithDates[$i] = [
                    'день недели' => $carbonOrderDay->dayOfWeek,
                    // 'число'       => $carbonOrderDay->day,
                    'число'       => $carbonOrderDay->isoFormat('DD'),
                    'месяц'       => $carbonOrderDay->isoFormat('MM'),
                    'год'         => $carbonOrderDay->year
                ];
                $carbonOrderDay = $carbonOrderDay->addDays(-($i - $startDay));
            }
            // тут задаём даты на дни, которые будут на СЛЕДУЮЩЕЙ неделе
            for ($i = $startDay - 1; $i >= 1; $i--) {
                $carbonOrderDay = $carbonOrderDay->addDays($i + 7 - $startDay);
                $weekDaysWithDates[$i] = [
                    'день недели' => $carbonOrderDay->dayOfWeek,
                    // 'число'       => $carbonOrderDay->day,
                    'число'       => $carbonOrderDay->isoFormat('DD'),
                    'месяц'       => $carbonOrderDay->isoFormat('MM'),
                    'год'         => $carbonOrderDay->year
                ];
                $carbonOrderDay = $carbonOrderDay->addDays(-($i + 7 - $startDay));
            }
        }

        return $weekDaysWithDates;
    }

    public function getOrderSum($id)
    {
        $sum = 0;
        $ordersToDishes = OrdersToDish::where('order_id', $id)->get();
        $ordersToRequirements = OrdersToRequirement::where('order_id', $id)->get();

        foreach($ordersToDishes as $orderToDish) {
            $sum += Dish::find($orderToDish->dish_id)->price;
        }

        foreach($ordersToRequirements as $orderToRequirement) {
            $sum += Requirement::find($orderToRequirement->requirement_id)->price;
        }

        return ['sum' => $sum];
    }

    public function getOrdersToWeek()
    {
        $carbonFirstDay = new Carbon();
        $carbonSecondDay = new Carbon('+1 day');
        $carbonThirdDay = new Carbon('+2 days');
        $carbonFourthDay = new Carbon('+3 days');
        $carbonFifthDay = new Carbon('+4 days');
        $carbonSixthDay = new Carbon('+5 days');
        $carbonSeventhDay = new Carbon('+6 days');

        $carbonDaysFormatted[0] = $carbonFirstDay->year . '-' . $carbonFirstDay->isoFormat('MM') . '-' . $carbonFirstDay->day;
        $carbonDaysFormatted[1] = $carbonSecondDay->year . '-' . $carbonSecondDay->isoFormat('MM') . '-' . $carbonSecondDay->day;
        $carbonDaysFormatted[2] = $carbonThirdDay->year . '-' . $carbonThirdDay->isoFormat('MM') . '-' . $carbonThirdDay->day;
        $carbonDaysFormatted[3] = $carbonFourthDay->year . '-' . $carbonFourthDay->isoFormat('MM') . '-' . $carbonFourthDay->day;
        $carbonDaysFormatted[4] = $carbonFifthDay->year . '-' . $carbonFifthDay->isoFormat('MM') . '-' . $carbonFifthDay->day;
        $carbonDaysFormatted[5] = $carbonSixthDay->year . '-' . $carbonSixthDay->isoFormat('MM') . '-' . $carbonSixthDay->day;
        $carbonDaysFormatted[6] = $carbonSeventhDay->year . '-' . $carbonSeventhDay->isoFormat('MM') . '-' . $carbonSeventhDay->day;

        $existOrders = [];
        $existOrdersToDishes = [];
        $existOrdersToDishesTypes = [];

        $types = [];

        $existOrder = '';

        for($i = 0; $i < count($carbonDaysFormatted); $i++) {
            $existOrder = Order::where('user_id', Auth::user()->id)->where('date', $carbonDaysFormatted[$i])->take(1)->get();

            if(count($existOrder) > 0) {
                array_push($existOrders, $existOrder);
                array_push($existOrdersToDishes, OrdersToDish::where('order_id', $existOrder[0]['id'])->get());

                unset($types);
                $types = array();

                for($j = 0; $j < count($existOrdersToDishes[count($existOrdersToDishes) - 1]); $j++) {
                    array_push($types, Dish::find($existOrdersToDishes[count($existOrdersToDishes) - 1][0]['dish_id'])->only('type_id') );
                }

                if(count($types) > 0) {
                    array_push($existOrdersToDishesTypes, $types);
                }
            }
        }

        return ['existOrders' => $existOrders, 'existOrdersToDishes' => $existOrdersToDishes, 'existOrdersToDishesTypes' => $existOrdersToDishesTypes];
    }

    public function getOrderForDate(Request $request)
    {
        $order = Order::where('user_id', Auth::user()->id)->where('date', $request->date)->take(1)->get();

        // dd('order ' . $order);

        return ['order' => $order];
    }

}
