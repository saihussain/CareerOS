<?php

namespace App\Core\AI;

use Exception;

class ResponseValidator
{
    public function validate(array $response): array
    {
        $required = [

            'evaluation',

            'strengths',

            'weaknesses',

            'missing_skills',

            'recommended_skills',

            'recommended_projects',

            'learning_roadmap',

            'interview_topics',

            'priority_actions',

        ];

        foreach ($required as $key) {

            if (! array_key_exists($key, $response)) {

                throw new Exception("AI response missing '{$key}'.");

            }

        }

        return $response;
    }
}