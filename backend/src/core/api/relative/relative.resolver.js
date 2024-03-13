import { Module } from 'packages/handler/Module';
import { RecordIdInterceptor } from 'core/modules/interceptor/recordId/record-id.interceptor';
import { RelativeId } from 'core/common/swagger';
import { RelativeController } from './relative.controller';

export const RelativeResolver = Module.builder()
    .addPrefix({
        prefixPath: '/relative',
        tag: 'relative',
        module: 'RelativeModule',
    })
    .register([
        {
            route: '/',
            method: 'get',
            controller: RelativeController.getAllRelative,
            preAuthorization: true,
        },
        {
            route: '/:id',
            method: 'post',
            params: [RelativeId],
            controller: RelativeController.addRelative,
            preAuthorization: true,
        },
        {
            route: '/:id',
            method: 'delete',
            params: [RelativeId],
            interceptors: [RecordIdInterceptor],
            controller: RelativeController.deleteRelative,
            preAuthorization: true,
        }
    ]);
