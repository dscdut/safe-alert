/**
 * @param {import("knex")} knex
 */
import { fakerVI } from '@faker-js/faker';
import { numUsers } from './01-users';
import { numPosts } from './04-posts';
import { COMMENT_PARENT_TYPE } from '../../modules/comment/comment.const';

export const numComments = 50;
const tableName = 'comments';
exports.seed = async knex => {
    await knex(tableName).del();

    // eslint-disable-next-line no-unused-vars
    const comments = Array.from({ length: numUsers }, (_, index) => ({
        content: fakerVI.lorem.sentence(),
        parent_type: COMMENT_PARENT_TYPE.POST,
        parent_id: fakerVI.number.int({ min: 1, max: numPosts }),
        user_id: fakerVI.number.int({ min: 1, max: numUsers }),
    }));

    await knex(tableName).insert(comments);
};
