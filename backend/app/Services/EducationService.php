<?php

namespace App\Services;

use App\Models\Education;
use Illuminate\Support\Facades\Auth;

class EducationService
{
    public function create(array $data): Education
    {
        return Education::create([
            'user_id' => Auth::id(),
            'institution_name' => $data['institution_name'],
            'degree' => $data['degree'],
            'field_of_study' => $data['field_of_study'],
            'start_year' => $data['start_year'],
            'end_year' => $data['end_year'] ?? null,
            'cgpa' => $data['cgpa'] ?? null,
            'currently_studying' => $data['currently_studying'],
        ]);
    }

    public function getAll()
    {
        return Education::where('user_id', Auth::id())
            ->latest()
            ->get();
    }

    public function update(Education $education, array $data): Education
    {
        $education->update($data);

        return $education;
    }

    public function delete(Education $education): void
    {
        $education->delete();
    }
}