import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    createRescuerHelpSignal(help_signal_id,rescuer_id, trx = null) {
        const queryBuilder = this.query().insert({
            rescuer_id,
            help_signal_id,
        });
        if (trx) queryBuilder.transacting(trx);
        return queryBuilder;
    };

    countRescuerHelp(help_signal_id) {
        const rescuerHelpCount = this.query().count('* as count').where('help_signal_id', '=', help_signal_id).first().then(row => row.count);
        return rescuerHelpCount;
    }

}

export const RescuerHelpSignalsRepository = new Repository('rescuer_help_signals');
