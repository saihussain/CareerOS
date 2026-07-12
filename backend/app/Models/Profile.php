<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
    protected $fillable = [
        'user_id',
        'full_name',
        'mobile_number',
        'date_of_birth',
        'gender',
        'profile_photo',
        'about_me',
        'linkedin_url',
        'github_url',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}