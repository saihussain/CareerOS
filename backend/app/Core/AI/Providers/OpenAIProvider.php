<?php

namespace App\Core\AI\Providers;

use OpenAI\Laravel\Facades\OpenAI;

class OpenAIProvider
{
    public function generate(string $prompt): array
    {
        $response = OpenAI::chat()->create([

            'model' => 'gpt-5-mini',

            'messages' => [

                [
                    'role' => 'user',
                    'content' => $prompt
                ]

            ],

            'response_format' => [
                'type' => 'json_object'
            ]

        ]);

        return json_decode(

            $response->choices[0]->message->content,

            true

        );
    }
}