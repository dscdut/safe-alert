import { Module } from 'packages/handler/Module';
import { ContactController } from './contact.controller';
import { distance, emergencyId, latitude, longitude } from 'core/common/swagger';

export const ContactResolver = Module.builder()
    .addPrefix({
        prefixPath: '/contacts',
        tag: 'contacts',
        module: 'ContactModule',
    })
    .register([
        {
            route: '/:emergencyId/findContactsByEmergencyId',
            method: 'get',
            controller: ContactController.findContactsByEmergencyId,
            params: [emergencyId],
            preAuthorization: true,
        },
        {
            route: '/:emergencyId/findGroupTeamByScope',
            method: 'get',
            controller: ContactController.findGroupTeamByScope,
            params: [emergencyId, distance, latitude, longitude],
            preAuthorization: true,
        },
    ]);
