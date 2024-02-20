import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    addRescuerHelpSignal(helpSignalId, rescuerId, trx = null) {
        const queryBuilder = this.query().insert({
            rescuer_id: rescuerId,
            help_signal_id: helpSignalId,
        });
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    };

    deleteRescuerByHelpSignalId(helpSignalId, rescuerId, trx = null) {
        const queryBuilder = this.query()
            .where('rescuer_id', '=', rescuerId)
            .andWhere('help_signal_id', '=', helpSignalId)
            .delete()
            .from('rescuer_help_signals');
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

    countCurrentRescuer(helpSignalId) {
        const rescuerHelpCount = this.query()
            .count('* as count')
            .where('help_signal_id', '=', helpSignalId)
            .first()
            .then(row => row.count);
        return rescuerHelpCount;
    }

    getRescuersByHelpSignalId(helpSignalId) {
        const rescuerHelp = this.query()
            .join('users', 'rescuer_help_signals.rescuer_id', '=', 'users.id')
            .where('rescuer_help_signals.help_signal_id', '=', helpSignalId)
            .select(
                'users.id',
                'users.email',
                'users.latitude',
                'users.longitude',
                { phoneNumber: 'users.phone_number' },
                { fullName: 'users.full_name' }
            );
        return rescuerHelp;
    }

    findRescuerById(helpSignalId, rescuerId) {
        const user = this.query()
            .where('rescuer_help_signals.help_signal_id', '=', helpSignalId)
            .andWhere('rescuer_help_signals.rescuer_id', '=', rescuerId)
            .select(
                'rescuer_help_signals.rescuer_id',
            );
        return user;
    }

}

export const RescuerHelpSignalRepository = new Repository('rescuer_help_signals');