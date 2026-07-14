<?php

namespace App\Services;

use Smalot\PdfParser\Parser;

class ResumeParserService
{
    public function extractText(string $path): string
    {
        $parser = new Parser();

        $pdf = $parser->parseFile($path);

        $text = $pdf->getText();

        // Clean extracted text
        $text = preg_replace('/\s+/', ' ', $text);

        return trim($text);
    }
}