// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'help_signals';
exports.up = async knex => {
    await knex.schema.alterTable(tableName, table => {
        table.text('images').alter();
    });
};

exports.down = knex => knex.schema.alterTable(tableName, table => {
    table.string('images').alter();
});
