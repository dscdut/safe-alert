/**
 * @param {import("knex")} knex
 */
import { fakerVI } from '@faker-js/faker';

export const numContacts = 50;
const tableName = 'contacts';
exports.seed = async knex => {
    await knex(tableName).del();
    const rescueGroups = ['SA disaster rescue team', 'Da Nang city fire department',
        ' SA road traffic rescue team',
        'SA hotel',
        'Motorbike repair team'];
    const lengthArr = rescueGroups.length;

    const contacts = Array.from({ length: numContacts }, () => {
        const numRD = Math.floor(Math.random() * lengthArr) + 1;
        return {
            group_name: rescueGroups[numRD - 1],
            phone_number: `0${  fakerVI.string.numeric({ length: 9 })}`,
            address: fakerVI.location.streetAddress(),
            details: fakerVI.lorem.sentence(),
            latitude: fakerVI.location.latitude(),
            longitude: fakerVI.location.longitude(),
            emergency_id: numRD,
        };
    });

    await knex(tableName).insert(contacts);
};
