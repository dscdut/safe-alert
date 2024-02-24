import { DataRepository } from 'packages/restBuilder/core/dataHandler';
import { Status } from '../enum/status.enum';

class Repository extends DataRepository {
    findBy(column, value) {
        return this.query()
            .innerJoin('users', 'users.id', 'help_signals.user_id')
            .innerJoin('emergencies', 'emergencies.id', 'help_signals.emergency_id')
            .whereNull('help_signals.deleted_at')
            .where(`help_signals.${column}`, '=', value)
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

    getAllHelpSignals() {
        return this.query()
            .innerJoin('users', 'users.id', 'help_signals.user_id')
            .innerJoin('emergencies', 'emergencies.id', 'help_signals.emergency_id')
            .whereNull('help_signals.deleted_at')
            .andWhere('help_signals.status_id', '!=', Status.CANCEL.value)
            .andWhere('help_signals.status_id', '!=', Status.DONE.value)
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
            ).orderBy('help_signals.created_at', 'desc');
    };

    updateOne(id, data, trx = null) {
        const queryBuilder = this.query()
            .whereNull('deleted_at')
            .where({ id })
            .update(data)
            .returning([
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
            ]);

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    hardDeleteOne(id, trx = null) {
        const queryBuilder = this.query().where({ id }).del();

        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    updateHelpSignalStatusById(helpSignalId, status, trx = null) {
        const queryBuilder = this.query(trx)
            .whereNull('help_signals.deleted_at')
            .where('help_signals.id', '=', helpSignalId)
            .update({ status_id: status });
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }
}

export const HelpSignalRepository = new Repository('help_signals');