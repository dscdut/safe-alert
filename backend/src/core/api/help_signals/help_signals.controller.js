import { HelpSignalService } from '../../modules/help_signals/service/help_signals.service';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = HelpSignalService;
    }

    updateHelpSignalByStatus = async req => {
        const update = await this.service.updateHelpSignalByStatus(req.params.helpSignalId , req.user.payload.id);
        return ValidHttpResponse.toNoContentResponse(update);
    };
}

export const HelpSignalController = new Controller();
