<?php

namespace App\Http\Controllers\Control;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class AccessController extends Controller
{
    public function donate(Request $request)
    {
        $user = User::find($request->user);
        $user->personalBalance += !empty($request->donut) ? round($request->donut, 2):0;
        $user->save();
    }
    public function user(Request $request)
    {

        $editor = User::find($request->editor_id);
        $user = User::find($request->id);

        //если пришедший id = id авторизированного пользователя laravel
        if (Auth::user()->accessLevel === $editor->accessLevel) {

            if ($editor->accessLevel > 1) {

                if ($user->role === 'user' && $user->accessLevel === 1) {
                    $user->accessLevel = 0;
                } elseif (empty($user->role)) {
                    $user->accessLevel = 1;
                    $user->role = 'user';
                } elseif ($user->role === 'user' && $user->accessLevel === 0) {
                    $user->accessLevel = 1;
                }

            }

            if ($editor->accessLevel > 2) {

                if ($user->role === 'admin' && $user->accessLevel < 3) {
                    $user->role = 'user';
                    $user->accessLevel = 0;
                }
            }

            $user->save();
        }

    }
    public function admin(Request $request)
    {

        $editor = User::find($request->editor_id);
        $user = User::find($request->id);

        if ($editor->accessLevel > 2) {

            if ($user->role === 'user' && $user->accessLevel < 3) {

                $user->role = 'admin';
                $user->accessLevel = 2;

            } elseif ($user->role === 'admin' && $user->accessLevel < 3) {

                $user->role = 'user';
                $user->accessLevel = 1;

            } elseif (empty($user->role) && $user->accessLevel < 3) {

                $user->role = 'admin';
                $user->accessLevel = 2;
            }

            $user->save();
        }

    }
    public function profile(Request $request)
    {
        $user = User::findOrFail($request->id);

        if ($user->role === 'admin' && $user->accessLevel > 1) {

            $user->role = 'user';

        } elseif ($user->role === 'user' && $user->accessLevel > 1) {

            $user->role = 'admin';
        }
        $user->save();
    }
}