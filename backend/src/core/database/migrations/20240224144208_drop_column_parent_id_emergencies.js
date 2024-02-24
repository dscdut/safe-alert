// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'emergencies';
exports.up = async knex => {
    await knex.schema.table(tableName, table => {
        table.dropColumn('parent_id');
    });
};

exports.down = knex => knex.schema.table(tableName, table => {
    table.string('parent_id');
});
