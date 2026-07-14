<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CoreAnalysisRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [

            'resume' => [
                'required',
                'file',
                'mimes:pdf'
            ],

            'target_role' => [
                'required',
                'string',
                'max:255'
            ],

            'job_description' => [
                'nullable',
                'string'
            ],

        ];
    }
}
