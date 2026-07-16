<?php

namespace App\Services;

class InterviewService
{
    public function firstQuestion(
        string $role,
        string $type,
        string $difficulty
    ): string {

        return "Tell me about yourself and why you want to become a {$role}.";
    }

    public function nextQuestion(
        int $questionNumber
    ): string {

        $questions = [

            2 => "Explain one project you have worked on.",

            3 => "What are your biggest strengths?",

            4 => "How would you solve a difficult technical problem?",

            5 => "Why should we hire you?",

        ];

        return $questions[$questionNumber]
            ?? "Thank you.";
    }

    public function evaluate(
        string $answer
    ): array {

        $length = strlen(trim($answer));

        $score = min(
            100,
            max(
                20,
                intval($length / 3)
            )
        );

        return [

            "score" => $score,

            "feedback" =>
                $score >= 80
                    ? "Excellent answer."
                    : ($score >= 60
                        ? "Good answer. Add more technical details."
                        : "Answer is too short. Try explaining with examples."),

        ];
    }
}