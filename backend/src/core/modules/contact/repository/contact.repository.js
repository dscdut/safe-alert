import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    findBy(column, value) {
        return this.query()
            .innerJoin('emergencies', 'emergencies.id', 'contacts.emergency_id')
            .whereNull('contacts.deleted_at')
            .where(`contacts.${column}`, '=', value)
            .select(
                'contacts.id',
                'contacts.address',
                'contacts.details',
                'contacts.latitude',
                'contacts.longitude',
                'contacts.emergency_id',
                'emergencies.type',
                { phoneNumber: 'contacts.phone_number' },
                { groupName: 'contacts.group_name' },
                { createdAt: 'contacts.created_at' },
                { updatedAt: 'contacts.updated_at' },
                { deletedAt: 'contacts.deleted_at' },
            );
    }

    async findGroupTeamByScope(emergencyId, distance = 3000, coordinates) {
        const data = await this.query()
            .innerJoin('emergencies', 'emergencies.id', 'contacts.emergency_id')
            .whereNull('contacts.deleted_at')
            .where('contacts.emergency_id', '=', emergencyId)
            .select(
                'contacts.id',
                'contacts.address',
                'contacts.details',
                'contacts.latitude',
                'contacts.longitude',
                'contacts.emergency_id',
                'emergencies.type',
                { phoneNumber: 'contacts.phone_number' },
                { groupName: 'contacts.group_name' },
                { createdAt: 'contacts.created_at' },
                { updatedAt: 'contacts.updated_at' },
                { deletedAt: 'contacts.deleted_at' },
                this.getConnection().raw(`ST_Distance(
                    ST_SetSRID(ST_MakePoint(contacts.longitude, contacts.latitude), 4326),
                    ST_SetSRID(ST_MakePoint(${coordinates.longitude}, ${coordinates.latitude}), 4326)
                  ) AS distance`),
            );

        const filteredData = data.filter(record => record.distance <= distance);
        return filteredData.sort((a, b) => a.distance - b.distance).slice(0, 5);
    }
}

export const ContactRepository = new Repository('contacts');