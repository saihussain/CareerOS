<?php

namespace App\Core\AI\Providers;

use Exception;
use Illuminate\Support\Facades\Http;
use App\Core\AI\Contracts\AIProviderInterface;

class GeminiProvider implements AIProviderInterface
{
    public function generate(string $prompt): array
    {
        $apiKey = env('GEMINI_API_KEY');

        $url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={$apiKey}";

        $response = Http::post($url, [
            'contents' => [
                [
                    'parts' => [
                        [
                            'text' => $prompt,
                        ],
                    ],
                ],
            ],
        ]);

        if (! $response->successful()) {
            throw new Exception(
                'Gemini API Error: ' . $response->body()
            );
        }

        $text = data_get(
            $response->json(),
            'candidates.0.content.parts.0.text',
            ''
        );

        if (empty($text)) {
            throw new Exception('Gemini returned an empty response.');
        }

        // Remove Markdown code fences if Gemini returns them
        $text = preg_replace('/```json/i', '', $text);
        $text = preg_replace('/```/', '', $text);
        $text = trim($text);

        // Debug the raw AI response
        // Remove this line after we confirm the output
        dd($text);

        $decoded = json_decode($text, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception(
                'Gemini returned invalid JSON: ' . json_last_error_msg()
            );
        }

        return $decoded;
    }
}