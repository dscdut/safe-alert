import { pick } from 'lodash';
import { JwtPayload } from 'core/modules/auth/dto/jwt-sign.dto';
import { BcryptService } from './bcrypt.service';
import { JwtService } from './jwt.service';
import { UserRepository } from '../../user/user.repository';
import {
    DuplicateException,
    UnAuthorizedException,
} from '../../../../packages/httpException';

class Service {
    constructor() {
        this.userRepository = UserRepository;
        this.jwtService = JwtService;
        this.bcryptService = BcryptService;
    }

    async register(registerDto) {
        // check if email is already registered
        const userExists = await this.userRepository.findOneBy(
            'email',
            registerDto.email,
        );
        if (userExists && userExists.length > 0) {
            throw new DuplicateException('Email already registered');
        }

        // check if phone number is already registered
        const phoneNumberExists = await this.userRepository.findOneBy(
            'phone_number',
            registerDto.phone_number,
        );
        if (phoneNumberExists && phoneNumberExists.length > 0) {
            throw new DuplicateException('Phone number already registered');
        }

        // check if password and confirm password match
        if (registerDto.password !== registerDto.confirm_password) {
            throw new UnAuthorizedException(
                'Password and confirm password do not match',
            );
        }

        const user = await this.userRepository.insert({
            email: registerDto.email,
            phone_number: registerDto.phone_number,
            password: this.bcryptService.hash(registerDto.password),
            full_name: registerDto.full_name,
        });

        return {
            userId: user[0].id,
        };
    }

    async login(loginDto) {
        const user = await this.userRepository.findOneBy(
            'phone_number',
            loginDto.phone_number,
        );

        if (
            user &&
            this.bcryptService.compare(loginDto.password, user.password)
        ) {
            return {
                user,
                accessToken: this.jwtService.sign(
                    JwtPayload(this.#getUserInfo(user)),
                ),
            };
        }
        throw new UnAuthorizedException('phoneNumber or password is incorrect');
    }

    #getUserInfo = user => pick(user, ['id', 'email']);
}

export const AuthService = new Service();
