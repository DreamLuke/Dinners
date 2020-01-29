<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\WeekendDay;

class WorkCalendarController extends Controller
{

    public function index()
    {
        return WeekendDay::get('date');
    }

    public function store(Request $request)
    {


        $date = new WeekendDay();
        $days = [];

        $weekendDate = WeekendDay::all();
        foreach ($weekendDate as $key => $item) {
            array_push($days, $weekendDate[$key]->date);
        }

        $request2 = $request->activeDates;

        for ($i = 0; $i < count($request2); $i++) {
            foreach ($request2[$i] as $item) {
                if ($item != 'red' && in_array($item, $days) == 0) {
                    $date->date = $item;
                }
            }
        }

        $date->save();
    }
}
