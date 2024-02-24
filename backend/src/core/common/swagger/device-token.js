import { SwaggerDocument } from '../../../packages/swagger';

export const deviceToken = SwaggerDocument.ApiParams({
    name: 'deviceToken',
    paramsIn: 'path',
    type: 'string',
    description: 'Device token to register',
});
