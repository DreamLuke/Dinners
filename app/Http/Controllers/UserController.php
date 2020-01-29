<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function index()
    {
        return User::find('id', Auth::user()->id);
    }

    public function getUserInfo()
    {
        return Auth::user() ? Auth::user():null;
    }

    public function getUsers()
    {
        return User::all();
    }
}
