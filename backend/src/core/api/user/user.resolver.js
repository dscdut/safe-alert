import { Module } from 'packages/handler/Module';
import { CreateUserInterceptor, UpdateUserInterceptor } from 'core/modules/user/interceptor';
import { RecordIdInterceptor } from 'core/modules/interceptor/recordId/record-id.interceptor';
import { UserController } from './user.controller';
import { RecordId } from '../../common/swagger/recordId';

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
    ]);
