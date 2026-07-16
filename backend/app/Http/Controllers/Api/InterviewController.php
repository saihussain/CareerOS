<?php

namespace App\Http\Controllers\Api;

use App\Models\InterviewSession;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use App\Http\Requests\StartInterviewRequest;
use App\Http\Requests\SubmitInterviewAnswerRequest;
use App\Services\InterviewService;

class InterviewController extends Controller
{
    protected InterviewService $service;

    public function __construct(InterviewService $service)
    {
        $this->service = $service;
    }

    /**
     * Start Interview
     */
    public function start(
        StartInterviewRequest $request
    ): JsonResponse
    {
        $session = InterviewSession::create([
            'user_id' => auth()->id(),
            'target_role' => $request->target_role,
            'interview_type' => $request->interview_type,
            'difficulty' => $request->difficulty,
            'current_question' => 1,
            'score' => 0,
            'answers' => [],
            'result' => null,
        ]);

        $question = $this->service->firstQuestion(
            $request->target_role,
            $request->interview_type,
            $request->difficulty
        );

        return response()->json([
            'success' => true,
            'message' => 'Interview started successfully.',
            'data' => [
                'session_id' => $session->id,
                'question' => $question,
            ],
        ]);
    }

    /**
     * Submit Answer
     */
    public function answer(
        SubmitInterviewAnswerRequest $request
    ): JsonResponse
    {
        $session = InterviewSession::findOrFail(
            $request->session_id
        );

        $answers = $session->answers ?? [];

        $answers[] = [
            'question_number' => $request->question_number,
            'answer' => $request->answer,
        ];

        $evaluation = $this->service->evaluate(
            $request->answer
        );

        $session->answers = $answers;
        $session->score = $evaluation['score'];
        $session->current_question =
            $request->question_number + 1;

        $session->save();

        if ($session->current_question > 5) {

            return response()->json([
                'success' => true,
                'completed' => true,
                'data' => [
                    'score' => $session->score,
                    'feedback' => $evaluation['feedback'],
                ],
            ]);

        }

        $nextQuestion = $this->service->nextQuestion(
            $session->current_question
        );

        return response()->json([
            'success' => true,
            'completed' => false,
            'data' => [
                'evaluation' => $evaluation,
                'next_question' => $nextQuestion,
            ],
        ]);
    }

    /**
     * End Interview
     */
    public function end(
        InterviewSession $session
    ): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => 'Interview completed.',
            'data' => [
                'score' => $session->score,
                'answers' => $session->answers,
            ],
        ]);
    }
}