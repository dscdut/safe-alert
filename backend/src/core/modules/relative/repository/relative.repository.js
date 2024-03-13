import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findBy(column, value) {
        return this.query()
            .whereNull('relatives.deleted_at')
            .where(`relatives.${column}`, '=', value)
            .select(
                'relatives.id',
                'relatives.user_id',
                'relatives.relative_id',
                { createdAt: 'relatives.created_at' },
                { updatedAt: 'relatives.updated_at' },
                { deletedAt: 'relatives.deleted_at' },
            );
    }

    CountRelativeByUserId(userId) {
        return this.query()
            .whereNull('relatives.deleted_at')
            .where('relatives.user_id', '=', userId)
            .count('* as count')
            .first();

    }

    findByUserIdAndRelativeId(userId, relativeId){
        return this.query()
            .whereNull('relatives.deleted_at')
            .where({ relative_id: relativeId, user_id: userId })
            .first();
    }

    updateRelative(relativeId, userId, data, trx = null) {
        const queryBuilder = this.query()
            .whereNull('deleted_at')
            .where({ relative_id: relativeId, user_id: userId })
            .update(data)
            .returning([
                'relatives.id',
                'relatives.user_id',
                'relatives.relative_id',
            ]);

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    deleteRelative(relativeId, userId, trx = null) {
        const queryBuilder = this.query().where({ relative_id: relativeId, user_id: userId }).del();
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

}

export const RelativeRepository = new Repository('relatives');
