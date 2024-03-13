import { fcmService } from 'core/modules/fcm/service/fcm.service';
import { RelativeService } from 'core/modules/relative/services/relative.service';
import { AddRelativeDto } from '../../modules/relative/dto';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = RelativeService;
        this.fcmService = fcmService;
    }

    getAllRelative = async req => {
        const data = await this.service.getAllRelative(req.user.payload.id);
        return ValidHttpResponse.toOkResponse(data);
    };

    addRelative = async req => {
        const userId = req.user.payload.id;
        const relativeId = req.params.id;
        const relative = { ...req.body};
        const data = await this.service.addRelative(AddRelativeDto(relative), userId, relativeId);
        return ValidHttpResponse.toOkResponse(data);
    };

    deleteRelative = async req => {
        const data = await this.service.deleteRelative(req.user.payload.id, req.params.id);
        return ValidHttpResponse.toOkResponse(data);
    };

}

export const RelativeController = new Controller();
