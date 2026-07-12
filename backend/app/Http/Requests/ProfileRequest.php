<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProfileRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'full_name' => 'required|string|max:255',
            'mobile_number' => 'required|string|max:15',
            'date_of_birth' => 'required|date',
            'gender' => 'required|in:Male,Female,Other',
            'about_me' => 'nullable|string|max:1000',
            'linkedin_url' => 'nullable|url',
            'github_url' => 'nullable|url',
        ];
    }
}