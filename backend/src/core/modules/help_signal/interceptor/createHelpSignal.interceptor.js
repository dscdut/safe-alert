import { DefaultValidatorInterceptor } from 'core/infrastructure/interceptor';
import { JoiUtils } from 'core/utils';
import Joi from 'joi';

export const createHelpSignalInterceptor = new DefaultValidatorInterceptor(
    Joi.object({
        latitude: Joi.number().required().min(-90).max(90),
        longitude: Joi.number().required().min(-180).max(180),
        location: JoiUtils.requiredString(),
        description: JoiUtils.optionalString(),
        quantity: Joi.number(),
        emergencyId: JoiUtils.positiveNumber().message(
            'It should be a positive number and greater than 0',
        ),
    })
);
