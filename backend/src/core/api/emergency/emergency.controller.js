import { EmergencyService } from 'core/modules/emergency/servicce/emergency.service';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = EmergencyService;
    }

    getAllEmergency = async () => {
        const data = await this.service.getAllEmergency();
        return ValidHttpResponse.toOkResponse(data);
    };

}

export const EmergencyController = new Controller();
