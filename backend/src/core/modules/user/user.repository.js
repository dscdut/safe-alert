import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findOneBy(column, value) {
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
            )
            .first();
    }

    getUserToSendNotification(userId, coordinates) {
        return this
            .query()
            .whereNull('users.deleted_at')
            .where('users.id', '!=', userId)
            .select(
                'users.id',
                'users.email',
                'users.latitude',
                'users.longitude',
                { phoneNumber: 'users.phone_number' },
                { fullName: 'users.full_name' },
                { createdAt: 'users.created_at' },
                { updatedAt: 'users.updated_at' },
                { deletedAt: 'users.deleted_at' },
            )
            .whereRaw(
                `ST_Distance(
                  ST_SetSRID(ST_MakePoint(users.longitude, users.latitude), 4326),
                  ST_SetSRID(ST_MakePoint(${coordinates.longitude}, ${coordinates.latitude}), 4326)
                ) <= 3000`
            );
    }

}

export const UserRepository = new Repository('users');
