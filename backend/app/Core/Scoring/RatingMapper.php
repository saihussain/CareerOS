<?php

namespace App\Core\Scoring;

class RatingMapper
{
    public static function score(string $rating): int
    {
        return match (strtoupper($rating)) {

            'EXCELLENT' => 100,

            'GOOD' => 80,

            'AVERAGE' => 60,

            'POOR' => 40,

            'VERY_POOR' => 20,

            default => 0,
        };
    }
}