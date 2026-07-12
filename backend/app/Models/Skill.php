<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Skill extends Model
{
    protected $fillable = [
        'user_id',
        'skill_name',
        'proficiency',
        'years_of_experience',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function skills()
 {
    return $this->hasMany(Skill::class);
 }
}