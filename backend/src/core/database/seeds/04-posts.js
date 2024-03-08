/**
 * @param {import("knex")} knex
 */
import { fakerVI } from '@faker-js/faker';
import { numUsers } from './01-users';

export const numPosts = 50;
const tableName = 'posts';
exports.seed = async knex => {
    await knex(tableName).del();

    // eslint-disable-next-line no-unused-vars
    const posts = Array.from({ length: numUsers }, (_, index) => ({
        content: fakerVI.lorem.sentence(),
        owner_id: fakerVI.number.int({ min: 1, max: numUsers }),
    }));

    await knex(tableName).insert(posts);
};
