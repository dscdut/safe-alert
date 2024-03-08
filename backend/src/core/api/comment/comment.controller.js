import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';
import { DEFAULT_PAGE, DEFAULT_PAGE_SIZE } from 'core/common/constants';
import { MessageDto } from 'core/common/dto';
import {
    AddCommentDto,
    COMMENT_PARENT_TYPE,
    CommentService,
} from 'core/modules/comment';

class Controller {
    constructor() {
        this.commentService = CommentService;
    }

    createComment = async req => {
        const { parentType, parentId, content } = AddCommentDto(req.body);
        await this.commentService.createComment(
            parentId,
            parentType,
            content,
            req.user.payload.id,
        );
        return ValidHttpResponse.toOkResponse(MessageDto('Comment created'));
    };

    getCommentPaginationByParentIdAndType = async req => {
        const parentId = req.params.id;
        const page = req.query.page || DEFAULT_PAGE;
        const size = req.query.size || DEFAULT_PAGE_SIZE;
        const parentType = req.query.keyword || 'POST';
        const data =
            await this.commentService.getCommentPaginationByParentIdAndType(
                parentId,
                COMMENT_PARENT_TYPE[parentType],
                page,
                size,
            );

        return ValidHttpResponse.toOkResponse(data);
    };
}

export const CommentController = new Controller();
