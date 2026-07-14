<?php

namespace App\Http\Controllers\Api;

use App\Core\CoreEngine;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use App\Http\Requests\CoreAnalysisRequest;

class CoreController extends Controller
{
    public function __construct(
        protected CoreEngine $core
    ) {}

    public function analyze(
        CoreAnalysisRequest $request
    ): JsonResponse
    {
        $analysis = $this->core->analyze(
            $request->file('resume')->getRealPath(),
            $request->target_role
        );

        return response()->json([
            'success' => true,
            'data' => $analysis,
        ]);
    }
}