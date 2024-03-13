import { SwaggerDocument } from '../../../packages/swagger';

export const page = SwaggerDocument.ApiParams({
    name: 'page',
    paramsIn: 'query',
    required: false,
    type: 'number',
    description: 'get current page',
});
