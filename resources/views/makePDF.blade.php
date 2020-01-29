{{--@extends('layouts.it20')--}}


<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<style>
    *{ font-family: DejaVu Sans !important;}
</style>
<div class="centr">
    <div class="logo"><img src="{{ public_path('/img/logo.png') }}" /></div>
    <div style="text-align: center; margin-left: 100px;">
        <p>Общество с ограниченной ответственностью</p>
        <p><b>«IT 2.0»</b></p>
    </div>
    <div class="border" style="overflow: hidden;">
        <div style="float: left; margin-left: 200px;">
            <p>www.aiti20.com</p>
            <p>+38 (097) 535-11-29 </p>
        </div>
        <div style="margin-left: 450px;">
            <p>mail@aiti20.com</p>
            <p>+38 (095) 900-38-00</p>
        </div>
    </div>
    <div>
    <div class="headTable"><b>Заказ на {{ $getDateForHeadTable }}</b></div>
        <table style="border:1px solid #000000;">
            <tr>
                <th class="firstColumnAll">Наименование</th>
                <th class="secondColumnAll">Цена</th>
                <th class="thirdColumnAll">Количество</th>
                <th class="fourthColumnAll">Сумма</th>
            </tr>
            @foreach($ordersInfoRequirements as $key => $item)
                @if ($key != "totalSum")
                    <tr>
                        <td class="leftText">{{ $ordersInfoRequirements[$key]['name'] }}</td>
                        <td>{{ $ordersInfoRequirements[$key]['price'] }}</td>
                        <td>{{ $ordersInfoRequirements[$key]['count'] }}</td>
                        <td>{{ $ordersInfoRequirements[$key]['total'] }}</td>
                    </tr>
                @endif
            @endforeach
            @foreach($ordersInfo as $key => $item)
                @if ($key != "totalSum")
            <tr>
                <td class="leftText">{{ $ordersInfo[$key]['name'] . ' ' . '(' . $ordersInfo[$key]['weight'] . ')'}}</td>
                <td>{{ $ordersInfo[$key]['price'] }}</td>
                <td>{{ $ordersInfo[$key]['count'] }}</td>
                <td>{{ $ordersInfo[$key]['total'] }}</td>
            </tr>
                @endif
            @endforeach
            <tr>
                <td class="leftText" colspan="3">Итого:</td>
                <td>{{ $ordersInfo['totalSum'] }}</td>
            </tr>
        </table>
            <div class="headTable"><b>Расфасовка</b></div>
            <table style="border:1px solid #000000;">
                <tr>
                    <th class="firstColumnUser">id</th>
                    <th class="secondColumnUser">Блюда</th>
                    <th class="thirdColumnUser">Сумма</th>
                </tr>
            @foreach($perUserInfo as $key => $items)
                @if ($items['totalSumUser'] != '0.00')
            <tr>
                <td>{{ $key }}</td>
                <td class="leftText">
                    @foreach($perUserInfo[$key] as $keys => $item)
                        @if ($keys != "totalSumUser")
                    <span>{{ $item['name'] . ' ' . '(' . $item['weight'] . ')' . ' ' . '-' . ' ' . $item['count'] . ' ' . 'порц.' }}</span><br>
                        @endif
                    @endforeach
                </td>
                <td>{{ $items['totalSumUser'] }}</td>
            </tr>
                @endif
            @endforeach
        </table>
    </div>
</div>

<style>
    .leftText {
        text-align: left;
        padding-left: 5px;
    }
    .centr {
        float: left;
        margin-left: 50px;
        overflow: hidden;
    }
    .border {
        border-bottom: 1px solid #000000;
    }
    table,
    th,
    tr,
    td {
        border: 1px solid #000000;
        border-spacing: initial;
        text-align: center;
    }
    table {
        width: 600px;
    }
    .headTable {
        text-align: center;
        margin-top: 40px;
        margin-bottom: 10px;
    }
    .firstColumnAll {
        width: 320px;
        text-align: center;
    }
    .secondColumnAll {
        width: 71px;
        text-align: center;
    }
    .thirdColumnAll {
        width: 128px;
        text-align: center;
    }
    .fourthColumnAll {
        width: 81px;
        text-align: center;
    }
    .firstColumnUser {
        width: 83px;
        text-align: center;
    }
    .secondColumnUser {
        width: 353px;
        text-align: center;
    }
    .thirdColumnUser {
        width: 163px;
        text-align: center;
    }
    .logo {
        position: absolute;
        width: 180px;
        height: 100px;
        margin-top: 75px;
    }
</style>
{{--@endsection--}}