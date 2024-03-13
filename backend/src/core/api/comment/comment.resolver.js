import { Module } from 'packages/handler/Module';
import { RecordId, page, size, keyword } from 'core/common/swagger';
import { CommentController } from './comment.controller';

export const CommentResolver = Module.builder()
    .addPrefix({
        prefixPath: '/comments',
        tag: 'comments',
        module: 'CommentModule',
    })
    .register([
        {
            route: '',
            method: 'post',
            controller: CommentController.createComment,
            body: 'AddCommentDto',
            model: { $ref: 'MessageDto' },
            preAuthorization: true,
        },
        {
            route: '/:id/nested',
            method: 'get',
            params: [page, size, keyword, RecordId],
            controller: CommentController.getCommentPaginationByParentIdAndType,
            model: { $ref: 'PaginationCommentDto' },
            description:
                'Get list nested comments of a post or comment (Keyword POST or COMMENT)',
        },
    ]);
