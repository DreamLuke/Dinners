<?php

namespace App\Http\Requests\Menu;

use Illuminate\Foundation\Http\FormRequest;

class DishAddRequest extends FormRequest
{
    public function rules()
    {
        return [
            'id'          => 'present|integer',
            'type'        => 'required|integer|min:1|bail',
            'name'        => 'required|string|unique:dishes,name,' . $this->id . '|min:3|max:255|bail',
            'count'       => 'required|string|min:1|bail',
            'price'       => 'required|numeric|bail',
            'calories'    => 'required|integer|min:1|bail',
            'composition' => 'required|string|min:5|max:255',
        ];
    }
}
