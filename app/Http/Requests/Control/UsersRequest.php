<?php

namespace App\Http\Requests\Control;

use Illuminate\Foundation\Http\FormRequest;

class UsersRequest extends FormRequest
{
    public function rules()
    {
        return [
            'id'       => 'nullable|integer',
            'name'     => 'required|string|min:3|max:50|bail',
            'email'    => 'required|email|unique:users,email,' . $this->id . '|bail',
            'telegram' => 'required|alpha_dash|unique:users,telegram,' . $this->id .'|min:3|max:255|bail'
        ];
    }
}
