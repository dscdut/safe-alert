import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('RegisterDto', {
    fullName: SwaggerDocument.ApiProperty({ type: 'string' }),
    phoneNumber: SwaggerDocument.ApiProperty({ type: 'string' }),
    email: SwaggerDocument.ApiProperty({ type: 'string' }),
    password: SwaggerDocument.ApiProperty({ type: 'string' }),
    confirmPassword: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const RegisterDto = body => ({
    full_name: body.fullName,
    email: body.email,
    phone_number: body.phoneNumber,
    password: body.password,
    confirm_password: body.confirmPassword,
});
