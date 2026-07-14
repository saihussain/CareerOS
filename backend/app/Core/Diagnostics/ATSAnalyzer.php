<?php

namespace App\Core\Diagnostics;

class ATSAnalyzer
{
    public static function analyze(array $analysis): array
    {
        $score = 100;

        $issues = [];

        if (count($analysis['missing_skills']) > 5) {
            $score -= 10;
            $issues[] = 'Too many missing technical skills.';
        }

        if (
            isset($analysis['evaluation']['summary']) &&
            $analysis['evaluation']['summary']['rating'] === 'POOR'
        ) {
            $score -= 10;
            $issues[] = 'Professional summary needs improvement.';
        }

        if (
            isset($analysis['evaluation']['projects']) &&
            $analysis['evaluation']['projects']['rating'] === 'POOR'
        ) {
            $score -= 15;
            $issues[] = 'Projects section is weak.';
        }

        return [

            'score' => max($score, 0),

            'status' => match (true) {

                $score >= 90 => 'Excellent',

                $score >= 75 => 'Good',

                $score >= 60 => 'Average',

                default => 'Poor'
            },

            'issues' => $issues

        ];
    }
}
