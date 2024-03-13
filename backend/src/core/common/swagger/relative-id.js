import { SwaggerDocument } from '../../../packages/swagger';

export const RelativeId = SwaggerDocument.ApiParams({
    name: 'id',
    paramsIn: 'path',
    type: 'integer',
    description: 'Relative Id',
    required: true,
});
