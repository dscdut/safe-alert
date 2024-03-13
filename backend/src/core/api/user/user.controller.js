import { fcmService } from 'core/modules/fcm/service/fcm.service';
import { UserService } from '../../modules/user/services/user.service';
import { CreateUserDto, UpdateUserDto, FindUserDto } from '../../modules/user/dto';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = UserService;
        this.fcmService = fcmService;
    }

    updateOne = async req => {
        await this.service.updateOne(UpdateUserDto(req.body), req.user.payload.id);
        return ValidHttpResponse.toNoContentResponse();
    };

    createOne = async req => {
        const data = await this.service.createOne(CreateUserDto(req.body));
        return ValidHttpResponse.toCreatedResponse(data[0]);
    };

    findById = async req => {
        const data = await this.service.findById(req.params.id);
        return ValidHttpResponse.toOkResponse(data);
    };

    findByPhoneNumber = async req => {
        const data = await this.service.findByPhoneNumber(FindUserDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    };

    saveToken = async req => {
        const userId = req.user.payload.id;
        const token = req.params.deviceToken;
        const data = await this.fcmService.saveToken(userId, token);
        return ValidHttpResponse.toCreatedResponse(data);
    };

}

export const UserController = new Controller();
