<?php

namespace App\Http\Requests\Journal;

use Illuminate\Foundation\Http\FormRequest;

class AbsenceRequest extends FormRequest
{
    public function rules()
    {
        return [
            'user_id'    => 'required|integer',
            'id'         => 'sometimes|integer',
            'from'       => 'required|date',
            'to'         => 'nullable|date',
            'reason_id'  => 'sometimes|integer',
            'massage'    => 'required|string'
        ];
    }
}
