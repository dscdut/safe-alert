import { DataRepository } from 'packages/restBuilder/core/dataHandler';

class Repository extends DataRepository {
    getDevicetokenByUserId(userId) {
        return this.query()
            .where('user_devicetokens.user_id', '=', userId)
            .select(
                'user_devicetokens.id',
                { userId: 'user_devicetokens.user_id' },
                { deviceToken: 'user_devicetokens.device_token' },
            );
    }
}

export const UserDevicetokenRepository = new Repository('user_devicetokens');