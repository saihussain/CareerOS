<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\EducationRequest;
use App\Models\Education;
use App\Services\EducationService;
use Illuminate\Http\JsonResponse;

class EducationController extends Controller
{
    public function __construct(
        protected EducationService $educationService
    ) {}

    public function store(EducationRequest $request): JsonResponse
    {
        $education = $this->educationService->create($request->validated());

        return response()->json([
            'success' => true,
            'message' => 'Education added successfully.',
            'education' => $education,
        ], 201);
    }

    public function index(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'educations' => $this->educationService->getAll(),
        ]);
    }

    public function update(EducationRequest $request, Education $education): JsonResponse
    {
        // Security: ensure the record belongs to the logged-in user
        if ($education->user_id !== auth()->id()) {
            abort(403, 'Unauthorized.');
        }

        $education = $this->educationService->update($education, $request->validated());

        return response()->json([
            'success' => true,
            'message' => 'Education updated successfully.',
            'education' => $education,
        ]);
    }

    public function destroy(Education $education): JsonResponse
    {
        if ($education->user_id !== auth()->id()) {
            abort(403, 'Unauthorized.');
        }

        $this->educationService->delete($education);

        return response()->json([
            'success' => true,
            'message' => 'Education deleted successfully.',
        ]);
    }
}