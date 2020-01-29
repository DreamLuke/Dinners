<?php

namespace App\Http\Controllers\Journal;

use App\Http\Controllers\Controller;
use App\Http\Requests\Journal\AbsenceRequest;
use App\Models\Absenc;
use Illuminate\Http\Request;

//создание/удаление/редактирование причин пользователей
class AbsenceController extends Controller
{
    public function create(AbsenceRequest $request)
    {
        return Absenc::create([
            'user_id'   => $request->user_id,
            'reason_id' => $request->reason_id,
            'massage'   => $request->massage,
            'from'      => $request->from,
            'to'        => $request->to
        ]);
    }

    public function update(AbsenceRequest $request)
    {
        return Absenc::where([
            'id'      => $request->id,
            'user_id' => $request->user_id
        ])->update([
            'massage'   => $request->massage,
            'reason_id' => $request->reason_id
        ]);
    }

    public function destroy(Request $request)
    {
        return $request;
    }
}
