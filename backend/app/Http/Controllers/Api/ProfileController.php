<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProfileRequest;
use App\Services\ProfileService;
use Illuminate\Http\JsonResponse;

class ProfileController extends Controller
{
    public function __construct(
        protected ProfileService $profileService
    ) {}

    public function store(ProfileRequest $request): JsonResponse
    {
        $profile = $this->profileService->create($request->validated());

        return response()->json([
            'success' => true,
            'message' => 'Profile created successfully.',
            'profile' => $profile,
        ], 201);
    }

    public function show(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'profile' => $this->profileService->get(),
        ]);
    }

    public function update(ProfileRequest $request): JsonResponse
    {
        $profile = $this->profileService->update($request->validated());

        return response()->json([
            'success' => true,
            'message' => 'Profile updated successfully.',
            'profile' => $profile,
        ]);
    }
}