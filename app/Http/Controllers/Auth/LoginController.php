<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

use Laravel\Socialite\Facades\Socialite;
use Illuminate\Support\Facades\Auth;
use App\User;
use Illuminate\Database\Eloquent;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Http\Request;


class LoginController extends Controller
{
    use AuthenticatesUsers;

    protected $redirectTo = '/';

    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function redirectToProvider($provider)
    {
        return Socialite::driver($provider)->redirect();
    }

    public function handleProviderCallback($provider)
    {
        $user = Socialite::driver($provider)->stateless()->user();


        $authUser = $this->findOrCreateUser($user, $provider);
        Auth::login($authUser, true);


        return redirect('http://localhost:8080/#/dish_order');
    }

    public function findOrCreateUser($user, $provider)
    {
        $authUser = User::where('provider_id', $user->id)->first();
        if ($authUser) {
            return $authUser;
        }
        return User::create([
            'name'               => $user->name,
            'email'              => $user->email,
            'avatar'             => $user->avatar,
            'provider'           => strtoupper($provider),
            'provider_id'        => $user->id,
            'role'               => 'user',
            'accessLevel'        => 0,
            'balance'            => 70
        ]);
    }

    public function logout()
    {
        if (Auth::logout()) {
            return 'success';
        }
    }
}
