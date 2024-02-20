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
            latitude: 40.73061,
            longitude: -73.935242,
        },
        {
            full_name: 'User2',
            email: 'user2@gmail.com',
            phone_number: '0938734343',
            latitude: 40.73061,
            longitude: -73.62520,
        },
        {
            full_name: 'User3',
            email: 'user3@gmail.com',
            phone_number: '0784944433',
            latitude: 41.73061,
            longitude: -73.935242
        },
    ]));
