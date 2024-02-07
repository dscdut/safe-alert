import { Module } from 'packages/handler/Module';
import { createHelpSignalInterceptor } from 'core/modules/help_signal/interceptor';
import { HelpSignalController } from './help_signal.controller';
import { helpSignalId, userId, emergencyId, uploadMediaSwagger } from 'core/common/swagger';
import { MediaInterceptor } from 'core/modules/document';

export const HelpSignalResolver = Module.builder()
    .addPrefix({
        prefixPath: '/helpSignal',
        tag: 'helpSignal',
        module: 'HelpSignalModule',
    })
    .register([
        {
            route: '/',
            method: 'post',
            interceptors: [new MediaInterceptor(10), createHelpSignalInterceptor],
            body: 'createHelpSignalDto',
            params: [uploadMediaSwagger],
            consumes: ['multipart/form-data'],
            controller: HelpSignalController.createHelpSignal,
            preAuthorization: true,
        },
        {
            route: '/:helpSignalId',
            method: 'get',
            params: [helpSignalId],
            controller: HelpSignalController.findHelpSignalById,
            preAuthorization: true,
        },
        {
            route: '/:userId/helpSignalsByUserId',
            method: 'get',
            params: [userId],
            controller: HelpSignalController.findHelpSignalsByUserId,
            preAuthorization: true,
        },
        {
            route: '/:emergencyId/helpSignalByEmergencyId',
            method: 'get',
            params: [emergencyId],
            controller: HelpSignalController.findHelpSignalsByEmergencyId,
            preAuthorization: true,
        },
        {
            route: '/:helpSignalId',
            method: 'put',
            interceptors: [new MediaInterceptor(10), createHelpSignalInterceptor],
            body: 'createHelpSignalDto',
            params: [uploadMediaSwagger, helpSignalId],
            consumes: ['multipart/form-data'],
            controller: HelpSignalController.updateHelpSignal,
            preAuthorization: true,
        },
        {
            route: '/:helpSignalId',
            method: 'delete',
            params: [helpSignalId],
            controller: HelpSignalController.deleteHelpSignal,
            preAuthorization: true,
        }
    ]);
