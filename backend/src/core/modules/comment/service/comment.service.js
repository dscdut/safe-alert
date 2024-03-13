import { REACTION_OF_TYPE } from 'core/modules/user-react/user-react.const';
import { CommentDto, PaginationCommentDto } from '../dto';
import { CommentRepository, UserReactRepository } from '../repository';
import { COMMENT_PARENT_TYPE } from '../comment.const';

class Service {
    constructor() {
        this.commentRepository = CommentRepository;
        this.userReactRepository = UserReactRepository;
    }

    async createComment(parentId, parentType, content, userId) {
        await this.commentRepository.insertOne(
            parentId,
            parentType,
            content,
            userId,
        );
    }

    async getCommentPaginationByParentIdAndType(
        parentId,
        parentType,
        page,
        size,
    ) {
        const offset = (page - 1) * size;
        const total = await this.commentRepository.countByParentIdAndType(
            parentId,
            parentType,
        );
        const data = await this.commentRepository.findByParentIdAndType(
            offset,
            size,
            parentId,
            parentType,
        );
        const commentWithReactions = await Promise.all(
            data.map(async e => {
                const commentsWithTotalLikesAndDislikesAndIfHaveNested =
                    await Promise.all([
                        this.userReactRepository.countLikes(
                            REACTION_OF_TYPE.COMMENT,
                            e.id,
                        ),
                        this.userReactRepository.countDisLikes(
                            REACTION_OF_TYPE.COMMENT,
                            e.id,
                        ),
                        this.commentRepository.countByParentIdAndType(
                            e.id,
                            COMMENT_PARENT_TYPE.COMMENT,
                        ),
                    ]);
                return {
                    ...e,
                    totalLikes: parseInt(
                        commentsWithTotalLikesAndDislikesAndIfHaveNested[0]
                            .count,
                        10,
                    ),
                    totalDisLikes: parseInt(
                        commentsWithTotalLikesAndDislikesAndIfHaveNested[1]
                            .count,
                        10,
                    ),
                    hasNested:
                        commentsWithTotalLikesAndDislikesAndIfHaveNested[2]
                            .count > 0,
                };
            }),
        );
        return PaginationCommentDto({
            data: commentWithReactions.map(e => CommentDto(e)),
            pageSize: size,
            total: parseInt(total.count, 10),
        });
    }
}

export const CommentService = new Service();
