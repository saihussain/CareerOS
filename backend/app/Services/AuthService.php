<?php

namespace App\Services;

use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AuthService
{
    public function register(array $data): array
    {
        return DB::transaction(function () use ($data) {

            $user = User::create([
                'email' => $data['email'],
                'password' => Hash::make($data['password']),
            ]);

            
            $token = $user->createToken('CareerOS')->plainTextToken;

            return [
                'user' => $user,
                'token' => $token,
            ];
        });
    }
    public function login(array $data): array
    {
     if (!Auth::attempt([
                'email' => $data['email'],
                 'password' => $data['password'],
     ])) {
             throw new \Exception('Invalid email or password.');
     }

     $user = Auth::user();

     // Delete old tokens (optional, keeps one active session)
     $user->tokens()->delete();

     $token = $user->createToken('CareerOS')->plainTextToken;

     return [
        'user' => $user,
        'token' => $token,
     ];
    }
}