import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    findBy(column, value) {
        return this.query()
            .innerJoin('users', 'users.id', 'posts.owner_id')
            .whereNull('posts.deleted_at')
            .where(`posts.${column}`, '=', value)
            .select(
                'posts.id',
                'posts.topic',
                'posts.location',
                'posts.content',
                'posts.medias',
                'posts.owner_id',
                { createdAt: 'posts.created_at' },
                { updatedAt: 'posts.updated_at' },
                { deletedAt: 'posts.deleted_at' },
            );
    }
}

export const PostRepository = new Repository('posts');