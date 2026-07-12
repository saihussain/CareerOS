<?php
use App\Http\Controllers\Api\EducationController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProfileController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/me', [AuthController::class, 'me']);
    Route::post('/logout', [AuthController::class, 'logout']);
    
    Route::post('/profile', [ProfileController::class, 'store']);
    Route::get('/profile', [ProfileController::class, 'show']);
    Route::put('/profile', [ProfileController::class, 'update']);

    Route::post('/education', [EducationController::class, 'store']);
Route::get('/education', [EducationController::class, 'index']);
Route::put('/education/{education}', [EducationController::class, 'update']);
Route::delete('/education/{education}', [EducationController::class, 'destroy']);
});
