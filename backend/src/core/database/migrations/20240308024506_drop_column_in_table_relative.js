// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'relatives';
exports.up = async knex => {
    await knex.schema.table(tableName, table => {
        table.dropColumn('relationship');
        table.dropColumn('full_name');
        table.dropColumn('phone');
    });
};

exports.down = knex => knex.schema.table(tableName, table => {
    table.string('relationship');
    table.string('full_name');
    table.string('phone');
});
