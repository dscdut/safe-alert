// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'contacts';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('group_name');
        table.string('phone_number').unique().notNullable();
        table.string('address').nullable();
        table.text('details').nullable();
        table.decimal('latitude').nullable();
        table.decimal('longitude').nullable();
        table.integer('emergency_id').unsigned().references('id').inTable('emergencies').notNullable();
        table.dateTime('deleted_at').defaultTo(null);
        table.timestamps(false, true);
    });

    await knex.raw(`
   CREATE TRIGGER update_timestamp
   BEFORE UPDATE
   ON ${tableName}
   FOR EACH ROW
   EXECUTE PROCEDURE update_timestamp();
 `);
};

exports.down = knex => knex.schema.dropTable(tableName);
