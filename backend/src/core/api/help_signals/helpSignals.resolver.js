import { Module } from 'packages/handler/Module';
import { RecordIdInterceptor } from 'core/modules/interceptor/recordId/record-id.interceptor';
import { HelpSignalController } from './helpSignals.controller';
import { helpSignalId } from '../../common/swagger/help-signal-id';

export const HelpSignalsResolver = Module.builder()
    .addPrefix({
        prefixPath: '/help-signals',
        tag: 'help-signals',
        module: 'HelpSignalModule',
    })
    .register([
        {
            route: '/:helpSignalId',
            method: 'put',
            params: [helpSignalId],
            interceptors: [RecordIdInterceptor],
            controller: HelpSignalController.updateHelpSignalByStatus,
            preAuthorization: true,
        },
    ]);
