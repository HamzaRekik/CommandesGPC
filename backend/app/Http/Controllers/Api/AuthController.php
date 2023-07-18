<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function sign_up(Request $request)
    {
        $data = $request->validate([
            'username' => 'required|string|unique:tb_users,username',
            'password' => 'required|string|confirmed',
            'email' => 'required|string|unique:tb_users,email',
            'first_name' => 'required|string',
            'last_name' => 'required|string'
        ]);
    
        $user = User::create([
            'username' => $data['username'],
            'password' => Hash::make($data['password']),
            'email' => $data['email'],
            'first_name' => $data['first_name'],
            'last_name' => $data['last_name']
        ]);
    
        $token = $user->createToken('apiToken')->plainTextToken;
    
        $res = [
            'user' => $user,
            'token' => $token
        ];
    
        return response($res, 201);
    }

    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'required|string',
            'password' => 'required|string'
        ]);

        $user = User::where('email', $data['email'])->first();

        if (!$user || !Hash::check($data['password'], $user->password)) {
            return response([
                'msg' => 'incorrect username or password'
            ], 401);
        }

        $token = $user->createToken('apiToken')->plainTextToken;

        $res = [
            'user' => $user,
            'token' => $token
        ];

        return response($res, 201);
    }
}
