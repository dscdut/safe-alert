import { Module } from 'packages/handler/Module';
import { CreateUserInterceptor, UpdateUserInterceptor, FindUserInterceptor } from 'core/modules/user/interceptor';
import { RecordIdInterceptor } from 'core/modules/interceptor/recordId/record-id.interceptor';
import { uploadMediaSwagger, RecordId } from 'core/common/swagger';
import { deviceToken } from 'core/common/swagger/device-token';
import { UserController } from './user.controller';

export const UserResolver = Module.builder()
    .addPrefix({
        prefixPath: '/users',
        tag: 'users',
        module: 'UserModule',
    })
    .register([
        {
            route: '/',
            method: 'put',
            interceptors: [UpdateUserInterceptor],
            body: 'UpdateUserDto',
            consumes: ['multipart/form-data'],
            params: [uploadMediaSwagger],
            controller: UserController.updateOne,
            preAuthorization: true,
        },
        {
            route: '/',
            method: 'post',
            interceptors: [CreateUserInterceptor],
            body: 'CreateUserDto',
            controller: UserController.createOne,
            preAuthorization: false,
        },
        {
            route: '/:id',
            method: 'get',
            params: [RecordId],
            interceptors: [RecordIdInterceptor],
            controller: UserController.findById,
            preAuthorization: true,
        },
        {
            route: '/findByPhoneNumber',
            method: 'post',
            interceptors: [FindUserInterceptor],
            body: 'FindUserDto',
            consumes: ['multipart/form-data'],
            controller: UserController.findByPhoneNumber,
            preAuthorization: true,
        },
        {
            route: '/saveToken/:deviceToken',
            method: 'post',
            params: [deviceToken],
            controller: UserController.saveToken,
            preAuthorization: true,
        }
    ]);
