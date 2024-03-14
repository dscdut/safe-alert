/**
 * @param {import("knex")} knex
 */
import { fakerVI } from '@faker-js/faker';
import { numUsers } from './01-users';

export const numPosts = 50;
const tableName = 'posts';
exports.seed = async knex => {
    await knex(tableName).del();

    const topics = ['Food', 'Accommodation', 'Other'];
    const locations = ['130 Dien Bien Phu, Thanh Khe, Da Nang', '132 Nguyen Luong Bang, Lien Chieu, Da Nang', '44 Ho Tuong, Thanh Khe, Da Nang'];
    const posts = Array.from({ length: numUsers }, () => ({
        topic: topics[fakerVI.number.int({ min: 0, max: topics.length - 1 })],
        location: locations[fakerVI.number.int({ min: 0, max: locations.length - 1 })],
        content: fakerVI.lorem.sentence(),
        medias: fakerVI.image.url(),
        owner_id: fakerVI.number.int({ min: 1, max: numUsers }),
    }));

    await knex(tableName).insert(posts);
};
