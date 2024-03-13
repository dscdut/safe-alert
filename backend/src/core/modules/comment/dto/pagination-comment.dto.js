import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';

ApiDocument.addModel('PaginationCommentDto', {
    data: SwaggerDocument.ApiProperty({
        type: 'array',
        model: 'CommentDto',
    }),
    totalPages: SwaggerDocument.ApiProperty({ type: 'int', readOnly: true }),
    totalElements: SwaggerDocument.ApiProperty({ type: 'int', readOnly: true }),
});

export const PaginationCommentDto = pageable => ({
    data: pageable.data,
    totalPages: Math.ceil(pageable.total / pageable.pageSize),
    totalElements: pageable.total,
});
