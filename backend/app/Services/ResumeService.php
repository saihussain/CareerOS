<?php

namespace App\Services;

use Illuminate\Support\Facades\Auth;
use App\Services\ResumeFormatterService;

class ResumeService
{
    public function __construct(
     protected ResumeFormatterService $formatter
    ) {}
    public function generate(): array
    {
        $user = Auth::user();

        $resume = [
            'header' => [
                'name' => $user->profile?->full_name,
                'email' => $user->email,
                'phone' => $user->profile?->mobile_number,
                'location' => collect([
                    $user->profile?->city,
                    $user->profile?->state,
                    $user->profile?->country,
                ])->filter()->implode(', '),
                'linkedin' => $user->profile?->linkedin_url,
                'github' => $user->profile?->github_url,
            ],
            'summary' => $user->profile?->about_me,
            'education' => $user->educations->map(function ($education) {
                return [
                    'institution' => $education->institution_name,
                    'degree' => $education->degree,
                    'field_of_study' => $education->field_of_study,
                    'start_year' => $education->start_year,
                    'end_year' => $education->end_year,
                    'cgpa' => $education->cgpa,
                    'currently_studying' => $education->currently_studying,
                ];
            }),
            'experience' => $user->experiences->map(function ($experience) {
                return [
                    'company' => $experience->company_name,
                    'job_title' => $experience->job_title,
                    'employment_type' => $experience->employment_type,
                    'location' => $experience->location,
                    'start_date' => $experience->start_date,
                    'end_date' => $experience->end_date,
                    'currently_working' => $experience->currently_working,
                    'description' => $experience->description,
                ];
            }),
            'skills' => $user->skills->map(function ($skill) {
                return [
                    'name' => $skill->skill_name,
                    'proficiency' => $skill->proficiency,
                    'experience_years' => $skill->years_of_experience,
                ];
            }),
            'projects' => $user->projects->map(function ($project) {
                return [
                    'title' => $project->title,
                    'description' => $project->description,
                    'tech_stack' => $project->tech_stack,
                    'github_url' => $project->github_url,
                    'live_url' => $project->live_url,
                    'start_date' => $project->start_date,
                    'status' => $project->status,
                ];
            }),
            'learning' => $user->learnings->map(function ($learning) {
                return [
                    'title' => $learning->title,
                    'platform' => $learning->platform,
                    'domain' => $learning->domain,
                    'status' => $learning->status,
                    'started_on' => $learning->started_on,
                    'completed_on' => $learning->completed_on,
                ];
            }),
            'achievements' => $user->achievements->map(function ($achievement) {
                return [
                    'title' => $achievement->title,
                    'organization' => $achievement->organization,
                    'type' => $achievement->achievement_type,
                    'description' => $achievement->description,
                    'date' => $achievement->achievement_date,
                ];
            }),
        ];
        return $this->formatter->format($resume);
    }
}