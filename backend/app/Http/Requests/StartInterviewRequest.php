<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StartInterviewRequest extends FormRequest
{
    /**
     * Determine if the user is authorized.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Validation rules.
     */
    public function rules(): array
    {
        return [

            'target_role' => [
                'required',
                'string',
                'max:100',
            ],

            'interview_type' => [
                'required',
                'in:HR,Technical,Mixed',
            ],

            'difficulty' => [
                'required',
                'in:Easy,Medium,Hard',
            ],

        ];
    }

    /**
     * Custom validation messages.
     */
    public function messages(): array
    {
        return [
            'target_role.required' => 'Target role is required.',
            'interview_type.required' => 'Interview type is required.',
            'difficulty.required' => 'Difficulty is required.',
        ];
    }
}