<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ExperienceRequest;
use App\Models\Experience;
use App\Services\ExperienceService;
use Illuminate\Http\JsonResponse;

class ExperienceController extends Controller
{
    public function __construct(
        protected ExperienceService $experienceService
    ) {}

    public function store(ExperienceRequest $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => 'Experience added successfully.',
            'experience' => $this->experienceService->create($request->validated()),
        ], 201);
    }

    public function index(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'experiences' => $this->experienceService->getAll(),
        ]);
    }

    public function update(ExperienceRequest $request, Experience $experience): JsonResponse
    {
        if ($experience->user_id !== auth()->id()) {
            abort(403);
        }

        return response()->json([
            'success' => true,
            'message' => 'Experience updated successfully.',
            'experience' => $this->experienceService->update($experience, $request->validated()),
        ]);
    }

    public function destroy(Experience $experience): JsonResponse
    {
        if ($experience->user_id !== auth()->id()) {
            abort(403);
        }

        $this->experienceService->delete($experience);

        return response()->json([
            'success' => true,
            'message' => 'Experience deleted successfully.',
        ]);
    }
}