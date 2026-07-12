<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AchievementRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'organization' => 'required|string|max:255',

            'achievement_type' => 'required|in:Competition,Award,Recognition,Scholarship,Other',

            'description' => 'nullable|string',

            'achievement_date' => 'nullable|date',
        ];
    }
}