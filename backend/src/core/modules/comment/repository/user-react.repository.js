import { REACTION_TYPE } from 'core/modules/user-react/user-react.const';
import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    countLikes(type, id) {
        return this.query()
            .where('user_reacts.reactable_id', '=', id)
            .andWhere('user_reacts.reactable_type', '=', type)
            .andWhere('user_reacts.react_type', '=', REACTION_TYPE.LIKE)
            .count('*')
            .first();
    }

    countDisLikes(type, id) {
        return this.query()
            .where('user_reacts.reactable_id', '=', id)
            .andWhere('user_reacts.reactable_type', '=', type)
            .andWhere('user_reacts.react_type', '=', REACTION_TYPE.DISLIKE)
            .count('*')
            .first();
    }
}

export const UserReactRepository = new Repository('user_reacts');
