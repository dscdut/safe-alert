/**
 * @param { import("knex").Knex } knex
 */
const tableName = 'user_reacts';
exports.up = async knex => {
    await knex.schema.createTable(tableName, table => {
        table
            .integer('user_id')
            .unsigned()
            .notNullable()
            .references('id')
            .inTable('users')
            .onDelete('CASCADE');
        table.integer('reactable_id').unsigned().notNullable();
        table.integer('reactable_type').unsigned().notNullable();
        table.integer('react_type').unsigned().notNullable();
        table.primary(['user_id', 'reactable_id', 'reactable_type']);
    });
};
/**
 * @param { import("knex").Knex } knex
 */
exports.down = async knex => {
    await knex.schema.dropTable(tableName);
};
