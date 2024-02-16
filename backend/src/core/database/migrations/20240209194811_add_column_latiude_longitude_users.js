// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'users';
exports.up = async knex => {
    await knex.schema.alterTable(tableName, table => {
        table.double('latitude').nullable();
        table.double('longitude').nullable();
    });
};

exports.down = knex => knex.schema.table(tableName, table => {
    table.dropColumn('latitude');
    table.dropColumn('longitude');
});
