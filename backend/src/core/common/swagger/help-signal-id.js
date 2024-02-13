import { SwaggerDocument } from '../../../packages/swagger';

export const helpSignalId = SwaggerDocument.ApiParams({
    name: 'helpSignalId',
    paramsIn: 'path',
    type: 'int',
    description: 'HelpSignal Id to accept support',
});