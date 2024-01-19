/**
 * @param {import("knex")} knex
 */

exports.seed = knex => knex('relatives')
    .del()
    .then(() => knex('relatives').insert([
        {
            relationship: 'Bố',
            full_name: 'Nguyễn Văn A',
            phone: '0334672534',
            user_id: 1,
        },
        {
            relationship: 'Mẹ',
            full_name: 'Trần Thị A',
            phone: '0324662534',
            user_id: 1,
        },
        {
            relationship: 'Anh trai',
            full_name: 'Nguyễn Văn B',
            phone: '0334648534',
            user_id: 2,
        },
        {
            relationship: 'Mẹ',
            full_name: 'Lê Thị B',
            phone: '0324662524',
            user_id: 2,
        },
        {
            relationship: 'Bố',
            full_name: 'Nguyễn Văn C',
            phone: '0334672594',
            user_id: 3,
        },
        {
            relationship: 'Chị gái',
            full_name: 'Nguyễn Thị C',
            phone: '0324662564',
            user_id: 3,
        },
    ]));
