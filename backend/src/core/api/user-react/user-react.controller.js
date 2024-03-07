import { ValidHttpResponse } from 'packages/handler/response/validHttp.response';
import { MessageDto } from 'core/common/dto';
import { UserReactService } from 'core/modules/user-react/service/user-react.service';
import {
    AddUserReactDto,
    DeleteUserReactDto,
} from 'core/modules/user-react/dto';

class Controller {
    constructor() {
        this.userReactService = UserReactService;
    }

    createUserReact = async req => {
        const { reactableId, reactableType, reactType } = AddUserReactDto(
            req.body,
        );
        await this.userReactService.createUserReact(
            req.user.payload.id,
            reactableId,
            reactableType,
            reactType,
        );
        return ValidHttpResponse.toOkResponse(MessageDto('UserReact created'));
    };

    deleteUserReact = async req => {
        const { reactableType, reactableId } = DeleteUserReactDto(req.body);
        await this.userReactService.deleteUserReact(
            req.user.payload.id,
            reactableId,
            reactableType,
        );
        return ValidHttpResponse.toOkResponse(MessageDto('UserReact deleted'));
    };
}

export const UserReactController = new Controller();
