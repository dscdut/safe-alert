import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('RegisterDto', {
    fullName: SwaggerDocument.ApiProperty({ type: 'string' }),
    phoneNumber: SwaggerDocument.ApiProperty({ type: 'string' }),
    email: SwaggerDocument.ApiProperty({ type: 'string' }),
    password: SwaggerDocument.ApiProperty({ type: 'string' }),
    confirmPassword: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const LoginDto = body => ({
    email: body.email,
    password: body.password,
});
