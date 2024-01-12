import { AuthService } from '../../modules/auth/service/auth.service';
import { LoginDto } from '../../modules/auth';
import { ValidHttpResponse } from '../../../packages/handler/response/validHttp.response';

class Controller {
    constructor() {
        this.service = AuthService;
    }

    register = async req => {
        const data = await this.service.register(req.body);
        return ValidHttpResponse.toOkResponse(data);
    };

    login = async req => {
        const data = await this.service.login(LoginDto(req.body));
        return ValidHttpResponse.toOkResponse(data);
    };
}

export const AuthController = new Controller();
