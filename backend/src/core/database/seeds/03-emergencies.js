/**
 * @param {import("knex")} knex
 */

exports.seed = knex => knex('emergencies')
    .del()
    .then(() => knex('emergencies').insert([
        {
            parent_id:  null,
            type: 'Khẩn cấp',
        },
        {
            parent_id: null,
            type: 'Giúp đỡ',
        },
        {
            parent_id: null,
            type: 'Phản ánh',
        },
        {
            parent_id: 1,
            type: 'Cứu hỏa',
        },
        {
            parent_id: 1,
            type: 'An ninh',
        },
        {
            parent_id: 1,
            type: 'Cấp cứu',
        },
        {
            parent_id: 2,
            type: 'Thiên tai',
        },
        {
            parent_id: 2,
            type: 'Sức khỏe',
        },
        {
            parent_id: 2,
            type: 'Sửa chữa',
        },
        {
            parent_id:  2,
            type: 'Y tế',
        },
        {
            parent_id: 2,
            type: 'Giao thông',
        },
        {
            parent_id: 3,
            type: 'Nguy hiểm',
        },
        {
            parent_id: 3,
            type: 'Vi phạm',
        },
        {
            parent_id: 3,
            type: 'Du lịch',
        },
        {
            parent_id: 7,
            type: 'Sạt lỡ',
        },
        {
            parent_id: 7,
            type: 'Bão',
        },
        {
            parent_id: 7,
            type: 'Lũ',
        },
        {
            parent_id: 7,
            type: 'Sự cố điện',
        },
        {
            parent_id: 8,
            type: 'Thức ăn',
        },
        {
            parent_id: 8,
            type: 'Nhu yếu phẩm',
        },
        {
            parent_id: 9,
            type: 'Xe máy',
        },
        {
            parent_id: 9,
            type: 'Điện nước',
        },
        {
            parent_id:  9,
            type: 'ô tô',
        },
        {
            parent_id: 9,
            type: 'Nhà cửa',
        },
        {
            parent_id: 10,
            type: 'Hiến máu',
        },
        {
            parent_id: 10,
            type: 'Điều dưỡng',
        },
        {
            parent_id: 10,
            type: 'Bác sĩ',
        },
        {
            parent_id: 11,
            type: 'Lái xe',
        },
        {
            parent_id: 12,
            type: 'Hư hỏng cầu đường',
        },
        {
            parent_id: 12,
            type: 'Sự cố điện',
        },
        {
            parent_id: 13,
            type: 'An toàn thực phẩm',
        },
        {
            parent_id: 13,
            type: 'Môi trường',
        },
        {
            parent_id: 13,
            type: 'Giao thông',
        },
        {
            parent_id: 13,
            type: 'Khác',
        },
    ]));
