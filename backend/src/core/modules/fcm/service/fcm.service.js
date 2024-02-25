import { logger } from 'packages/logger';
import { InternalServerException, NotFoundException } from 'packages/httpException';
import { adminApp } from '../../../config/firebase.config';
import { UserDevicetokenRepository } from '../repository/userDevicetoken.repository';

class Service {
    constructor() {
        this.fcmServer = adminApp;
        this.repository = UserDevicetokenRepository;
        this.messaging = adminApp.messaging();
        this.logger = logger;
    }

    async saveToken(userId, deviceToken) {
        try {
            const userDeviceTokens = await this.repository.getDevicetokenByUserId(userId);

            if (!userDeviceTokens[0]) {
                await this.repository.insert({ user_id: userId, device_token: deviceToken });
            } else {
                const isExist = userDeviceTokens.some(userDeviceToken => userDeviceToken.deviceToken === deviceToken);

                if (!isExist) {
                    await this.repository.insert({ user_id: userId, device_token: deviceToken });
                }
            }
            return {
                message: 'You have successfully registered your devicetoken',
            };
        } catch (error) {
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async sendNotificationToUser(user, notificationData) {
        try {

            const userDeviceTokens = await this.repository.getDevicetokenByUserId(user.id);

            if (!userDeviceTokens[0]) {
                throw NotFoundException('You have not registered devicetoken');
            }

            const tokens = userDeviceTokens.map(userDeviceToken => userDeviceToken.deviceToken);

            const message = {
                notification: {
                    title: notificationData.title,
                    body: notificationData.body
                },
                tokens
            };

            const response = await this.messaging.sendEachForMulticast(message);

            return {
                message: `${response.successCount} messages were sent successfully`,
            };
        } catch (error) {
            this.logger.error(error.message);
            throw new InternalServerException();
        }
    }

    async sendNotificationToUsers(users, notificationData) {
        const sendTasks = users.map(user => this.sendNotificationToUser(user, notificationData));

        return Promise.all(sendTasks);
    }
}

export const fcmService = new Service();