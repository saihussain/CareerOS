<?php

namespace App\Services;

use App\Models\Project;
use Illuminate\Support\Facades\Auth;

class ProjectService
{
    public function create(array $data): Project
    {
        return Project::create([
            'user_id' => Auth::id(),
            ...$data,
        ]);
    }

    public function getAll()
    {
        return Project::where('user_id', Auth::id())
            ->latest()
            ->get();
    }

    public function update(Project $project, array $data): Project
    {
        $project->update($data);

        return $project;
    }

    public function delete(Project $project): void
    {
        $project->delete();
    }
}