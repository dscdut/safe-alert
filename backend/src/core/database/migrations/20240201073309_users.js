// @ts-check
/**
 * @param {import("knex")} knex
 */
const tableName = 'users';
// 123456
const DEFAULT_PASSWORD =
    '$2b$10$4WxWKojNnKfDAicVsveh7.ogkWOBMV1cvRUSPCXwxA05NRX18F0QW';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('full_name');
        table.string('email').unique().notNullable();
        table.string('phone_number').unique().notNullable();
        table.string('password').defaultTo(DEFAULT_PASSWORD);
        table.string('avatar').defaultTo(null);
        table.dateTime('birthday').defaultTo(null);
        table.string('address').defaultTo(null);
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

exports.down = async knex => {
    await knex.schema.dropTable(tableName);
    await knex.raw(`DROP TRIGGER IF EXISTS update_timestamp ON ${tableName};`);
};
