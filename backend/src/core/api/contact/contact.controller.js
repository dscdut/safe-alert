import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';
import { ContactService } from 'core/modules/contact/service/contact.service';

class Controller {
    constructor() {
        this.service = ContactService;
    }

    findContactsByEmergencyId = async req => {
        const data = await this.service.findContactsByEmergencyId(req.params.emergencyId);
        return ValidHttpResponse.toOkResponse(data);
    };

    findGroupTeamByScope = async req => {
        const emergencyId = req.params.emergencyId;
        const distance = req.query.distance * 1000;
        const coordinates = { latitude: req.query.latitude, longitude: req.query.longitude };

        const data = await this.service.findGroupTeamByScope(emergencyId, distance, coordinates);
        return ValidHttpResponse.toOkResponse(data);
    }
}

export const ContactController = new Controller();
