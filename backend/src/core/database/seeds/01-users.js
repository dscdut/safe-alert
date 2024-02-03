/**
 * @param {import("knex")} knex
 */

exports.seed = knex => knex('users')
    .del()
    .then(() => knex('users').insert([
        {
            full_name: 'User1',
            email: 'user1@gmail.com',
            phone_number: '0938734952',
        },
        {
            full_name: 'User2',
            email: 'user2@gmail.com',
            phone_number: '0938734343',
        },
        {
            full_name: 'User3',
            email: 'user3@gmail.com',
            phone_number: '0784944433',
        },
    ]));
