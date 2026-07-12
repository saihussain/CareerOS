<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProjectRequest;
use App\Models\Project;
use App\Services\ProjectService;
use Illuminate\Http\JsonResponse;

class ProjectController extends Controller
{
    public function __construct(
        protected ProjectService $projectService
    ) {}

    public function store(ProjectRequest $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => 'Project added successfully.',
            'project' => $this->projectService->create($request->validated()),
        ], 201);
    }

    public function index(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'projects' => $this->projectService->getAll(),
        ]);
    }

    public function update(ProjectRequest $request, Project $project): JsonResponse
    {
        if ($project->user_id !== auth()->id()) {
            abort(403);
        }

        return response()->json([
            'success' => true,
            'message' => 'Project updated successfully.',
            'project' => $this->projectService->update($project, $request->validated()),
        ]);
    }

    public function destroy(Project $project): JsonResponse
    {
        if ($project->user_id !== auth()->id()) {
            abort(403);
        }

        $this->projectService->delete($project);

        return response()->json([
            'success' => true,
            'message' => 'Project deleted successfully.',
        ]);
    }
}