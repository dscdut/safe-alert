import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('FindUserDto', {
    phone: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const FindUserDto = body => ({
    phone_number: body.phone,
});
