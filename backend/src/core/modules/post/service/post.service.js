import { Optional, logger } from '../../../utils';
import { ForbiddenException, InternalServerException, NotFoundException } from '../../../../packages/httpException';
import { PostRepository } from '../repository/post.repository';
import { MediaService } from 'core/modules/document';
import { getTransaction } from 'core/database';

class Service {
    constructor() {
        this.repository = PostRepository;
        this.MediaService = MediaService
    }

    async findPostById(postId) {
        const data = Optional.of(await this.repository.findBy('id', postId))
            .throwIfNotPresent(new NotFoundException())
            .get();

        return data[0];
    }

    async findPostsByOwnerId(ownerId) {
        const data = Optional.of(await this.repository.findBy('owner_id', ownerId))
            .throwIfNotPresent(new NotFoundException())
            .get();

        return data;
    }

    getUrls(medias) {
        let images = '';
        medias.forEach(element => { images += `${element.url},`; });
        return images.slice(0, -1);
    }

    async createPost(createPostDto, { file, files }) {
        try {
            const images = file ? [file] : files || [];
            if (images && images.length !== 0) {
                const medias = await this.MediaService.uploadMany(images);
                const imagesURL = this.getUrls(medias);
                createPostDto.medias = imagesURL;
            }
            const post = await this.repository.insert(createPostDto);

            return {
                message: "You have just successfully created a post",
                postId: post[0].id,
            };
        } catch (error) {
            logger.error(error.message);
            throw new InternalServerException(error.message);
        }
    }

    async updatePost(postId, PostDto, ownerId, { file, files }) {
        const post = await this.findPostById(postId);

        if (!post) {
            throw new NotFoundException("Post not found");
        }

        if (post.owner_id !== ownerId) {
            throw new ForbiddenException('You do not have permission to update this post');
        }
        const images = file ? [file] : files || [];
        const trx = await getTransaction();

        try {

            if (images && images.length !== 0) {
                const medias = await this.MediaService.uploadMany(images);
                const imagesURL = this.getUrls(medias);
                PostDto.medias = post.images + ',' + imagesURL;
            } else {
                PostDto.medias = post.images;
            }

            await this.repository.update(postId, PostDto, trx);

            trx.commit();

            return {
                message: "You have just successfully edited the post",
                postId: postId,
            };

        } catch (error) {
            await trx.rollback();
            logger.error(error.message);
            throw new InternalServerException();
        }
    }
}

export const PostService = new Service();
