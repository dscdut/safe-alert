import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    getAllEmergency() {
        return this.query()
            .select(
                'emergencies.id',
                'emergencies.type');
    };

}

export const EmergencyRepository = new Repository('emergencies');