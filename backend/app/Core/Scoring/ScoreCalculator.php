<?php

namespace App\Core\Scoring;

class ScoreCalculator
{
    public static function calculate(array $evaluation): int
    {
        $weights = WeightResolver::weights();

        $score = 0;

        foreach ($weights as $section => $weight) {

            if (!isset($evaluation[$section])) {
                continue;
            }

            $rating = $evaluation[$section]['rating'];

            $numeric = RatingMapper::score($rating);

            $score += ($numeric * $weight) / 100;
        }

        return round($score);
    }
}