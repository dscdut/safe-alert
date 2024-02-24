/**
 * @param {import("knex")} knex
 */

exports.seed = knex => knex('emergencies')
    .del()
    .then(() => knex('emergencies').insert([
        {
            type: 'Natural disaster',
        },
        {
            type: 'Fire disaster',
        },
        {
            type: 'Accidental',
        },
        {
            type: 'Essentials/shelter aid',
        },
        {
            type: 'Vehicle breakdown',
        },
    ]));
