import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('createHelpSignalDto', {
    location: SwaggerDocument.ApiProperty({ type: 'string' }),
    description: SwaggerDocument.ApiProperty({ type: 'string' }),
    quantity: SwaggerDocument.ApiProperty({ type: 'int' }),
    emergencyId: SwaggerDocument.ApiProperty({ type: 'int' }),
});

export const createHelpSignalDto = body => ({
    latitude: body.latitude,
    longitude: body.longitude,
    location: body.location,
    description: body.description,
    quantity: body.quantity ? body.quantity : null,
    images: body.images ? body.images : null,
    emergency_id: body.emergencyId,
    user_id: body.userId,
    status_id: body.statusId,
});
