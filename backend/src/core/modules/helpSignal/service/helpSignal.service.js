import { getTransaction } from 'core/database';
import { BadRequestException, InternalServerException, NotFoundException } from 'packages/httpException';
import { MediaService } from 'core/modules/document';
import { logger } from 'packages/logger';
import { UserRepository } from 'core/modules/user/user.repository';
import { HelpSignalRepository } from '../repository/helpSignal.repository';
import { MESSAGE } from '../enum/message.enum';

class Service {
    constructor() {
        this.repository = HelpSignalRepository;
        this.userRepository = UserRepository;
        this.MediaService = MediaService;
    }


    getUrls(medias) {
        let images = '';
        medias.forEach(element => { images += `${element.url},`; });
        return images.slice(0, -1);
    }

    async createHelpSignal(createHelpSignalDto, { file, files }) {
        try {
            if (!createHelpSignalDto.quantity || createHelpSignalDto.quantity === 0) {
                createHelpSignalDto.quantity = 1;
            }

            const images = file ? [file] : files || [];
            if (images && images.length !== 0) {
                const medias = await this.MediaService.uploadMany(images);
                const imagesURL = this.getUrls(medias);
                createHelpSignalDto.images = imagesURL;
            }
            const signal = await this.repository.insert(createHelpSignalDto);

            const userId = createHelpSignalDto.user_id;
            const coordinates = { latitude: +createHelpSignalDto.latitude, longitude: +createHelpSignalDto.longitude };

            const ids = await this.userRepository.getUserToSendNoitfication(userId, coordinates);
            return {
                message: MESSAGE.CREATE_HELP_SIGNAL_SUCCESS,
                helpSignalId: signal[0].id,
                ids
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

    async getAllHelpSignals() {
        try {
            return this.repository.getAllHelpSignals();
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

    async updateHelpSignal(id, helpSignalDto, userId, { file, files }) {
        const helpSignal = await this.findHelpSignalById(id);
        if (!helpSignal || helpSignal.length === 0) {
            throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
        }

        if (helpSignal[0].user_id !== userId) {
            throw new BadRequestException();
        }

        if (!helpSignalDto.quantity || helpSignalDto.quantity === 0) {
            helpSignalDto.quantity = 1;
        }
        const images = file ? [file] : files || [];
        const trx = await getTransaction();

        try {

            if (images && images.length !== 0) {
                const medias = await this.MediaService.uploadMany(images);
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

    async deleteHelpSignal(id, userId) {
        const trx = await getTransaction();

        const helpSignal = await this.findHelpSignalById(id);
        const ids = [id];
        if (!helpSignal || helpSignal.length === 0) {
            throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
        }

        if (helpSignal[0].user_id !== userId) {
            throw new BadRequestException();
        }

        try {
            await this.repository.softDeleteMany(ids, trx);
            trx.commit();
        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }

        return { message: MESSAGE.DELETE_HELP_SIGNAL_SUCCESS };
    }
}

export const HelpSignalService = new Service();
