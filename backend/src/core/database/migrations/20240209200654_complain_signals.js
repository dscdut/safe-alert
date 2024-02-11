// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'complain_signals';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.double('latitude').notNullable();
        table.double('longitude').notNullable();
        table.string('location').notNullable();
        table.string('description').nullable();
        table.string('images').nullable();
        table.integer('status_id').notNullable();
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
