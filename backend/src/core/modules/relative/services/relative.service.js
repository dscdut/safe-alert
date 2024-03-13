import { BcryptService } from 'core/modules/auth';
import { RelativeRepository } from '../repository/relative.repository';

class Service {
    constructor() {
        this.repository = RelativeRepository;
        this.bcryptService = BcryptService;
    }

    async addRelative(addRelativeDto, userId, relativeId) {
        let createdUser;
        addRelativeDto.user_id = userId;
        addRelativeDto.relative_id = relativeId;

        const existingRelative = await this.repository.findByUserIdAndRelativeId(userId, relativeId);

        if (existingRelative) {
            return { message: 'Relationship already exists' };
        }

        const quantity = await this.countRelativeByUserId(userId);

        try {
            if( quantity <= 5 && (userId !== parseInt(relativeId, 10) )) {
                createdUser = await this.repository.insert(addRelativeDto);
            } else {
                return { Message: 'Exceeded the maximum allowed quantity or the person added is invalid.'};
            }

        } catch (error) {
            this.logger.error(error.message);
            return null;
        }

        return createdUser[0];
    }

    async deleteRelative(userId, relativeId) {

        try {
            const existingRelative = await this.repository.findByUserIdAndRelativeId(userId, relativeId);

            if (!existingRelative) {
                return { message: 'Relationship doesn\'t exist' };
            }
            return await this.repository.deleteRelative(relativeId, userId);
        } catch (error) {
            this.logger.error(error.message);
            return null;
        }

    }

    async getAllRelative(userId) {
        try {
            return this.repository.findBy('user_id',userId);
        } catch (error) {
            this.logger.error(error.message);
            return null;
        }
    }

    async countRelativeByUserId(userId) {
        let quantity;
        try {
            quantity = await this.repository.CountRelativeByUserId(userId);
            quantity = parseInt(quantity.count, 10);
        } catch (error) {
            this.logger.error(error.message);
            return null;
        }

        return quantity;
    }
}

export const RelativeService = new Service();
