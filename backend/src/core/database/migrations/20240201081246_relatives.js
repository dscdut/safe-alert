// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'relatives';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('relationship');
        table.string('full_name').unique().notNullable();
        table.string('phone').unique().notNullable();
        table.integer('user_id').unsigned().references('id').inTable('users').notNullable();
        table.dateTime('deleted_at').defaultTo(null);
        table.timestamps(false, true);
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
