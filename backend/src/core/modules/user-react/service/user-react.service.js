import { getTransaction } from 'core/database';
import { logger } from 'packages/logger';
import { InternalServerException } from 'packages/httpException';
import { UserReactRepository } from '../repository';

class Service {
    constructor() {
        this.userReactRepository = UserReactRepository;
    }

    async createUserReact(userId, reactableId, reactableType, reactType) {
        const trx = await getTransaction();
        try {
            await this.userReactRepository.upsertOne(
                userId,
                reactableId,
                reactableType,
                reactType,
                trx,
            );
        } catch (error) {
            trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }
        trx.commit();
    }

    async deleteUserReact(userId, reactableId, reactableType) {
        const trx = await getTransaction();
        try {
            await this.userReactRepository.deleteOne(
                userId,
                reactableId,
                reactableType,
                trx,
            );
        } catch (error) {
            trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }
        trx.commit();
    }
}

export const UserReactService = new Service();
