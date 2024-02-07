import { getTransaction } from 'core/database';
import { RescuerHelpSignalsRepository } from 'core/modules/help_signals/rescuer_help_signals.repository';
import { logger } from '../../../utils';
import { Status } from 'core/status';
import {  BadRequestException } from '../../../../packages/httpException';
import { HelpSignalsRepository } from '../help_signals.repository';


class Service {
    constructor() {
        this.helpSignalsRepository = HelpSignalsRepository;
        this.rescuerHelpSignalsRepository = RescuerHelpSignalsRepository;
    }

    async updateHelpSignalByStatus(help_signal_id, rescuer_id) {

        const trx = await getTransaction();
        let countRescuerHelp = await this.rescuerHelpSignalsRepository.countRescuerHelp(
            help_signal_id
        );

        const helpSignal = await this.helpSignalsRepository.getHelpSignalById(help_signal_id, trx);
        const helpSignalQuantity = helpSignal.quantity_rescuers;

        try {
            if (countRescuerHelp === 0 || (countRescuerHelp + 1) < helpSignalQuantity) {
                await this.rescuerHelpSignalsRepository.createRescuerHelpSignal(help_signal_id, rescuer_id, trx);
                await trx.commit();
                countRescuerHelp += 1;
                return {
                    message: Status.ACCEPTED,
                    countRescuerHelp,
                };
            }
            else {
                await this.rescuerHelpSignalsRepository.createRescuerHelpSignal(help_signal_id, rescuer_id, trx);
                await this.helpSignalsRepository.updateHelpSignalStatus(help_signal_id, trx);
                countRescuerHelp += 1;
            };
            await trx.commit();
            return {
                message: Status.DONE,
                countRescuerHelp,
            };

        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new BadRequestException();
        }

    }
}

export const HelpSignalService = new Service();
