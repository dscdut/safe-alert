import { Module } from 'packages/handler/Module';
import { createHelpSignalInterceptor } from 'core/modules/helpSignal/interceptor';
import { helpSignalId, userId, emergencyId, uploadMediaSwagger } from 'core/common/swagger';
import { MediaInterceptor } from 'core/modules/document';
import { rescuerId } from 'core/common/swagger/rescuer-id';
import { HelpSignalController } from './helpSignal.controller';

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
            route: '/sendNoitf/:helpSignalId',
            method: 'get',
            params: [helpSignalId],
            controller: HelpSignalController.sendNotificationToUsers,
            preAuthorization: true,
        },
        {
            route: '/getAllHelpSignals',
            method: 'get',
            controller: HelpSignalController.getAllHelpSignals,
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
        },
        {
            route: '/:helpSignalId/acceptSupport',
            method: 'post',
            params: [helpSignalId],
            controller: HelpSignalController.acceptSupport,
            preAuthorization: true,
        },
        {
            route: '/:helpSignalId/cancelSupportByRescuer',
            method: 'post',
            params: [helpSignalId],
            controller: HelpSignalController.cancelSupportByRescuer,
            preAuthorization: true,
        },
        {
            route: '/:helpSignalId/cancelSupportByUser/:rescuerId',
            method: 'post',
            params: [helpSignalId, rescuerId],
            controller: HelpSignalController.cancelSupportByUser,
            preAuthorization: true,
        },
        {
            route: '/:helpSignalId/rescuerInHelpSignal',
            method: 'get',
            params: [helpSignalId],
            controller: HelpSignalController.getRescuersByHelpSignalId,
            preAuthorization: true,
        },
        {
            route: '/:helpSignalId/verifyDone',
            method: 'patch',
            params: [helpSignalId],
            controller: HelpSignalController.verifyDone,
            preAuthorization: true,
        },
        {
            route: '/:helpSignalId/verifyCancel',
            method: 'patch',
            params: [helpSignalId],
            controller: HelpSignalController.verifyCancel,
            preAuthorization: true,
        },
    ]);
