/**
 * @param {import("knex")} knex
 */
import { fakerVI } from '@faker-js/faker';

export const numUsers = 100;
const tableName = 'users';
exports.seed = async knex => {
    await knex(tableName).del();

    // eslint-disable-next-line no-unused-vars
    const users = Array.from({ length: numUsers }, (_, index) => ({
        full_name: fakerVI.person.fullName(),
        email: fakerVI.internet.email(),
        phone_number: fakerVI.string.numeric({ length: 10 }),
        avatar: fakerVI.image.avatar(),
        birthday: fakerVI.date.birthdate(),
        address: fakerVI.location.streetAddress(),
    }));

    await knex(tableName).insert(users);
};

