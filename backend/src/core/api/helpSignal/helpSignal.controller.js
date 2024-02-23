import { createHelpSignalDto } from 'core/modules/helpSignal/dto';
import { HelpSignalService } from 'core/modules/helpSignal/service/helpSignal.service';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = HelpSignalService;
    }

    createHelpSignal = async req => {
        const signal = { ...req.body, statusId: 0, userId: req.user.payload.id };
        const data = await this.service.createHelpSignal(createHelpSignalDto(signal), req);
        return ValidHttpResponse.toCreatedResponse(data);
    }

    findHelpSignalById = async req => {
        const data = await this.service.findHelpSignalById(req.params.helpSignalId);
        return ValidHttpResponse.toOkResponse(data);
    }

    getAllHelpSignals = async () => {
        const data = await this.service.getAllHelpSignals();
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
        const data = await this.service.updateHelpSignal(req.params.helpSignalId, createHelpSignalDto(req.body), req.user.payload.id, req);
        return ValidHttpResponse.toOkResponse(data);
    }

    deleteHelpSignal = async req => {
        const message = await this.service.deleteHelpSignal(req.params.helpSignalId, req.user.payload.id);
        return ValidHttpResponse.toOkResponse(message);
    }

}

export const HelpSignalController = new Controller();
