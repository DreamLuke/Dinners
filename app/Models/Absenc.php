<?php

namespace App\Models;

use http\Env\Request;
use Illuminate\Database\Eloquent\Model;

class Absenc extends Model
{
    protected $table = 'absences';
    protected $fillable = ['user_id', 'reason_id', 'massage', 'from', 'to'];

    public function reason()
    {
        return $this->hasOne('App\Models\Reason', 'id', 'reason_id');
    }

    public function reasons()
    {
        return $this->belongsTo('App\Models\Reason');
    }

    public function setFromAttribute ($data)
    {
        $this->attributes['from'] = date('Y-m-d', strtotime($data));
    }

    public function setToAttribute ($data)
    {
        $this->attributes['to'] = $data ? date('Y-m-d', strtotime($data)):null;
    }
}
