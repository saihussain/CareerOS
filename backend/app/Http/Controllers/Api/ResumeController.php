<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\ResumeService;
use Illuminate\Http\JsonResponse;

class ResumeController extends Controller
{
    public function __construct(
        protected ResumeService $resumeService
    ) {}

    public function generate(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'resume' => $this->resumeService->generate(),
        ]);
    }
}