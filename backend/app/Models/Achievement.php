<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Achievement extends Model
{
    protected $fillable = [
        'user_id',
        'title',
        'organization',
        'achievement_type',
        'description',
        'achievement_date',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}