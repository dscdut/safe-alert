import { LoginInterceptor } from 'core/modules/auth';
import { Module } from 'packages/handler/Module';
import { AuthController } from './auth.controller';

export const AuthResolver = Module.builder()
    .addPrefix({
        prefixPath: '/auth',
        tag: 'auth',
        module: 'AuthModule',
    })
    .register([
        {
            route: '/register',
            method: 'post',
            body: 'RegisterDto',
            controller: AuthController.register,
        },
        {
            route: '/',
            method: 'post',
            interceptors: [LoginInterceptor],
            body: 'LoginDto',
            controller: AuthController.login,
        },
    ]);
