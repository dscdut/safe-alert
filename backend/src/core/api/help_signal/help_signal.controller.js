import { createHelpSignalDto } from 'core/modules/help_signal/dto';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';
import { HelpSignalService } from 'core/modules/help_signal/service/help_signal.service';
import { logger } from 'packages/logger';

class Controller {
    constructor() {
        this.service = HelpSignalService;
    }

    createHelpSignal = async req => {
        let signal = { ...req.body, status_id: 0, user_id: req.user.payload.id };
        const { files } = req;
        const data = await this.service.createHelpSignal(createHelpSignalDto(signal), files);
        return ValidHttpResponse.toCreatedResponse(data);
    }

    findHelpSignalById = async req => {
        const data = await this.service.findHelpSignalById(req.params.helpSignalId);
        return ValidHttpResponse.toOkResponse(data);
    }

    findHelpSignalsByUserId = async req => {
        const data = await this.service.findHelpSignalsByUserId(req.params.userId);
        return ValidHttpResponse.toOkResponse(data);
    }

    findHelpSignalsByEmergencyId = async req => {
        const data = await this.service.findHelpSignalsByEmergencyId(req.params.emergencyId);
        return ValidHttpResponse.toOkResponse(data);
    }

    updateHelpSignal = async req => {
        const data = await this.service.updateHelpSignal(req.params.helpSignalId, createHelpSignalDto(req.body), req);
        return ValidHttpResponse.toOkResponse(data);
    }

    deleteHelpSignal = async req => {
        const message = await this.service.deleteHelpSignal(req.params.helpSignalId);
        return ValidHttpResponse.toOkResponse(message);
    }

}

export const HelpSignalController = new Controller();
