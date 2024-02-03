// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'help_signals';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.double('latitude').unique().notNullable();
        table.double('longitude').unique().notNullable();
        table.string('location').unique().notNullable();
        table.string('description').unique().notNullable();
        table.string('images').unique().notNullable();
        table.string('videos').unique().notNullable();
        table.integer('status_id').unique().notNullable();
        table.integer('user_id').unsigned().references('id').inTable('users').notNullable();
        table.integer('emergency_id').unsigned().references('id').inTable('emergencies').notNullable();
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
