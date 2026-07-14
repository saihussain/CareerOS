<?php

namespace App\Core\AI\Providers;

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
                            'text' => $prompt
                        ]

                    ]
                ]

            ]

        ]);

        if (! $response->successful()) {

            throw new \Exception(
                'Gemini API Error: ' . $response->body()
            );

        }

        $text = data_get(
            $response->json(),
            'candidates.0.content.parts.0.text'
        );

        return json_decode($text, true);
    }
}