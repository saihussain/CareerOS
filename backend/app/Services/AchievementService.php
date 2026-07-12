<?php

namespace App\Services;

use App\Models\Achievement;
use Illuminate\Support\Facades\Auth;

class AchievementService
{
    public function create(array $data): Achievement
    {
        return Achievement::create([
            'user_id' => Auth::id(),
            ...$data,
        ]);
    }

    public function getAll()
    {
        return Achievement::where('user_id', Auth::id())
            ->latest()
            ->get();
    }

    public function update(Achievement $achievement, array $data): Achievement
    {
        $achievement->update($data);

        return $achievement;
    }

    public function delete(Achievement $achievement): void
    {
        $achievement->delete();
    }
}