<?php

namespace App\Interview;

class InterviewService
{
    /**
     * Generate the first interview question.
     */
    public function firstQuestion(
        string $role,
        string $type,
        string $difficulty
    ): array {

        return [

            'question_number' => 1,

            'question' => match ($type) {

                'HR' =>
                    'Tell me about yourself.',

                'Technical' =>
                    "Explain your experience with {$role}.",

                default =>
                    "Introduce yourself and explain why you chose {$role}.",

            },

        ];
    }

    /**
     * Get next interview question.
     */
    public function nextQuestion(
        int $questionNumber
    ): array {

        $questions = [

            2 => 'What are your strengths?',

            3 => 'Describe a challenging project you worked on.',

            4 => 'How do you debug an application?',

            5 => 'Why should we hire you?',

        ];

        return [

            'question_number' => $questionNumber,

            'question' => $questions[$questionNumber]
                ?? 'Interview completed.',

        ];
    }

    /**
     * Evaluate answer.
     * (Temporary mock implementation)
     */
    public function evaluate(
        string $answer
    ): array {

        $score = strlen(trim($answer)) >= 50
            ? rand(75, 95)
            : rand(45, 70);

        return [

            'score' => $score,

            'feedback' => $score >= 75
                ? 'Good answer. Keep providing structured examples.'
                : 'Answer needs more detail and confidence.',

        ];
    }
}