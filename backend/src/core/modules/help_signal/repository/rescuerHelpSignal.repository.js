import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    addRescuerHelpSignal(helpSignalId, rescuerId, trx = null) {
        const queryBuilder = this.query().insert({
            rescuer_id: rescuerId,
            help_signal_id : helpSignalId,
        });
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    };

    countRescuerHelpCurrent(helpSignalId) {
        const rescuerHelpCount = this.query()
            .count('* as count')
            .where('help_signal_id', '=', helpSignalId)
            .first()
            .then(row => row.count);
        return rescuerHelpCount;
    }

    getRescuersByHelpSignalId(helpSignalId) {
        const rescuerHelp = this.query()
            .select('users.*')
            .join('users', 'rescuer_help_signals.rescuer_id', '=', 'users.id')
            .where('rescuer_help_signals.help_signal_id'    , '=',  helpSignalId);
        return rescuerHelp;
    }

}

export const RescuerHelpSignalRepository = new Repository('rescuer_help_signals');