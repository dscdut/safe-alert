// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'rescuer_help_signals';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.integer('rescuer_id').unsigned().references('id').inTable('users').notNullable().onDelete('CASCADE');
        table.integer('help_signal_id').unsigned().references('id').inTable('help_signals').notNullable().onDelete('CASCADE');
        table.dateTime('deleted_at').defaultTo(null);
        table.timestamps(false, true);

        table.primary(['rescuer_id', 'help_signal_id']);
    });

    await knex.raw(`
     CREATE TRIGGER update_timestamp
     BEFORE UPDATE
     ON  ${tableName}
     FOR EACH ROW
     EXECUTE PROCEDURE update_timestamp();
   `);
};

exports.down = knex => knex.schema.dropTable(tableName);
