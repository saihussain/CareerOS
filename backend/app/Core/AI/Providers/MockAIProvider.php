<?php

namespace App\Core\AI\Providers;

use App\Core\AI\Contracts\AIProviderInterface;

class MockAIProvider implements AIProviderInterface
{
    public function generate(string $prompt): array
    {
        $prompt = strtolower($prompt);

        /*
        |--------------------------------------------------------------------------
        | Interview Preparation
        |--------------------------------------------------------------------------
        */

        if (str_contains($prompt, 'expert technical interviewer')) {

            return [

                'technical' => [

                    'Explain Dependency Injection in Laravel.',
                    'What are Laravel Service Providers?',
                    'Difference between PUT and PATCH?',
                    'Explain REST API Authentication.',
                    'How does Eloquent ORM work?'

                ],

                'hr' => [

                    'Tell me about yourself.',
                    'Why should we hire you?',
                    'Describe a challenge you faced during your internship.',
                    'Where do you see yourself in five years?'

                ],

                'projects' => [

                    'Explain the architecture of CareerOS.',
                    'Why did you choose Laravel?',
                    'How did you implement Resume Parsing?',
                    'How would you scale CareerOS to one million users?'

                ],

                'missing_skills' => [

                    'What is Docker?',
                    'Explain AWS EC2.',
                    'How does Redis improve performance?'

                ]

            ];
        }

        /*
        |--------------------------------------------------------------------------
        | Learning Recommendations
        |--------------------------------------------------------------------------
        */

        if (str_contains($prompt, 'senior career mentor')) {

            return [

                'skills_to_learn' => [

                    'Docker',
                    'AWS',
                    'Redis',
                    'CI/CD'

                ],

                'courses' => [

                    'Docker Mastery',
                    'AWS Cloud Practitioner',
                    'Redis Essentials',
                    'CI/CD for Beginners'

                ],

                'projects' => [

                    'Deploy CareerOS on AWS',
                    'Build a Microservices REST API',
                    'Realtime Chat Application using WebSockets'

                ],

                'certifications' => [

                    'AWS Cloud Practitioner',
                    'Docker Certified Associate'

                ]

            ];
        }

        /*
        |--------------------------------------------------------------------------
        | Resume Analysis (CORE™)
        |--------------------------------------------------------------------------
        */

        return [

            "candidate" => [

                "name" => "Sai Hussain",

                "current_role" => "Backend Developer Intern",

                "experience_years" => 2,

                "education" => [

                    [

                        "degree" => "B.Tech",

                        "field" => "Computer Science",

                        "institution" => "ABC Engineering College"

                    ]

                ],

                "skills" => [

                    "Laravel",
                    "PHP",
                    "Flutter",
                    "PostgreSQL",
                    "REST API",
                    "Git"

                ],

                "soft_skills" => [

                    "Communication",
                    "Leadership",
                    "Problem Solving"

                ],

                "projects" => [

                    "CareerOS",
                    "Student Management System"

                ]

            ],

            "target_role" => [

                "title" => "Backend Developer",

                "required_skills" => [

                    "Laravel",
                    "PHP",
                    "REST API",
                    "Docker",
                    "AWS",
                    "Redis",
                    "Git"

                ],

                "preferred_skills" => [

                    "CI/CD",
                    "Microservices",
                    "System Design"

                ]

            ],

            "analysis" => [

                "strengths" => [

                    "Strong Laravel knowledge",
                    "Good backend architecture",
                    "Solid project portfolio"

                ],

                "weaknesses" => [

                    "Limited cloud experience",
                    "No DevOps exposure"

                ],

                "missing_skills" => [

                    "Docker",
                    "AWS",
                    "Redis"

                ],

                "ats_issues" => [

                    "Add more role-specific keywords"

                ],

                "grammar_issues" => [

                ],

                "format_issues" => [

                ],

                "summary" => "Strong backend developer profile with good project experience. Improving cloud and DevOps skills will significantly increase placement opportunities."

            ]

        ];
    }
}