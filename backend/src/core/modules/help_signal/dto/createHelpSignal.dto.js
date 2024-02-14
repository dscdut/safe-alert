import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('createHelpSignalDto', {
    latitude: SwaggerDocument.ApiProperty({ type: 'number' }),
    longitude: SwaggerDocument.ApiProperty({ type: 'number' }),
    location: SwaggerDocument.ApiProperty({ type: 'string' }),
    description: SwaggerDocument.ApiProperty({ type: 'string' }),
    quantity: SwaggerDocument.ApiProperty({ type: 'int' }),
    emergency_id: SwaggerDocument.ApiProperty({ type: 'int' }),
});

export const createHelpSignalDto = body => ({
    latitude: body.latitude,
    longitude: body.longitude,
    location: body.location,
    description: body.description,
    quantity: body.quantity ? body.quantity : null,
    images: body.images ? body.images : null,
    emergency_id: body.emergency_id,
    user_id: body.user_id,
    status_id: body.status_id,
});
