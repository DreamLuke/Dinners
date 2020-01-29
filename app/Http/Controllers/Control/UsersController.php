<?php

namespace App\Http\Controllers\Control;

use App\Models\Absenc;
use App\Models\Order;
use App\Models\OrdersToDish;
use App\Models\OrdersToRequirement;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\Control\UsersRequest;

class UsersController extends Controller
{
    public function create(UsersRequest $request)
    {
        $users = User::all();
        for ($i = 0; $i < count($users); $i++) {
            if ($users[$i]->id !== $i+1) {
                $id = $users[$i-1]->id+1;
                break;
            }
        }

        if (empty($user = User::find($request->id))) {
            User::create([
                'id'          => $id,
                'name'        => $request->name,
                'email'       => $request->email,
                'telegram'    => $request->telegram,
                'role'        => 'user',
                'accessLevel' => 1,
                'balance'     => 70
            ]);
        } else {
            $user->update([
                'name'     => $request->name,
                'email'    => $request->email,
                'telegram' => $request->telegram
            ]);
        }
    }
    public function destroy(Request $request)
    {

        $absenc = Absenc::where('user_id', $request->id)->get();
        empty($absenc) ?: $this->deleteFromCollection($absenc);

        $ordersToDish = OrdersToDish::whereHas('order', function ($query) use ($request) {
            $query->where('user_id', $request->id);
        })->get();
        empty($ordersToDish) ?:$this->deleteFromCollection($ordersToDish);

        $orderToRequirement = OrdersToRequirement::whereHas('order', function ($query) use ($request) {
            $query->where('user_id', $request->id);
        })->get();
        empty($orderToRequirement) ?:$this->deleteFromCollection($orderToRequirement);

        $order = Order::where('user_id', $request->id)->get();
        empty($order) ?:$this->deleteFromCollection($order);

        $user = User::find($request->id);
        empty($user) ?: $user->delete();

    }
    public function deleteFromCollection($collection)
    {
        foreach($collection as $item) {
            $item->delete();
        }
    }
}
