<?php

namespace App\Core\Models;

class CareerAnalysis
{
    public function __construct(

        public array $candidate,

        public array $targetRole,

        public array $analysis

    ) {}
}