<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reason extends Model
{
    protected $table = 'reasons';
    protected $fillable = ['name', 'shortName'];

    public function absenc()
    {
        return $this->belongsTo('App\Models\Absenc');
    }

    public function absences()
    {
        return $this->hasMany('App\Models\Absenc');
    }
}
