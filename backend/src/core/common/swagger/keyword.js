import { SwaggerDocument } from '../../../packages/swagger';

export const keyword = SwaggerDocument.ApiParams({
    name: 'keyword',
    paramsIn: 'query',
    required: false,
    type: 'string',
    description: 'keyword is used to query search',
});
