<?php

namespace App\Services;

use App\Models\Achievement;
use App\Models\Education;
use App\Models\Experience;
use App\Models\Profile;
use App\Models\Project;
use App\Models\Skill;
use Illuminate\Support\Facades\Auth;

class AnalyticsService
{
    public function get(): array
    {
        $userId = Auth::id();

        $profileCompletion = 0;

        if (Profile::where('user_id', $userId)->exists()) {
            $profileCompletion += 20;
        }

        if (Education::where('user_id', $userId)->exists()) {
            $profileCompletion += 20;
        }

        if (Experience::where('user_id', $userId)->exists()) {
            $profileCompletion += 20;
        }

        if (Skill::where('user_id', $userId)->exists()) {
            $profileCompletion += 20;
        }

        if (Project::where('user_id', $userId)->exists()) {
            $profileCompletion += 10;
        }

        if (Achievement::where('user_id', $userId)->exists()) {
            $profileCompletion += 10;
        }

        return [
            'profile_completion' => $profileCompletion,
            'resume_score' => 80,
            'interview_score' => 75,
            'learning_progress' => 60,
            'career_readiness' => intval(
                ($profileCompletion + 80 + 75 + 60) / 4
            ),
        ];
    }
}