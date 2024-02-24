import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    findBy(column, value) {
        return this.query()
            .whereNull('emergencies.deleted_at')
            .where(`emergencies.${column}`, value)
            .select(
                'help_signals.id',
                'help_signals.latitude',
                'help_signals.longitude',
                'help_signals.location',
                'help_signals.description',
                'help_signals.quantity',
                'help_signals.images',
                'help_signals.status_id',
                'help_signals.user_id',
                'help_signals.emergency_id',
                'emergencies.type',
                { phoneNumber: 'users.phone_number' },
                { fullName: 'users.full_name' },
                { createdAt: 'help_signals.created_at' },
                { updatedAt: 'help_signals.updated_at' },
                { deletedAt: 'help_signals.deleted_at' },
            );

    }

    getAllEmergency() {
        return this.query()
            .select(
                'emergencies.id',
                'emergencies.type');
    };

}

export const EmergencyRepository = new Repository('emergencies');