<?php

namespace App\Core\Scoring;

class WeightResolver
{
    public static function weights(): array
    {
        return [

            'summary' => 10,

            'skills' => 25,

            'projects' => 20,

            'experience' => 20,

            'education' => 10,

            'ats' => 5,

            'role_match' => 10

        ];
    }
}