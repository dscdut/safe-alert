import { getTransaction } from 'core/database';
import { getFirestore } from 'firebase-admin/firestore';
import { logger } from 'packages/logger';
import { UserRepository } from 'core/modules/user/user.repository';
import { fcmService } from 'core/modules/fcm/service/fcm.service';
import { RelativeService } from 'core/modules/relative/services/relative.service';
import { BadRequestException, DuplicateException, InternalServerException, NotFoundException, ForbiddenException } from 'packages/httpException';
import { MediaService } from 'core/modules/document';
import { HelpSignalRepository } from '../repository/helpSignal.repository';
import { MESSAGE } from '../enum/message.enum';
import { RescuerHelpSignalRepository } from '../repository/rescuerHelpSignal.repository';
import { Status } from '../enum/status.enum';

class Service {
    constructor() {
        this.repository = HelpSignalRepository;
        this.userRepository = UserRepository;
        this.MediaService = MediaService;
        this.rescuerHelpSignalsRepository = RescuerHelpSignalRepository;
        this.fcmService = fcmService;
        this.relativeService = RelativeService;
        this.firestore = getFirestore();
    }

    getUrls(medias) {
        let images = '';
        medias.forEach(element => { images += `${element.url},`; });
        return images.slice(0, -1);
    }

    async createHelpSignal(createHelpSignalDto, userId, { file, files }) {
        try {
            if (!createHelpSignalDto.quantity || createHelpSignalDto.quantity === 0) {
                createHelpSignalDto.quantity = 1;
            }
            createHelpSignalDto.status_id = Status.WAITING.value;
            const images = file ? [file] : files || [];
            if (images && images.length !== 0) {
                const medias = await this.MediaService.uploadMany(images);
                const imagesURL = this.getUrls(medias);
                createHelpSignalDto.images = imagesURL;
            }

            const coordinate = await this.getCoordinatebyUserId(userId);

            createHelpSignalDto.latitude = coordinate.latitudeUser;
            createHelpSignalDto.longitude = coordinate.longitudeUser;

            const signal = await this.repository.insert(createHelpSignalDto);

            await this.sendNotificationToUsers(signal[0].id, userId);

            return {
                message: MESSAGE.CREATE_HELP_SIGNAL_SUCCESS,
                helpSignalId: signal[0].id,
            };
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException(error.message);
        }
    }

    async sendNotificationToUsers(helpSignalId, userId) {
        try {
            const helpSignal = await this.findHelpSignalById(helpSignalId);
            if (!helpSignal[0]) {
                throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
            }

            if (helpSignal[0].user_id !== userId) {
                throw new ForbiddenException('You do not have permission to update this signal');
            }

            const users = await this.getCoordinatesByRadiusFromFirestore(userId);
            const relative = await this.relativeService.getAllRelative(userId);

            const relativeIds = relative.map(item => item.relative_id);
            const ids = users.coordinatesWithinRadius.map(user => parseInt(user.userId, 10));
            const checkRelativeIds = relativeIds.filter(id => !ids.includes(id));
            ids.push(...checkRelativeIds);

            const notificationData = {
                title: 'Safe-Alert SOS - Someone nearby is in trouble and needs your help.',
                body: MESSAGE.NOTIF_BODY,
            };

            const sendNotif = await this.fcmService.sendNotificationToUsers(ids, notificationData);
            return sendNotif;
        } catch (error) {
            this.logger.error(error.message);
            return null;
        }
    }

    async getCoordinatebyUserId(userId) {
        const db = await this.firestore.collection('coordinate').get();
        let latitudeUser;
        let longitudeUser;

        db.forEach(doc => {
            if(doc.id === userId.toString()){
                latitudeUser = doc.data().latitude;
                longitudeUser = doc.data().longitude;
            }
        });

        return {
            latitudeUser,
            longitudeUser
        };
    }


    async getCoordinatesByRadiusFromFirestore(userId) {
        const db = await this.firestore.collection('coordinate').get();

        const coordinatebyUserId = await this.getCoordinatebyUserId(userId);
        const latitude = coordinatebyUserId.latitudeUser;
        const longitude = coordinatebyUserId.longitudeUser;
        const coordinatesWithinRadius = [];
        const coordinatesOutsideRadius = [];

        db.forEach(doc => {
            if(doc.id !== userId.toString()){
                const distance = this.calculateDistance(doc.data().latitude, doc.data().longitude, latitude, longitude);
                if (distance <= 0.3) {
                    coordinatesWithinRadius.push({ userId: doc.id, latitude: doc.data().latitude, longitude: doc.data().longitude });
                } else {
                    coordinatesOutsideRadius.push({ userId: doc.id, latitude: doc.data().latitude, longitude: doc.data().longitude });
                }
            }
        });
        return {
            coordinatesWithinRadius,
            coordinatesOutsideRadius
        };
    }

    calculateDistance(lat1, lon1, lat2, lon2) {
        const R = 3958.8;
        const rlat1 = lat1 * (Math.PI/180);
        const rlat2 = lat2 * (Math.PI/180);
        const difflat = rlat2 - rlat1;
        const difflon = (lon2 - lon1) * (Math.PI/180);
        const distance = 2 * R * Math.asin(Math.sqrt(Math.sin(difflat / 2) * Math.sin(difflat / 2) +
                Math.cos(rlat1) * Math.cos(rlat2) * Math.sin(difflon / 2) * Math.sin(difflon / 2)));
        return distance;
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
            throw new ForbiddenException('You do not have permission to update this signal');
        }

        if (helpSignal[0].status_id === Status.CANCEL.value) {
            throw new BadRequestException(MESSAGE.HELP_SIGNAL_CANCELLED);
        }

