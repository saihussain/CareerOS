<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LearningRequest;
use App\Models\Learning;
use App\Services\LearningService;
use Illuminate\Http\JsonResponse;

class LearningController extends Controller
{
    public function __construct(
        protected LearningService $learningService
    ) {}

    public function store(LearningRequest $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => 'Learning added successfully.',
            'learning' => $this->learningService->create($request->validated()),
        ], 201);
    }

    public function index(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'learnings' => $this->learningService->getAll(),
        ]);
    }

    public function update(LearningRequest $request, Learning $learning): JsonResponse
    {
        if ($learning->user_id !== auth()->id()) {
            abort(403);
        }

        return response()->json([
            'success' => true,
            'message' => 'Learning updated successfully.',
            'learning' => $this->learningService->update(
                $learning,
                $request->validated()
            ),
        ]);
    }

    public function destroy(Learning $learning): JsonResponse
    {
        if ($learning->user_id !== auth()->id()) {
            abort(403);
        }

        $this->learningService->delete($learning);

        return response()->json([
            'success' => true,
            'message' => 'Learning deleted successfully.',
        ]);
    }
}