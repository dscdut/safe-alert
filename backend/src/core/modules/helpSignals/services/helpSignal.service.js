import { getTransaction } from 'core/database';
import { Status } from 'core/status';
import { RescuerHelpSignalRepository } from '../rescuer_help_signal.repository';
import { HelpSignalRepository } from '../helpSignal.repository';


class Service {
    constructor() {
        this.helpSignalsRepository = HelpSignalRepository;
        this.rescuerHelpSignalsRepository = RescuerHelpSignalRepository;
    }

    async updateHelpSignalByStatus(help_signal_id, rescuer_id) {
        const trx = await getTransaction();
        let countRescuerHelp = await this.rescuerHelpSignalsRepository.countRescuerHelp(help_signal_id);
        const helpSignal = await this.helpSignalsRepository.getHelpSignalById(help_signal_id, trx);
        const helpSignalQuantity = helpSignal.quantity_rescuers;
        let status;

        countRescuerHelp =  parseInt(countRescuerHelp, 10) + 1;
        if (countRescuerHelp === helpSignalQuantity) {
            await this.updateAndCreateRescuerHelpSignal(trx, help_signal_id, rescuer_id);
            status = Status.DONE.description;
        }

        if (countRescuerHelp < helpSignalQuantity) {
            await this.createRescuerHelpSignal(trx, help_signal_id, rescuer_id);
            status = Status.ACCEPTED.description;
        }
        const user_help = await this.rescuerHelpSignalsRepository.getRescuersByHelpSignalId(help_signal_id);
        return this.responseEntity(status, countRescuerHelp, user_help);

    }

    async updateAndCreateRescuerHelpSignal(trx, help_signal_id, rescuer_id) {
        try {
            await this.helpSignalsRepository.updateHelpSignalStatus(help_signal_id, trx);
            await this.createRescuerHelpSignal(trx, help_signal_id, rescuer_id);
            await trx.commit();
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            return null;
        }
    }

    async createRescuerHelpSignal(trx, help_signal_id, rescuer_id) {
        try{
            await this.rescuerHelpSignalsRepository.createRescuerHelpSignal(help_signal_id, rescuer_id, trx);
            await trx.commit();
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            return null;
        }
    }
    responseEntity(message, quantityRescuerHelp, userHelp) {
        return {
            Message: message,
            user_help: userHelp,
            QuantityRescuerHelp: quantityRescuerHelp,
        };
    }
}

export const HelpSignalService = new Service();