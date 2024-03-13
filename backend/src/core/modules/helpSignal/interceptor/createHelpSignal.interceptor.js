import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';
import Joi from 'joi';

export const createHelpSignalInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        location: JoiUtils.requiredString(),
        description: JoiUtils.optionalString(),
        quantity: Joi.number(),
        emergencyId: JoiUtils.positiveNumber().message(
            'It should be a positive number and greater than 0',
        ),
    })
);
