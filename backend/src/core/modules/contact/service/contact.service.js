import { Optional } from '../../../utils';
import { NotFoundException } from '../../../../packages/httpException';
import { ContactRepository } from '../repository/contact.repository';

class Service {
    constructor() {
        this.repository = ContactRepository;
    }

    async findContactsByEmergencyId(emergencyId) {
        const data = Optional.of(await this.repository.findBy('emergency_id', emergencyId))
            .throwIfNotPresent(new NotFoundException())
            .get();

        return data;
    }

    async findGroupTeamByScope(emergencyId, distance, coordinates) {
        const data = Optional.of(await this.repository.findGroupTeamByScope(emergencyId, distance, coordinates))
            .throwIfNotPresent(new NotFoundException())
            .get();

        return data;
    }
}

export const ContactService = new Service();
