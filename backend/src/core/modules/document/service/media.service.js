import { unlink } from 'fs';
import { InternalServerException } from 'packages/httpException';
import { logger } from 'packages/logger';
import { promisify } from 'util';
import { cloudinaryUploader } from '../../../config/cloudinary.config';

class Service {
    constructor() {
        this.logger = logger;
    }

    async uploadOne(file, folderName = '') {
        const extensionsVideo = ['.mp4', 'mov', '.avi', '.mkv'];
        try {
            const isVideo = extensionsVideo.some(ext =>
                file.originalname.endsWith(ext),
            );
            const response = await cloudinaryUploader.upload(file.path, {
                folder: folderName,
                resource_type: isVideo ? 'video' : 'image',
            });

            return {
                originalName: response.original_filename,
                url: response.secure_url,
                publicId: response.public_id,
                resource_type: response.resource_type,
            };
        } catch (error) {
            throw new InternalServerException(error.message);
        } finally {
            try {
                await promisify(unlink)(file.path);
            } catch (error) {
                this.logger.error(error.message);
                // eslint-disable-next-line no-unsafe-finally
                throw new InternalServerException(error.message);
            }
        }
    }

    async uploadMany(files, folderName = '') {
        const uploadTasks = files.map(file => this.uploadOne(file, folderName));

        return Promise.all(uploadTasks);
    }

    async deleteMany(ids) {
        const deleteTasks = ids.map(id => this.deleteOne(id));

        return Promise.all(deleteTasks);
    }

    async deleteOne(id) {
        const response = await cloudinaryUploader.destroy(id);
        return {
            id,
            ...response,
        };
    }
}

export const MediaService = new Service();
