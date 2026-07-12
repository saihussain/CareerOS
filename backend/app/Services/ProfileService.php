<?php

namespace App\Services;

use App\Models\Profile;
use Illuminate\Support\Facades\Auth;

class ProfileService
{
    public function create(array $data): Profile
    {
        if (Profile::where('user_id', Auth::id())->exists()) {
            abort(409, 'Profile already exists.');
        }
        return Profile::create([
            'user_id' => Auth::id(),
            'full_name' => $data['full_name'],
            'mobile_number' => $data['mobile_number'],
            'date_of_birth' => $data['date_of_birth'],
            'gender' => $data['gender'],
            'about_me' => $data['about_me'] ?? null,
            'linkedin_url' => $data['linkedin_url'] ?? null,
            'github_url' => $data['github_url'] ?? null,
        ]);
    }

    public function get(): ?Profile
    {
        return Profile::where('user_id', Auth::id())->first();
    }

    public function update(array $data): Profile
    {
        $profile = Profile::where('user_id', Auth::id())->firstOrFail();

        $profile->update($data);

        return $profile;
    }
}