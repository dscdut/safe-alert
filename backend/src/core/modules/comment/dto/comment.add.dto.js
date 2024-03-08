import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';
import {
    COMMENT_PARENT_TYPE,
    COMMENT_PARENT_TYPE_IN_REQUEST,
} from '../comment.const';

ApiDocument.addModel('AddCommentDto', {
    parentId: SwaggerDocument.ApiProperty({ type: 'int' }),
    parentType: SwaggerDocument.ApiProperty({
        type: 'enum',
        model: COMMENT_PARENT_TYPE_IN_REQUEST,
    }),
    content: SwaggerDocument.ApiProperty({ type: 'string' }),
});

export const AddCommentDto = body => ({
    parentId: body.parentId,
    parentType: COMMENT_PARENT_TYPE[body.parentType],
    content: body.content,
});
