<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\AnalyticsService;
use Illuminate\Http\JsonResponse;

class AnalyticsController extends Controller
{
    public function __construct(
        protected AnalyticsService $analyticsService
    ) {}

    public function index(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'data' => $this->analyticsService->get(),
        ]);
    }
}