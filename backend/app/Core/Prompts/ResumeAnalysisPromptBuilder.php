<?php

namespace App\Core\Prompts;

class ResumeAnalysisPromptBuilder
{
    public static function build(
        string $resume,
        string $targetRole
    ): string {

        return <<<PROMPT

You are CareerOS AI.

Your task is to analyze the following resume for the target role.

Target Role:
{$targetRole}

Resume:
{$resume}

IMPORTANT:

Return ONLY valid JSON.

Do NOT return markdown.

Do NOT return explanation.

Do NOT wrap inside ```.

Use EXACTLY this schema.

{
  "candidate":{

      "name":"",

      "current_role":"",

      "experience_years":0,

      "education":[],

      "skills":[],

      "soft_skills":[],

      "projects":[]

  },

  "target_role":{

      "title":"",

      "required_skills":[],

      "preferred_skills":[]

  },

  "analysis":{

      "strengths":[],

      "weaknesses":[],

      "missing_skills":[],

      "ats_issues":[],

      "grammar_issues":[],

      "format_issues":[],

      "summary":""

  }

}

PROMPT;

    }
}