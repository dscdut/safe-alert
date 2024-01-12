/**
 * @param {import("knex")} knex
 */

exports.seed = knex => knex('users')
    .del()
    .then(() => knex('users').insert([
        {
            full_name: 'Super Admin',
            email: 'spadmin@gmail.com',
            phone_number: '093873495',
        },
        {
            full_name: 'Admin',
            email: 'admin@gmail.com',
            phone_number: '093873434',
        },
        {
            full_name: 'User',
            email: 'user@gmail.com',
            phone_number: '078494443',
        },
    ]));
