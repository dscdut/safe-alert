/**
 * @param {import("knex")} knex
 */
import { fakerVI } from '@faker-js/faker';
import { numUsers } from './01-users';
import { numPosts } from './04-posts';
import { numComments } from './05-comments';
import { REACTION_OF_TYPE } from '../../modules/user-react/user-react.const';

const tableName = 'user_reacts';
exports.seed = async knex => {
    await knex(tableName).del();
    const reactionArray = Object.values(REACTION_OF_TYPE);
    // eslint-disable-next-line no-unused-vars
    const userReactPosts = Array.from({ length: numUsers }, (_, index) => ({
        reactable_type: REACTION_OF_TYPE.POST,
        user_id: index + 1,
        reactable_id: fakerVI.number.int({ min: 1, max: numPosts }),
        react_type:
            reactionArray[
                fakerVI.number.int({
                    max: reactionArray.length - 1,
                })
            ],
    }));

    await knex(tableName).insert(userReactPosts);

    // eslint-disable-next-line no-unused-vars
    const userReactComments = Array.from({ length: numUsers }, (_, index) => ({
        reactable_type: REACTION_OF_TYPE.COMMENT,
        user_id: index + 1,
        reactable_id: fakerVI.number.int({ min: 1, max: numComments }),
        react_type:
            reactionArray[
                fakerVI.number.int({
                    max: reactionArray.length - 1,
                })
            ],
    }));

    await knex(tableName).insert(userReactComments);
};
