<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Learning extends Model
{
    protected $fillable = [
        'user_id',
        'title',
        'platform',
        'domain',
        'status',
        'started_on',
        'completed_on',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}