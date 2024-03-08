import { PostService } from 'core/modules/post/service/post.service';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';
import { createPostDto } from 'core/modules/post/dto/createPost.dto';

class Controller {
    constructor() {
        this.service = PostService;
    }

    findPostById = async req => {
        const data = await this.service.findPostById(req.params.postId);
        return ValidHttpResponse.toOkResponse(data);
    };

    findPostsByOwnerId = async req => {
        const data = await this.service.findPostsByOwnerId(req.params.userId);
        return ValidHttpResponse.toOkResponse(data);
    }

    createPost = async req => {
        const post = { ...req.body, ownerId: req.user.payload.id };
        const data = await this.service.createPost(createPostDto(post), req);
        return ValidHttpResponse.toCreatedResponse(data);
    }

    updatePost = async req => {
        const data = await this.service.updatePost(req.params.postId, createPostDto(req.body), req.user.payload.id, req);
        return ValidHttpResponse.toOkResponse(data);
    }
}

export const PostController = new Controller();
