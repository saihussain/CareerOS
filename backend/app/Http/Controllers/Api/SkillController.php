<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\SkillRequest;
use App\Models\Skill;
use App\Services\SkillService;
use Illuminate\Http\JsonResponse;

class SkillController extends Controller
{
    public function __construct(
        protected SkillService $skillService
    ) {}

    public function store(SkillRequest $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => 'Skill added successfully.',
            'skill' => $this->skillService->create($request->validated()),
        ], 201);
    }

    public function index(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'skills' => $this->skillService->getAll(),
        ]);
    }

    public function update(SkillRequest $request, Skill $skill): JsonResponse
    {
        if ($skill->user_id !== auth()->id()) {
            abort(403);
        }

        return response()->json([
            'success' => true,
            'message' => 'Skill updated successfully.',
            'skill' => $this->skillService->update($skill, $request->validated()),
        ]);
    }

    public function destroy(Skill $skill): JsonResponse
    {
        if ($skill->user_id !== auth()->id()) {
            abort(403);
        }

        $this->skillService->delete($skill);

        return response()->json([
            'success' => true,
            'message' => 'Skill deleted successfully.',
        ]);
    }
}