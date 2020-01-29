<?php

namespace App\Console\Commands;

use Illuminate\Support\Facades\Mail;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Barryvdh\DomPDF\Facade as PDF;
use App\Models\Dish;
use Carbon\Carbon;
use App\Models\Order;
use Jenssegers\Date\Date;
use App\Models\StoragePDFDish;

class emailOrderDish extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'pdf:dish';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
//        Log::info('I was here @ ' . \Carbon\Carbon::now());

        Carbon::setLocale('ru');
        $getDate = Carbon::now()->format('Y-m-d');
        Date::setLocale('ru');
        $getDateForHeadTable =  Date::parse($getDate)->format('j F');

        $orders = Order::with('dishes')
            ->where('date', $getDate)
            ->get();

        $requirements = Order::with('requirements')
            ->where('date', $getDate)
            ->get();

        $perUserInfo = [];

        $ordersInfoRequirements = [
            'totalSum' => 0,
        ];

        $ordersData = $this->prepareData($orders);

        foreach ($requirements as $userOrder2) {
            $userOrderInfo2 = [
                'totalSumUser' => 0
            ];
            $userOrderRequirements = $userOrder2->requirements->groupBy('id');
            if (empty($userOrderRequirements)) {
                continue;
            }
            foreach ($userOrderRequirements as $orderRequirements) {
                $requirementsInfo = $orderRequirements->first();

                $requirementsInfo->count = $orderRequirements->count();
                $requirementsInfo->total = $requirementsInfo->count * $requirementsInfo->price;
                $userOrderInfo2[$requirementsInfo->id] = $requirementsInfo;
                $userOrderInfo2['totalSumUser'] = number_format($userOrderInfo2['totalSumUser'] + $requirementsInfo->total, 2);
                $requirements = clone $requirementsInfo;

                if (!empty($ordersInfoRequirements[$requirements->id])) {
                    $requirements->count += $ordersInfoRequirements[$requirements->id]->count;
                }
                $requirements->total = $requirements->count * $requirements->price;
                $ordersInfoRequirements[$requirements->id] = $requirements;
            }
            $perUserInfo[$userOrder2->user_id] = $userOrderInfo2;

        }

        foreach ($ordersData['perUserInfo'] as $key => $ordersDatum) {
            $ordersData['perUserInfo'][$key]['totalSumUser'] = number_format($ordersData['perUserInfo'][$key]['totalSumUser'] + $perUserInfo[$key]['totalSumUser'], 2);
        }

        //расчет общей суммы для всего заказа на выбранную дату
        foreach($ordersInfoRequirements as $orderByDish) {
            $ordersInfoRequirements['totalSum'] = number_format( $ordersInfoRequirements['totalSum'] + $orderByDish['total'], 2 );
        }

        $ordersData['ordersInfo']['totalSum'] = number_format($ordersData['ordersInfo']['totalSum'] + $ordersInfoRequirements['totalSum'], 2);

        $ordersInfo = $ordersData['ordersInfo'];
        $perUserInfo = $ordersData['perUserInfo'];
        ksort($perUserInfo);
        $dateOrders = $getDateForHeadTable;

//        return view('makePDF', compact(['ordersInfo', 'perUserInfo', 'getDateForHeadTable']));

        $pdf_dish = new StoragePDFDish();

        $pdf = PDF::loadView('makePDF', compact(['ordersInfo', 'perUserInfo', 'getDateForHeadTable', 'ordersInfoRequirements']));


        $fileName = storage_path() . '\app\\' . 'public\\'. md5(new Date()) . '.pdf';

        $pdf->save($fileName);
//
        $pdf_dish->pdf_dish = $fileName;
        $pdf_dish->date = $getDate;
//
        $pdf_dish->save();

//        Log::info('I was here @ ' . \Carbon\Carbon::now());
//        $pdf->download('111.pdf');

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

            if (empty($userOrderDishes)) {
                continue;
            }

            //вывод наименований блюд, цены и кол-ва
            foreach ($userOrderDishes as $orderDishes) {
                $dishInfo = $orderDishes->first();

                if (!$onlyBake && $dishInfo->type_id == 5) {
                    continue;
                }

                if ($onlyBake && $dishInfo->type_id != 5) {
                    continue;
                }

                $dishInfo->count = $orderDishes->count();
                $dishInfo->total = $dishInfo->count * $dishInfo->price;
                $userOrderInfo[$dishInfo->id] = $dishInfo;
                $userOrderInfo['totalSumUser'] = number_format($userOrderInfo['totalSumUser'] + $dishInfo->total, 2);
                $dish = clone $dishInfo;

                if (!empty($ordersInfo[$dish->id])) {
                    $dish->count += $ordersInfo[$dish->id]->count;
                }

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
}
