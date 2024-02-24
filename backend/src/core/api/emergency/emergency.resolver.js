import { Module } from 'packages/handler/Module';
import { EmergencyController } from './emergency.controller';

export const EmergencyResolver = Module.builder()
    .addPrefix({
        prefixPath: '/emergency',
        tag: 'emergency',
        module: 'emergency',
    })
    .register([
        {
            route: '/getAllEmergency',
            method: 'get',
            controller: EmergencyController.getAllEmergency,
            preAuthorization: true,
        },

    ]);
