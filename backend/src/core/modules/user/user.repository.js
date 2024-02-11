import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findBy(column, value) {
        return this.query()
            .whereNull('users.deleted_at')
            .where(`users.${column}`, '=', value)
            .select(
                'users.id',
                'users.email',
                'users.password',
                'users.latitude',
                'users.longitude',
                { phoneNumber: 'users.phone_number' },
                { fullName: 'users.full_name' },
                { createdAt: 'users.created_at' },
                { updatedAt: 'users.updated_at' },
                { deletedAt: 'users.deleted_at' },
            );
    }
}

export const UserRepository = new Repository('users');
