import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('CommentDto', {
    id: SwaggerDocument.ApiProperty({ type: 'int' }),
    content: SwaggerDocument.ApiProperty({ type: 'string' }),
    updatedAt: SwaggerDocument.ApiProperty({ type: 'dateTime' }),
    totalLikes: SwaggerDocument.ApiProperty({ type: 'int' }),
    totalDisLikes: SwaggerDocument.ApiProperty({ type: 'int' }),
});

export const CommentDto = comment => ({
    id: comment.id,
    content: comment.content,
    updatedAt: comment.updatedAt,
    totalLikes: comment.totalLikes,
    totalDisLikes: comment.totalDisLikes,
});
