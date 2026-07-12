<?php

namespace App\Services;

use App\Models\Skill;
use Illuminate\Support\Facades\Auth;

class SkillService
{
    public function create(array $data): Skill
    {
        return Skill::create([
            'user_id' => Auth::id(),
            ...$data,
        ]);
    }

    public function getAll()
    {
        return Skill::where('user_id', Auth::id())
            ->latest()
            ->get();
    }

    public function update(Skill $skill, array $data): Skill
    {
        $skill->update($data);

        return $skill;
    }

    public function delete(Skill $skill): void
    {
        $skill->delete();
    }
}