        if (helpSignal[0].status_id === Status.DONE.value) {
            throw new BadRequestException(MESSAGE.HELP_SIGNAL_DONE);
        }

        if (!helpSignalDto.quantity || helpSignalDto.quantity === 0) {
            helpSignalDto.quantity = 1;
        }

        helpSignalDto.status_id = helpSignal[0].status_id;
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
            throw new ForbiddenException('You do not have permission to delete this signal');
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

    async acceptSupport(helpSignalId, rescuerId) {
        const trx = await getTransaction();

        const helpSignal = await this.findHelpSignalById(helpSignalId);
        if (!helpSignal[0]) {
            throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
        }

        if (rescuerId === helpSignal[0].user_id) {
            throw new BadRequestException('You can\'t support yourself once you\'ve sent out the signal');
        }
        if (helpSignal[0].status_id === Status.CANCEL.value) {
            throw new BadRequestException(MESSAGE.HELP_SIGNAL_CANCELLED);
        }

        if (helpSignal[0].status_id === Status.DONE.value) {
            throw new BadRequestException(MESSAGE.HELP_SIGNAL_DONE);
        }

        let quantityRescuerHelp = await this.rescuerHelpSignalsRepository.countCurrentRescuer(helpSignalId);
        const helpSignalQuantity = helpSignal[0].quantity;

        if (quantityRescuerHelp === helpSignalQuantity) {
            throw new BadRequestException(MESSAGE.ENOUGH_PEOPLE_TO_SUPPORT);
        }

        const rescuer = await this.rescuerHelpSignalsRepository.findRescuerById(helpSignalId, rescuerId);
        if (rescuer[0] && rescuer[0].rescuer_id === rescuerId) {
            throw new DuplicateException('You have already accepted this signal');
        }

        try {
            await this.addRescuerHelpSignal(helpSignalId, rescuerId, trx);
            if (quantityRescuerHelp === 0) {
                await this.repository.updateHelpSignalStatusById(helpSignalId, Status.ACCEPTED.value, trx);
            }
            quantityRescuerHelp += 1;


            trx.commit();
            const rescuers = await this.getRescuersByHelpSignalId(helpSignalId);
            return {
                message: MESSAGE.ACCEPT_SUPPORT,
                rescuers,
                quantityRescuerHelp,
            };

        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async cancelSupport(helpSignalId, rescuerId, userId = null) {

        const helpSignal = await this.findHelpSignalById(helpSignalId);

        if (!helpSignal[0]) {
            throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
        }

        if (userId && helpSignal[0].user_id !== userId) {
            throw new ForbiddenException('You do not have permission to refused this support');
        }

        if (helpSignal[0].status_id === Status.CANCEL.value) {
            throw new BadRequestException(MESSAGE.HELP_SIGNAL_CANCELLED);
        }

        if (helpSignal[0].status_id === Status.DONE.value) {
            throw new BadRequestException(MESSAGE.HELP_SIGNAL_DONE);
        }

        const rescuer = await this.rescuerHelpSignalsRepository.findRescuerById(helpSignalId, rescuerId);
        if (!rescuer[0]) {
            throw new NotFoundException(MESSAGE.RESCUER_NOT_FOUND);
        }

        const trx = await getTransaction();
        let quantityRescuerHelp = await this.rescuerHelpSignalsRepository.countCurrentRescuer(helpSignalId);

        try {
            await this.rescuerHelpSignalsRepository.deleteRescuerByHelpSignalId(helpSignalId, rescuerId, trx);
            if (quantityRescuerHelp && quantityRescuerHelp === 1) {
                await this.repository.updateHelpSignalStatusById(helpSignalId, Status.WAITING.value, trx);
            }
            quantityRescuerHelp -= 1;
            const message = userId ? MESSAGE.USER_CANCELLED_SUPPORT : MESSAGE.RESCUER_CANCELLED_SUPPORT;
            trx.commit();
            return {
                message,
                quantityRescuerHelp,
            };
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            throw new InternalServerException();
        }

    }

    async getRescuersByHelpSignalId(helpSignalId) {
        try {
            const helpSignal = await this.findHelpSignalById(helpSignalId);

            if (!helpSignal) {
                throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
            }

            return this.rescuerHelpSignalsRepository.getRescuersByHelpSignalId(helpSignalId);
        } catch (error) {
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async addRescuerHelpSignal(helpSignalId, rescuerId, trx) {
        try {
            await this.rescuerHelpSignalsRepository.addRescuerHelpSignal(helpSignalId, rescuerId, trx);
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async verifyDoneOrCancel(userId, helpSignalId, isDone) {
        const helpSignal = await this.findHelpSignalById(helpSignalId);

        if (!helpSignal[0]) {
            throw new NotFoundException(MESSAGE.HELP_SIGNAL_NOT_FOUND);
        }

        if (helpSignal[0].user_id !== userId) {
            throw new ForbiddenException('You do not have permission to verify DONE/CANCEL this signal');
        }

        if (helpSignal[0].status_id === Status.CANCEL.value || helpSignal[0].status_id === Status.DONE.value) {
            throw new BadRequestException(`${MESSAGE.HELP_SIGNAL_CANCELLED} or ${MESSAGE.HELP_SIGNAL_DONE}`);
        }

        const trx = await getTransaction();
        const statusId = isDone ? Status.DONE.value : Status.CANCEL.value;
        try {
            await this.repository.updateHelpSignalStatusById(helpSignalId, statusId, trx);
            trx.commit();
            return {
                message: isDone ? MESSAGE.HELP_SIGNAL_DONE : MESSAGE.HELP_SIGNAL_CANCELLED,
            };
        } catch (error) {
            await trx.rollback();
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }
}

export const HelpSignalService = new Service();
