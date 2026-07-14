<?php

namespace App\Core\AI\Contracts;

interface AIProviderInterface
{
    public function generate(string $prompt): array;
}