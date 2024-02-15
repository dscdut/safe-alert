import { getTransaction }                             from 'core/database';
import { InternalServerException, NotFoundException } from 'packages/httpException';
import { MediaService }                               from 'core/modules/document';
import { logger }                                     from 'packages/logger';
import { HelpSignalRepository }                       from '../repository/helpSignal.repository';
import { RescuerHelpSignalRepository }                from '../repository/rescuerHelpSignal.repository';
import { MESSAGE }                                    from '../enum/message.enum';
import { Status }                                     from '../enum/status.enum';

class Service {
    constructor() {
        this.repository                   = HelpSignalRepository;
        this.rescuerHelpSignalsRepository = RescuerHelpSignalRepository;
        this.MediaService                 = MediaService;
    }


    getUrls(medias) {
        let images = '';
        medias.forEach(element => { images += `${element.url},`; });
        return images.slice(0, -1);
    }

    async createHelpSignal(createHelpSignalDto, files) {
        try {
            if (files) {
                const medias = await this.MediaService.uploadMany(files);
                const images = this.getUrls(medias);
                createHelpSignalDto.images = images;
            }
            const signal = await this.repository.insert(createHelpSignalDto);
            return {
                message: MESSAGE.CREATE_HELP_SIGNAL_SUCCESS,
                helpSignalId: signal[0].id
            };
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException(error.message);
        }
    }

    async findHelpSignalById(id) {
        try {
            return this.repository.findBy('id', id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findHelpSignalsByUserId(userId) {
        try {
            return this.repository.findBy('user_id', userId);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findHelpSignalsByEmergencyId(emergencyId) {
        try {
            return this.repository.findBy('emergency_id', emergencyId);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async updateHelpSignal(id, helpSignalDto, { file, files }) {
        const images = file ? [file] : files || null;
        const trx = await getTransaction();

        const helpSignal = await this.findHelpSignalById(id);
        if (!helpSignal) {
            throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
        }

        try {

            if (images && images.length !== 0) {
                const medias = await this.MediaService.uploadMany(files);
                const imagesURL = this.getUrls(medias);
                helpSignalDto.images = imagesURL;
            } else {
                helpSignalDto.images = helpSignal[0].images;
            }

            const updatedHelpSignal = await this.repository.updateOne(id, helpSignalDto, trx);
            trx.commit();

            return {
                message: MESSAGE.UPDATE_HELP_SIGNAL_SUCCESS,
                id: updatedHelpSignal[0],
            };

        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async deleteHelpSignal(id) {
        const trx        = await getTransaction();

        const helpSignal = await this.findHelpSignalById(id);

        if (!helpSignal) {
            throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
        }

        try {
            await this.repository.hardDeleteOne(id, trx);
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }
        trx.commit();

        return { message: MESSAGE.DELETE_HELP_SIGNAL_SUCCESS };
    }

    async updateHelpSignalByStatus(helpSignalId, rescuerId) {
        const trx                        = await getTransaction();

        const currentQuantityRescuerHelp = await this.currentQuantityRescuerHelp(helpSignalId);
        const helpSignal                 = await this.findHelpSignalById(helpSignalId);
        const helpSignalQuantity         = helpSignal[0].quantity;
        let   status                     = '';

        // when one more person accepts the signal
        const quantityRescuerHelp        = parseInt(currentQuantityRescuerHelp) + 1;

        if( (helpSignal[0].status_id !== Status.CANCEL.value) && (helpSignal[0].status_id !== Status.DONE.value)) {
            try {
                await this.addRescuerHelpSignal(helpSignalId, rescuerId, trx);

                if (quantityRescuerHelp < helpSignalQuantity ) {
                    try{
                        await this.repository.updateHelpSignalByStatus(helpSignalId, Status.ACCEPTED.value, trx);
                        status = Status.ACCEPTED.description;
                    } catch (error) {
                        await trx.rollback();
                        this.logger.error(error.message);
                    }
                }

                if (quantityRescuerHelp ===  helpSignalQuantity) {
                    try{
                        await this.repository.updateHelpSignalByStatus(helpSignalId, Status.DONE.value, trx);
                        status = Status.DONE.description;
                    } catch (error) {
                        await trx.rollback();
                        this.logger.error(error.message);
                    }
                }

                await trx.commit();

                const userHelp = await this.getRescuersByHelpSignalId(helpSignalId);

                return {
                    message                   : status,
                    rescuerHelp               : userHelp,
                    quantityRescuerHelpNumber : quantityRescuerHelp,
                };

            } catch (error) {
                await trx.rollback();
                this.logger.error(error.message);
                throw new InternalServerException();
            }
        }

    }

    async getRescuersByHelpSignalId(helpSignalId) {
        try{
            const helpSignal = await this.findHelpSignalById(helpSignalId);

            if(!helpSignal){
                throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
            }

            return this.rescuerHelpSignalsRepository.getRescuersByHelpSignalId(helpSignalId);
        } catch (error) {
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async addRescuerHelpSignal(helpSignalId, rescuerId, trx) {
        try{
            await this.rescuerHelpSignalsRepository.addRescuerHelpSignal(helpSignalId, rescuerId, trx);
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async currentQuantityRescuerHelp(helpSignalId) {
        try{
            return await this.rescuerHelpSignalsRepository.countRescuerHelpCurrent(helpSignalId);
        } catch (error) {
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }

}

export const HelpSignalService = new Service();
