import { SwaggerDocument } from '../../../packages/swagger';

export const longitude = SwaggerDocument.ApiParams({
    name: 'longitude',
    paramsIn: 'query',
    required: true,
    type: 'number',
    description: 'Longitude of the location',
});

export const latitude = SwaggerDocument.ApiParams({
    name: 'latitude',
    paramsIn: 'query',
    required: true,
    type: 'number',
    description: 'Latitude of the location',
});

