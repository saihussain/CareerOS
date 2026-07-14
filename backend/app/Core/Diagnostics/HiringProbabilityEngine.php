<?php

namespace App\Core\Diagnostics;

class HiringProbabilityEngine
{
    public static function analyze(
        int $cri,
        array $roleMatch,
        array $ats
    ): array {

        $score = round(

            ($cri * 0.5) +

            ($roleMatch['score'] * 0.3) +

            ($ats['score'] * 0.2)

        );

        return [

            'score' => $score,

            'status' => match(true){

                $score>=85=>'Very High',

                $score>=70=>'High',

                $score>=55=>'Medium',

                default=>'Low'

            },

            'reason'=>match(true){

                $score>=85=>
                    'Excellent overall resume and strong role alignment.',

                $score>=70=>
                    'Good profile with a few improvement opportunities.',

                $score>=55=>
                    'Moderate profile. Improving missing skills can significantly increase hiring chances.',

                default=>
                    'Resume requires major improvements before applying.'

            }

        ];
    }
}