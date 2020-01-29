<?php

namespace App\Http\Controllers\Journal;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\Journal\AbsenceTypeRequest;
use App\Models\Reason;

//добавление/удаление/редактирование типов причин
class AbsenceTypeController extends Controller
{
    public function create(AbsenceTypeRequest $request)
    {
        return Reason::create([
            'name'      => $request->name,
            'shortName' => $request->short
        ]);
    }

    public function update(AbsenceTypeRequest $request)
    {
        $reason = Reason::findOrFail($request->id);
        $reason->name = $request->name;
        $reason->shortName = $request->short;
        $reason->save();
    }

    public function destroy(Request $request)
    {
        Reason::findOrFail($request->id)->absences()->delete();
        Reason::findOrFail($request->id)->delete();
    }
}