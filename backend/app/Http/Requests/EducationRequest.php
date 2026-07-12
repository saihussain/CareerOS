<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EducationRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'institution_name' => 'required|string|max:255',
            'degree' => 'required|string|max:255',
            'field_of_study' => 'required|string|max:255',
            'start_year' => 'required|integer|min:1950|max:2100',
            'end_year' => 'nullable|integer|min:1950|max:2100',
            'cgpa' => 'nullable|numeric|min:0|max:10',
            'currently_studying' => 'required|boolean',
        ];
    }
}