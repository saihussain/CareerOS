<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LearningRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'platform' => 'required|string|max:255',
            'domain' => 'required|string|max:255',
            'status' => 'required|in:In Progress,Completed',
            'started_on' => 'nullable|date',
            'completed_on' => 'nullable|date',
        ];
    }
}