<?php

namespace App\Core\Normalizers;

use App\Core\Models\CareerAnalysis;

class AnalysisNormalizer
{
    public static function normalize(array $response): CareerAnalysis
    {
        return new CareerAnalysis(

            candidate: $response['candidate'] ?? [],

            targetRole: $response['target_role'] ?? [],

            analysis: $response['analysis'] ?? []

        );
    }
}