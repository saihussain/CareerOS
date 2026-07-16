<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('interview_sessions', function (Blueprint $table) {

            $table->id();

            $table->foreignId('user_id')
                ->constrained()
                ->cascadeOnDelete();

            $table->string('target_role');

            $table->enum('interview_type', [
                'HR',
                'Technical',
                'Mixed',
            ]);

            $table->enum('difficulty', [
                'Easy',
                'Medium',
                'Hard',
            ]);

            $table->integer('current_question')
                ->default(1);

            $table->integer('score')
                ->default(0);

            $table->json('answers')
                ->nullable();

            $table->json('result')
                ->nullable();

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('interview_sessions');
    }
};