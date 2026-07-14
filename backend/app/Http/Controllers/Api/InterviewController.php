<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\InterviewService;
use App\Services\ResumeParserService;

class InterviewController extends Controller
{
    public function __construct(
        protected InterviewService $interviewService,
        protected ResumeParserService $parser
    ) {}

    public function generate(Request $request)
    {
        $request->validate([
            'resume' => 'required|file|mimes:pdf,doc,docx',
            'target_role' => 'required|string|max:255'
        ]);

        $resumeText = $this->parser->extractText(
            $request->file('resume')->getRealPath()
        );

        $questions = $this->interviewService->generate(
            $resumeText,
            $request->target_role
        );

        return response()->json([
            'success' => true,
            'data' => $questions
        ]);
    }
}