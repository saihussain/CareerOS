<?php

namespace App\Services;

use App\Models\Experience;
use Illuminate\Support\Facades\Auth;

class ExperienceService
{
    public function create(array $data): Experience
    {
        return Experience::create([
            'user_id' => Auth::id(),
            ...$data
        ]);
    }

    public function getAll()
    {
        return Experience::where('user_id', Auth::id())
            ->latest()
            ->get();
    }

    public function update(Experience $experience, array $data): Experience
    {
        $experience->update($data);

        return $experience;
    }

    public function delete(Experience $experience): void
    {
        $experience->delete();
    }
}