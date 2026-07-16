<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class InterviewSession extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'target_role',
        'interview_type',
        'difficulty',
        'current_question',
        'score',
        'answers',
        'result',
    ];

    protected $casts = [
        'answers' => 'array',
        'result' => 'array',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}