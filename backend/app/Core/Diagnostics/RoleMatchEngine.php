<?php

namespace App\Core\Diagnostics;

class RoleMatchEngine
{
    public static function analyze(array $analysis): array
    {
        $recommended = count(
            $analysis['recommended_skills']
        );

        $missing = count(
            $analysis['missing_skills']
        );

        if (($recommended + $missing) == 0) {

            return [

                'score' => 0,

                'status' => 'Unknown',

                'matched_skills' => 0,

                'missing_skills' => 0

            ];

        }

        $matched = max(
            $recommended - $missing,
            0
        );

        $score = round(

            ($matched / $recommended) * 100

        );

        return [

            'score' => min($score,100),

            'status' => match(true){

                $score>=90=>'Excellent',

                $score>=75=>'Good',

                $score>=60=>'Average',

                default=>'Poor'

            },

            'matched_skills'=>$matched,

            'missing_skills'=>$missing

        ];
    }
}