import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('UpdateUserDto', {
    email: SwaggerDocument.ApiProperty({ type: 'string' }),
    fullName: SwaggerDocument.ApiProperty({ type: 'string' }),
    phone: SwaggerDocument.ApiProperty({ type: 'string' }),
    address: SwaggerDocument.ApiProperty({ type: 'string' }),
    birthday: SwaggerDocument.ApiProperty({ type: 'date'}),
});

export const UpdateUserDto = body => ({
    email: body.email,
    full_name: body.fullName,
    avatar: body.images ? body.images : null,
    phone_number: body.phone,
    address: body.address,
    birthday: body.birthday,
});
