<?php

namespace App\Services;

class ResumeAnalyzerService
{
    public function analyze(array $resume): array
    {
        $score = 0;

        $strengths = [];

        $suggestions = [];

        /*
        |--------------------------------------------------------------------------
        | Header (10)
        |--------------------------------------------------------------------------
        */

        if (
            !empty($resume['header']['name']) &&
            !empty($resume['header']['email']) &&
            !empty($resume['header']['phone'])
        ) {

            $score += 10;
            $strengths[] = 'Profile information is complete';

        } else {

            $suggestions[] = 'Complete your basic profile information';

        }

        /*
        |--------------------------------------------------------------------------
        | Professional Summary (10)
        |--------------------------------------------------------------------------
        */

        if (!empty($resume['professional_summary'])) {

            $score += 10;

        } else {

            $suggestions[] = 'Add a professional summary';

        }

        /*
        |--------------------------------------------------------------------------
        | Education (15)
        |--------------------------------------------------------------------------
        */

        if (count($resume['education']) > 0) {

            $score += 15;

        } else {

            $suggestions[] = 'Add your education details';

        }

        /*
        |--------------------------------------------------------------------------
        | Experience (15)
        |--------------------------------------------------------------------------
        */

        if (count($resume['experience']) > 0) {

            $score += 15;

        } else {

            $suggestions[] = 'Add internship or work experience';

        }

        /*
        |--------------------------------------------------------------------------
        | Skills (15)
        |--------------------------------------------------------------------------
        */

        if (count($resume['technical_skills']) >= 5) {

            $score += 15;
            $strengths[] = 'Good technical skillset';

        } else {

            $suggestions[] = 'Add more technical skills';

        }

        /*
        |--------------------------------------------------------------------------
        | Projects (20)
        |--------------------------------------------------------------------------
        */

        if (count($resume['projects']) >= 2) {

            $score += 20;
            $strengths[] = 'Strong project portfolio';

        } else {

            $suggestions[] = 'Add at least two projects';

        }

        /*
        |--------------------------------------------------------------------------
        | Learning (5)
        |--------------------------------------------------------------------------
        */

        if (count($resume['learning']) > 0) {

            $score += 5;

        }

        /*
        |--------------------------------------------------------------------------
        | Achievements (5)
        |--------------------------------------------------------------------------
        */

        if (count($resume['achievements']) > 0) {

            $score += 5;

        }

        /*
        |--------------------------------------------------------------------------
        | GitHub & LinkedIn (5)
        |--------------------------------------------------------------------------
        */

        if (
            !empty($resume['header']['github']) &&
            !empty($resume['header']['linkedin'])
        ) {

            $score += 5;

        } else {

            $suggestions[] = 'Add GitHub and LinkedIn profile links';

        }

        return [

            'score' => $score,

            'strengths' => $strengths,

            'suggestions' => $suggestions,

        ];
    }
}