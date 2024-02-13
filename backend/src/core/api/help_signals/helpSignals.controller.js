import { HelpSignalService } from 'core/modules/helpSignals/services/helpSignal.service';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.helpSignalService = HelpSignalService;
    }

    updateHelpSignalByStatus = async req => {
        const update = await this.helpSignalService.updateHelpSignalByStatus(req.params.helpSignalId , req.user.payload.id);
        return ValidHttpResponse.toOkResponse(update);
    };
}

export const HelpSignalController = new Controller();