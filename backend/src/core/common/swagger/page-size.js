import { SwaggerDocument } from '../../../packages/swagger';

export const size = SwaggerDocument.ApiParams({
    name: 'size',
    paramsIn: 'query',
    required: false,
    type: 'number',
    description: 'Number of items per page',
});
