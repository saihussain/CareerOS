<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Core\AI\Contracts\AIProviderInterface;
use App\Core\AI\Providers\GeminiProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(
            AIProviderInterface::class,
            GeminiProvider::class
        );
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}