import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('MessageDto', {
    message: SwaggerDocument.ApiProperty({ type: 'string', readOnly: true }),
});

export const MessageDto = message => ({
    message,
});
