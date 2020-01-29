<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Absenc;
use App\Models\Reason;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class AbsentInfoController extends Controller
{
    public function getAbsentInfo()
    {
        $absence = Absenc::with('reason')
            ->where('user_id', Auth::user()->id)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json(['absents' => $absence]);
    }

    public function getReasons()
    {
        return Reason::all();
    }

    public function getAbsences()
    {
        return Absenc::all();
    }

    public function store(Request $request)
    {
        $requestDate = Carbon::parse($request->date)->format('Y-m-d');

        $this->validate($request, [
            'date' => 'required',
            'text' => 'required|min:3|max:200',
            'reason_type' => 'required'
        ]);

        if(Auth::user() != null) {
            if (empty($requestDate)) return response()->json('выберите дату');

            if (empty($request->reason_type)) return response()->json('поле причина не может быть пустым');

            $start_date = Absenc::where('user_id', Auth::user()->getAuthIdentifier())->min('from');
            $middle_date = Absenc::where('user_id', Auth::user()->getAuthIdentifier())->max('from');
            $end_date = Absenc::where('user_id', Auth::user()->getAuthIdentifier())->max('to');

            if ($requestDate >= $start_date && $requestDate <= $end_date) {
                return response()->json('repeat');
            } elseif ($requestDate >= $start_date && $requestDate <= $middle_date) {
                return response()->json('repeat');
            }

            $absent = new Absenc();
            $absent->user_id = Auth::user()->id;
            $absent->reason_id = $request->reason_type;
            $absent->massage = $request->text;
            $absent->from = date('Y-m-d', strtotime($request->date));

            if (!empty($request->dateSecondInRange)) {
                $requestSecondDateInRange = Carbon::parse($request->dateSecondInRange)->format('Y-m-d');
                $absent->to = date('Y-m-d', strtotime($requestSecondDateInRange));
            }

            $absent->save();
        }
    }
}
