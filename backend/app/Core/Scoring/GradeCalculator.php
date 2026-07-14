<?php

namespace App\Core\Scoring;

class GradeCalculator
{
    public static function grade(int $score): string
    {
        return match (true) {

            $score >= 90 => 'A+',

            $score >= 80 => 'A',

            $score >= 70 => 'B',

            $score >= 60 => 'C',

            $score >= 50 => 'D',

            default => 'F'
        };
    }
}