import { DataRepository } from 'packages/restBuilder/core/dataHandler';
import { REACTION_TYPE } from '../user-react.const';

class Repository extends DataRepository {
    countLikes(type, id) {
        return this.query()
            .where('user_reacts.reactable_id', '=', id)
            .andWhere('user_reacts.reactable_type', '=', type)
            .andWhere('user_reacts.react_type', '=', REACTION_TYPE.LIKE)
            .count('user_reacts.id')
            .first();
    }

    countDisLikes(type, id) {
        return this.query()
            .where('user_reacts.reactable_id', '=', id)
            .andWhere('user_reacts.reactable_type', '=', type)
            .andWhere('user_reacts.react_type', '=', REACTION_TYPE.DISLIKE)
            .count('user_reacts.id')
            .first();
    }

    upsertOne(user_id, reactable_id, reactable_type, react_type, trx = null) {
        let query = this.query()
            .insert({
                user_id,
                reactable_id,
                reactable_type,
                react_type,
            })
            .onConflict(['user_id', 'reactable_id', 'reactable_type'])
            .merge();
        if (trx) query = query.transacting(trx);
        return query;
    }

    deleteOne(user_id, reactable_id, reactable_type, trx = null) {
        let query = this.query()
            .where({
                user_id,
                reactable_id,
                reactable_type,
            })
            .del();
        if (trx) query = query.transacting(trx);
        return query;
    }
}

export const UserReactRepository = new Repository('user_reacts');
