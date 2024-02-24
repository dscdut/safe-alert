import { SwaggerDocument } from '../../../packages/swagger';

export const rescuerId = SwaggerDocument.ApiParams({
    name: 'rescuerId',
    paramsIn: 'path',
    type: 'integer',
    required: true,
    description: 'Rescuer Id to cancel support',
});
