/**
 * @param { import("knex").Knex } knex
 */
const tableName = 'posts';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table.increments('id').unsigned().primary();
        table.string('topic').nullable();
        table.string('location', 512).nullable();
        table.text('content');
        table.text('medias').nullable();
        table.integer('likes_count').nullable();
        table.integer('dislikes_count').nullable();
        table.integer('comments_count').nullable();
        table
            .integer('owner_id')
            .unsigned()
            .notNullable()
            .references('id')
            .inTable('users')
            .onDelete('CASCADE');
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
/**
 * @param { import("knex").Knex } knex
 */
exports.down = async knex => {
    await knex.schema.dropTable(tableName);
    await knex.raw(`DROP TRIGGER IF EXISTS update_timestamp ON ${tableName};`);
};
