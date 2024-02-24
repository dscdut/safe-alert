import {InternalServerException } from 'packages/httpException';
import { EmergencyRepository } from '../repository/emergency.repository';

class Service {
    constructor() {
        this.repository = EmergencyRepository;
    }

    async getAllEmergency() {
        try {
            return this.repository.getAllEmergency();
        } catch (error) {
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    };


}
export const EmergencyService = new Service();