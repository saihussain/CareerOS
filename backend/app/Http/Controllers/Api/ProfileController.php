<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProfileRequest;
use App\Services\ProfileService;
use Illuminate\Http\JsonResponse;

class ProfileController extends Controller
{
    protected ProfileService $profileService;

    public function __construct(ProfileService $profileService)
    {
        $this->profileService = $profileService;
    }

    public function store(ProfileRequest $request): JsonResponse
    {
        $profile = $this->profileService->create($request->validated());

        return response()->json([
            'message' => 'Profile created successfully.',
            'data' => $profile,
        ], 201);
    }

    public function show(): JsonResponse
    {
        return response()->json([
            'data' => $this->profileService->get(),
        ]);
    }

    public function update(ProfileRequest $request): JsonResponse
    {
        $profile = $this->profileService->update($request->validated());

        return response()->json([
            'message' => 'Profile updated successfully.',
            'data' => $profile,
        ]);
    }
}