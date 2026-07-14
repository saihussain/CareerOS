<?php

namespace App\Core\Diagnostics;

class SkillGapEngine
{
    public static function analyze(array $analysis): array
    {
        $candidateSkills = array_map(
            'strtolower',
            $analysis['candidate']['skills']
        );

        $requiredSkills = array_map(
            'strtolower',
            $analysis['target_role']['required_skills']
        );

        $matched = [];

        $missing = [];

        foreach ($requiredSkills as $skill) {

            if (in_array($skill, $candidateSkills)) {

                $matched[] = ucfirst($skill);

            } else {

                $missing[] = ucfirst($skill);

            }
        }

        $matchPercentage = count($requiredSkills) > 0

            ? round(

                (count($matched) / count($requiredSkills)) * 100

            )

            : 0;

        return [

            'matched_skills' => $matched,

            'missing_skills' => $missing,

            'match_percentage' => $matchPercentage,

            'critical_skills' => array_slice($missing, 0, 2),

            'optional_skills' => array_slice($missing, 2)

        ];
    }
}