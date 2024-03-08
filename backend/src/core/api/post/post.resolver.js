import { Module } from 'packages/handler/Module';
import { PostController } from './post.controller';
import { postId, uploadMediaSwagger, userId } from 'core/common/swagger';
import { MediaInterceptor } from 'core/modules/document';

export const PostResolver = Module.builder()
    .addPrefix({
        prefixPath: '/posts',
        tag: 'posts',
        module: 'PostModule',
    })
    .register([
        {
            route: '/:postId',
            method: 'get',
            controller: PostController.findPostById,
            params: [postId],
            preAuthorization: true,
        },
        {
            route: '/:userId/findPostsByOwnerId',
            method: 'get',
            controller: PostController.findPostsByOwnerId,
            params: [userId],
            preAuthorization: true,
        },
        {
            route: '/',
            method: 'post',
            interceptors: [new MediaInterceptor(10)],
            body: 'createPostDto',
            params: [uploadMediaSwagger],
            consumes: ['multipart/form-data'],
            controller: PostController.createPost,
            preAuthorization: true,
        },
        {
            route: '/:postId',
            method: 'put',
            interceptors: [new MediaInterceptor(10)],
            body: 'createPostDto',
            params: [uploadMediaSwagger, postId],
            consumes: ['multipart/form-data'],
            controller: PostController.updatePost,
            preAuthorization: true,
        },
    ]);
