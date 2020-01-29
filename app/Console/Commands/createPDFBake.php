<?php

namespace App\Console\Commands;

use App\Models\StoragePDFBake;
use Illuminate\Console\Command;
use Carbon\Carbon;
use Barryvdh\DomPDF\Facade as PDF;
use App\Models\Order;
use Jenssegers\Date\Date;

class createPDFBake extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'pdf:bake';

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
        Carbon::setLocale('ru');
        $getDate = Carbon::now()->format('Y-m-d');
        Date::setLocale('ru');
        $getDateForHeadTable =  Date::parse($getDate)->format('j F');
        $orders = Order::with('dishes')
            ->where('date', $getDate)
            ->get();

        if (empty($orders)) {
            return response()->json('В эту дату не было заказов');
        }

        $ordersData = $this->prepareData($orders, true);

        $ordersInfo = $ordersData['ordersInfo'];
        $perUserInfo = $ordersData['perUserInfo'];
        ksort($perUserInfo);


        $pdf_bake = new StoragePDFBake();
        $pdf = PDF::loadView('makePDFBake', compact(['ordersInfo', 'perUserInfo', 'getDateForHeadTable']));
        $fileName = storage_path() . '\app\\' . 'public\\'. md5(new Date()) . '.pdf';
        $pdf->save($fileName);
        $pdf_bake->pdf_bake = $fileName;
        $pdf_bake->date = $getDate;

        $pdf_bake->save();
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


        //расчет общей суммы для всего заказа на выбранную дату
        foreach($ordersInfo as $orderByDish) {
            $ordersInfo['totalSum'] = number_format( $ordersInfo['totalSum'] + $orderByDish['total'], 2 );
        }

        return [
            'perUserInfo' => $perUserInfo,
            'ordersInfo' => $ordersInfo
        ];
    }
}
