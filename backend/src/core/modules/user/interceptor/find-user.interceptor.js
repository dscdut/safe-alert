import Joi from 'joi';
import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from '../../../utils';

export const FindUserInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        phone: JoiUtils.requiredString(),
    })
);
