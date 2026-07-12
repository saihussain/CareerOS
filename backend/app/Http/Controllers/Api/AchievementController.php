<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\AchievementRequest;
use App\Models\Achievement;
use App\Services\AchievementService;
use Illuminate\Http\JsonResponse;

class AchievementController extends Controller
{
    public function __construct(
        protected AchievementService $achievementService
    ) {}

    public function store(AchievementRequest $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => 'Achievement added successfully.',
            'achievement' => $this->achievementService->create($request->validated()),
        ], 201);
    }

    public function index(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'achievements' => $this->achievementService->getAll(),
        ]);
    }

    public function update(AchievementRequest $request, Achievement $achievement): JsonResponse
    {
        if ($achievement->user_id !== auth()->id()) {
            abort(403);
        }

        return response()->json([
            'success' => true,
            'message' => 'Achievement updated successfully.',
            'achievement' => $this->achievementService->update(
                $achievement,
                $request->validated()
            ),
        ]);
    }

    public function destroy(Achievement $achievement): JsonResponse
    {
        if ($achievement->user_id !== auth()->id()) {
            abort(403);
        }

        $this->achievementService->delete($achievement);

        return response()->json([
            'success' => true,
            'message' => 'Achievement deleted successfully.',
        ]);
    }
}