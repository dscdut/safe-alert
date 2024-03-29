import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const RegisterInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        email: JoiUtils.email().required(),
        phoneNumber: JoiUtils.requiredString().min(10),
        fullName: JoiUtils.requiredString().min(1),
        password: JoiUtils.password().required(),
        confirmPassword: JoiUtils.requiredString(),
    }),
);
