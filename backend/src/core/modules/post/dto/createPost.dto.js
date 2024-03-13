import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('createPostDto', {
    topic: SwaggerDocument.ApiProperty({ type: 'string', example: 'Food | Accommodation | Other' }),
    location: SwaggerDocument.ApiProperty({ type: 'string', example: '44 Ho Tuong, Thanh Khe, Da Nang' }),
    content: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const createPostDto = body => ({
    topic: body.topic,
    location: body.location,
    content: body.content,
    owner_id: body.ownerId,
});
