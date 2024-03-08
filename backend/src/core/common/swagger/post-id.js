import { SwaggerDocument } from '../../../packages/swagger';

export const postId = SwaggerDocument.ApiParams({
    name: 'postId',
    paramsIn: 'path',
    type: 'integer',
    required: true,
    description: 'Post Id to find',
});
