<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SkillRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'skill_name' => 'required|string|max:255',
            'proficiency' => 'required|in:Beginner,Intermediate,Advanced,Expert',
            'years_of_experience' => 'required|integer|min:0|max:50',
        ];
    }
}