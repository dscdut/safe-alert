import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    updateHelpSignalStatus(help_signal_id, trx = null) {
        const queryBuilder = this.query(trx)
            .whereNull('help_signals.deleted_at')
            .where('help_signals.id', '=', help_signal_id)
            .update({ status_id: 1 });
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    }

}

export const HelpSignalRepository = new Repository('help_signals');