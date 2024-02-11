import { getTransaction } from "core/database";
import { InternalServerException, NotFoundException } from "packages/httpException";
import { HelpSignalRepository } from "../help_signal.repository";
import { MESSAGE } from "./message.enum";
import { MediaService } from "core/modules/document";
import { logger } from "packages/logger";

class Service {
    constructor() {
        this.repository = HelpSignalRepository;
        this.MediaService = MediaService;
    }


    getUrls(medias) {
        let images = '';
        medias.forEach(element => { images += element.url + ','; });
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

    async findHelpSignalsByUserId(user_id) {
        try {
            return this.repository.findBy('user_id', user_id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async findHelpSignalsByEmergencyId(emergency_id) {
        try {
            return this.repository.findBy('emergency_id', emergency_id);
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async updateHelpSignal(id, helpSignalDto, { file, files }) {
        const images = file ? [file] : files ? files : null;
        const trx = await getTransaction();

        const helpSignal = await this.findHelpSignalById(id);
        if (!helpSignal) {
            throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
        }

        try {

            if (images && images.length != 0) {
                const medias = await this.MediaService.uploadMany(files);
                const imagesURL = this.getUrls(medias);
                helpSignalDto.images = imagesURL;
            } else {
                helpSignalDto.images = helpSignal[0].images;
                console.log(helpSignalDto.images);
            }

            const updatedHelpSignal = await this.repository.updateOne(id, helpSignalDto, trx);
            trx.commit();

            return {
                message: MESSAGE.UPDATE_HELP_SIGNAL_SUCCESS,
                id: updatedHelpSignal[0],
            }

        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async deleteHelpSignal(id) {
        const trx = await getTransaction();

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

        return { message: MESSAGE.DELETE_HELP_SIGNAL_SUCCESS }
    }
}

export const HelpSignalService = new Service();
