import { SwaggerDocument } from '../../../packages/swagger';

export const distance = SwaggerDocument.ApiParams({
    name: 'distance',
    paramsIn: 'query',
    required: false,
    type: 'number',
    description: 'Distance to seek support (KM)',
});
