<?php

namespace App\Core;

use App\Services\ResumeParserService;
use App\Core\AI\AIService;
use App\Core\Prompts\ResumeAnalysisPromptBuilder;
use App\Core\Scoring\ScoreCalculator;
use App\Core\Scoring\GradeCalculator;
use App\Core\Diagnostics\ATSAnalyzer;
use App\Core\Diagnostics\RoleMatchEngine;
use App\Core\Diagnostics\HiringProbabilityEngine;


class CoreEngine
{
    public function __construct(
        protected ResumeParserService $parser,
        protected AIService $ai
    ) {}

    /**
     * CORE™ Resume Analysis Engine
     */
    public function analyze(
        string $resumePath,
        string $targetRole
    ): array {

        // Step 1: Extract resume text
        $resumeText = $this->parser->extractText($resumePath);

        // Step 2: Build AI prompt
        $prompt = ResumeAnalysisPromptBuilder::build(
            $resumeText,
            $targetRole
        );

        // Step 3: Get AI analysis
        $analysis = $this->ai->analyze($prompt);

        // Step 4: Career Readiness Index (CRI)
        $careerReadinessIndex = ScoreCalculator::calculate(
            $analysis['evaluation']
        );

        // Step 5: Grade
        $grade = GradeCalculator::grade(
            $careerReadinessIndex
        );

        // Step 6: ATS Analysis
        $ats = ATSAnalyzer::analyze($analysis);

        // Step 7: Role Match Analysis
        $roleMatch = RoleMatchEngine::analyze($analysis);

        $hiringProbability = HiringProbabilityEngine::analyze(
            $careerReadinessIndex,
            $roleMatch,
            $ats
        );

        // Step 8: Final Response
        return [

            'career_readiness_index' => $careerReadinessIndex,

            'grade' => $grade,

            'ats' => $ats,

            'role_match' => $roleMatch,

            'hiring_probability' => $hiringProbability,

            'evaluation' => $analysis['evaluation'],

            'strengths' => $analysis['strengths'],

            'weaknesses' => $analysis['weaknesses'],

            'missing_skills' => $analysis['missing_skills'],

            'recommended_skills' => $analysis['recommended_skills'],

            'recommended_projects' => $analysis['recommended_projects'],

            'learning_roadmap' => $analysis['learning_roadmap'],

            'interview_topics' => $analysis['interview_topics'],

            'priority_actions' => $analysis['priority_actions']

        ];
    }
}