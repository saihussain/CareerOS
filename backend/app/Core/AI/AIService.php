<?php

namespace App\Core\AI;

use App\Core\AI\Contracts\AIProviderInterface;
use App\Core\AI\ResponseValidator;

class AIService
{
    public function __construct(
        protected AIProviderInterface $provider,
        protected ResponseValidator $validator
    ) {}

    public function analyze(string $prompt): array
    {
        $response = $this->provider->generate($prompt);

        return $this->validator->validate($response);
    }
}