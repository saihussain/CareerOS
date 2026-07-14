<?php

namespace App\Core\AI\Providers;

use App\Core\AI\Contracts\AIProviderInterface;

class MockAIProvider implements AIProviderInterface
{
    public function generate(string $prompt): array
    {
        return [

            'evaluation' => [

                'summary' => [
                    'rating' => 'GOOD',
                    'reason' => 'Professional summary is clear and relevant.'
                ],

                'skills' => [
                    'rating' => 'GOOD',
                    'reason' => 'Technical skills match the target role.'
                ],

                'projects' => [
                    'rating' => 'EXCELLENT',
                    'reason' => 'Projects demonstrate practical experience.'
                ],

                'experience' => [
                    'rating' => 'AVERAGE',
                    'reason' => 'Relevant internship experience.'
                ],

                'education' => [
                    'rating' => 'GOOD',
                    'reason' => 'Education aligns with career goals.'
                ],

                'ats' => [
                    'rating' => 'GOOD',
                    'reason' => 'Resume structure is ATS compatible.'
                ],

                'role_match' => [
                    'rating' => 'GOOD',
                    'reason' => 'Resume matches target role reasonably well.'
                ]

            ],

            'strengths' => [
                'Strong Laravel experience',
                'Good project portfolio',
                'Clear resume structure'
            ],

            'weaknesses' => [
                'Limited cloud exposure',
                'Missing DevOps skills'
            ],

            'missing_skills' => [
                'Docker',
                'AWS',
                'Redis'
            ],

            'recommended_skills' => [
                'Docker',
                'AWS',
                'CI/CD',
                'System Design'
            ],

            'recommended_projects' => [
                'Deploy CareerOS on AWS',
                'Microservices REST API',
                'Realtime Chat Application'
            ],

            'learning_roadmap' => [
                'Docker Fundamentals',
                'AWS EC2',
                'Redis',
                'CI/CD Pipeline'
            ],

            'interview_topics' => [
                'Laravel',
                'REST APIs',
                'Authentication',
                'Database Optimization'
            ],

            'priority_actions' => [
                'Learn Docker',
                'Deploy one cloud project',
                'Improve ATS keywords'
            ]

        ];
    }
}