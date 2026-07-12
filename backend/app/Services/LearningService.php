<?php

namespace App\Services;

use App\Models\Learning;
use Illuminate\Support\Facades\Auth;

class LearningService
{
    public function create(array $data): Learning
    {
        return Learning::create([
            'user_id' => Auth::id(),
            ...$data,
        ]);
    }

    public function getAll()
    {
        return Learning::where('user_id', Auth::id())
            ->latest()
            ->get();
    }

    public function update(Learning $learning, array $data): Learning
    {
        $learning->update($data);

        return $learning;
    }

    public function delete(Learning $learning): void
    {
        $learning->delete();
    }
}