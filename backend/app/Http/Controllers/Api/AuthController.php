<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\LoginRequest;
use App\Http\Controllers\Controller;
use App\Http\Requests\RegisterRequest;
use App\Services\AuthService;
use Illuminate\Http\JsonResponse;

class AuthController extends Controller
{
    public function __construct(
        protected AuthService $authService
    ) {}

    public function register(RegisterRequest $request): JsonResponse
    {
        $result = $this->authService->register($request->validated());

        return response()->json([
            'success' => true,
            'message' => 'Registration successful.',
            'token' => $result['token'],
            'user' => $result['user'],
        ], 201);
    }
     public function login(LoginRequest $request): JsonResponse
  {
    try {
             $result = $this->authService->login($request->validated());

            return response()->json([
              'success' => true,
                'message' => 'Login successful.',
                'token' => $result['token'],
                'user' => $result['user'],
            ]);
         } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => $e->getMessage(),
        ], 401);
    }
  }
  public function me(): JsonResponse
{
    return response()->json([
        'success' => true,
        'user' => auth()->user(),
    ]);
}
public function logout(): JsonResponse
{
    auth()->user()->currentAccessToken()->delete();

    return response()->json([
        'success' => true,
        'message' => 'Logout successful.',
    ]);
}
}