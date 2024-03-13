// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'relatives';
exports.up = async knex => {
    await knex.schema.alterTable(tableName, table => {
        table.integer('relative_id').unsigned().references('id').inTable('users').notNullable().onDelete('CASCADE');
    });
};

exports.down = async knex => {
    const hasColumn = await knex.schema.hasColumn(tableName, 'relative_id');

    if (hasColumn) {
        await knex.schema.table(tableName, table => {
            table.dropColumn('relative_id');
            table.dropForeign(['relative_id']);
        });
    }
};