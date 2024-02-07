import { Module } from 'packages/handler/Module';
import { helpSignalId } from 'core/common/swagger';
import { RecordIdInterceptor } from 'core/modules/interceptor/recordId/record-id.interceptor';
import { HelpSignalController} from './help_signals.controller';



export const HelpSignalResolver = Module.builder()
    .addPrefix({
        prefixPath: '/help-signals',
        tag: 'help-signals',
        module: 'HelpSignalsModule',
    })
    .register([
        {
            route: '/:helpSignalId',
            method: 'put',
            params:[helpSignalId],
            interceptors: [RecordIdInterceptor],
            controller: HelpSignalController.updateHelpSignalByStatus,
            preAuthorization: true,
        }
    ]);
