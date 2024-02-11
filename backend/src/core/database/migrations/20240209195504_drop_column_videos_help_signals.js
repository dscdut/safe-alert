// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'help_signals';
exports.up = async knex => {
    await knex.schema.table(tableName, table => {
        table.dropColumn('videos');
    });
};

exports.down = knex => knex.schema.table(tableName, table => {
    table.string('videos');
});
