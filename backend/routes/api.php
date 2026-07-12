<?php
use App\Http\Controllers\Api\EducationController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProfileController;
use App\Http\Controllers\Api\ExperienceController;
use App\Http\Controllers\Api\SkillController;
use App\Http\Controllers\Api\ProjectController;


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

Route::post('/experience', [ExperienceController::class, 'store']);
Route::get('/experience', [ExperienceController::class, 'index']);
Route::put('/experience/{experience}', [ExperienceController::class, 'update']);
Route::delete('/experience/{experience}', [ExperienceController::class, 'destroy']);

Route::post('/skills', [SkillController::class, 'store']);
Route::get('/skills', [SkillController::class, 'index']);
Route::put('/skills/{skill}', [SkillController::class, 'update']);
Route::delete('/skills/{skill}', [SkillController::class, 'destroy']);

Route::post('/projects', [ProjectController::class, 'store']);
Route::get('/projects', [ProjectController::class, 'index']);
Route::put('/projects/{project}', [ProjectController::class, 'update']);
Route::delete('/projects/{project}', [ProjectController::class, 'destroy']);


});
