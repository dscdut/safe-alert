import { logger } from 'packages/logger';
import { InternalServerException } from 'packages/httpException';
import { getFirestore } from 'firebase-admin/firestore';
import { adminApp } from '../../../config/firebase.config';

class Service {
    constructor() {
        this.messaging = adminApp.messaging();
        this.logger = logger;
        this.firestore = getFirestore();
    }

    async sendNotificationToUsers(userIds, notificationData) {
        try {
            const tokens = [];
            const userDeviceTokens = await this.firestore.collection('deviceToken').get();
            userDeviceTokens.forEach(doc => {
                if(userIds.includes(parseInt(doc.id,10))) {
                    tokens.push(doc.data().deviceToken);
                }
            });

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

}

export const fcmService = new Service();