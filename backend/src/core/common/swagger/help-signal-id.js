import { SwaggerDocument } from '../../../packages/swagger';

export const helpSignalId = SwaggerDocument.ApiParams({
    name: 'helpSignalId',
    paramsIn: 'path',
    type: 'integer',
    description: 'Help Signal Id',
    required: true,
});
