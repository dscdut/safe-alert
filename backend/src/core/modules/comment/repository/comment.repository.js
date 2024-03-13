import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    findByParentIdAndType(offset, pageSize, parentId, parentType) {
        return this.query()
            .where('comments.parent_id', '=', parentId)
            .andWhere('comments.parent_type', '=', parentType)
            .select('comments.id', 'comments.content', {
                updatedAt: 'comments.updated_at',
            })
            .offset(offset)
            .limit(pageSize);
    }

    countByParentIdAndType(parentId, parentType) {
        return this.query()
            .where('comments.parent_id', '=', parentId)
            .andWhere('comments.parent_type', '=', parentType)
            .count('comments.id')
            .first();
    }

    insertOne(parent_id, parent_type, content, user_id) {
        return this.query().insert({
            parent_id,
            parent_type,
            content,
            user_id,
        });
    }
}

export const CommentRepository = new Repository('comments');
