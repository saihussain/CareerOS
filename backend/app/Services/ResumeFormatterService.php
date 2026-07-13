<?php

namespace App\Services;

class ResumeFormatterService
{
    public function format(array $resume): array
    {
        return [

            'header' => [
                'name' => $resume['header']['name'],
                'email' => $resume['header']['email'],
                'phone' => $resume['header']['phone'],
                'linkedin' => $resume['header']['linkedin'],
                'github' => $resume['header']['github'],
            ],

            'professional_summary' => $resume['summary'],

            'education' => $resume['education'],

            'experience' => $resume['experience'],

            'technical_skills' => $resume['skills'],

            'projects' => $resume['projects'],

            'learning' => $resume['learning'],

            'achievements' => $resume['achievements'],
        ];
    }
}