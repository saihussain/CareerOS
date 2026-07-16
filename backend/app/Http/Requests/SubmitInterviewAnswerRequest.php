<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SubmitInterviewAnswerRequest extends FormRequest
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

            'session_id' => [
                'required',
                'exists:interview_sessions,id',
            ],

            'question_number' => [
                'required',
                'integer',
                'min:1',
            ],

            'answer' => [
                'required',
                'string',
                'min:3',
            ],

        ];
    }
}