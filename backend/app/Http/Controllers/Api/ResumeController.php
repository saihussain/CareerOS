<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\ResumeService;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\JsonResponse;
use App\Services\ResumeAnalyzerService;

class ResumeController extends Controller
{
    public function __construct(
        protected ResumeService $resumeService,
        protected ResumeAnalyzerService $resumeAnalyzer
    ) {}

    public function generate(): JsonResponse
    {
         $resume = $this->resumeService->generate();
        return response()->json([
            'success' => true,
            'resume' => $resume,
            'analysis' => $this->resumeAnalyzer->analyze($resume),
            
        ]);
    }

    public function download()
    {
        $resume = $this->resumeService->generate();

        $pdf = Pdf::loadView('resume', [
            'resume' => $resume,
        ]);

        return $pdf->download('CareerOS_Resume.pdf');
    }
}