import { NODE_ENV } from 'core/env';

export function sendErrorToSentry(sentry, error) {
    if (NODE_ENV === 'production') {
        sentry.captureException(error);
        sentry.flush(2000);
    }
}
