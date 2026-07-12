<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProjectRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'tech_stack' => 'required|string|max:255',
            'github_url' => 'nullable|url',
            'live_url' => 'nullable|url',
            'start_date' => 'required|date',
            'status' => 'required|in:Planning,In Progress,Completed,On Hold',
        ];
    }
}