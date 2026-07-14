<?php

namespace App\Services;

use App\Core\AI\AIService;

class InterviewService
{
    public function __construct(
        protected AIService $ai
    ) {}

    public function generate(
        string $resumeText,
        string $targetRole
    ): array {

        $prompt = <<<PROMPT

You are an expert technical interviewer.

Generate interview questions for the following candidate.

Target Role:
{$targetRole}

Resume:
{$resumeText}

Return ONLY JSON.

{
    "technical":[],
    "hr":[],
    "projects":[],
    "missing_skills":[]
}

PROMPT;

        return $this->ai->analyze($prompt);
    }
}