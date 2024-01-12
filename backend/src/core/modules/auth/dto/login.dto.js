import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('LoginDto', {
    phoneNumber: SwaggerDocument.ApiProperty({ type: 'string' }),
    password: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const LoginDto = body => ({
    phone_number: body.phoneNumber,
    password: body.password,
});
