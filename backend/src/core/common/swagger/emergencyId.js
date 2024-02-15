import { SwaggerDocument } from '../../../packages/swagger';

export const emergencyId = SwaggerDocument.ApiParams({
    name: 'emergencyId',
    paramsIn: 'path',
    type: 'integer',
    required: true,
    description: 'Emergency Id to find',
});
