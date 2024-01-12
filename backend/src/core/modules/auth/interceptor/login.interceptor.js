import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';
import Joi from 'joi';

export const LoginInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        phoneNumber: JoiUtils.requiredString().min(10),
        password: JoiUtils.requiredString(),
    })
);
