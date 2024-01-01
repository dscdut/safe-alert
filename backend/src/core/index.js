import 'dotenv/config';
import express from 'express';
import { SecurityFilter } from 'packages/authModel/core/security/SecurityFilter';
import { ApiDocument } from 'core/config/swagger.config';
import * as Sentry from '@sentry/node';
import { HttpExceptionFilter } from '../packages/httpException/HttpExceptionFilter';
import { InvalidUrlFilter } from '../packages/handler/filter/InvalidUrlFilter';
import { AppBundle } from './config';
import { ModuleResolver } from './api';
import { SENTRY_DSN } from './env';

const app = express();

Sentry.init({
    dsn: SENTRY_DSN,
});

(async () => {
    await AppBundle.builder()
        .applyAppContext(app)
        .init()
        .applyGlobalFilters([new SecurityFilter()])
        .applyResolver(ModuleResolver)
        .applySwagger(ApiDocument)
        .applyGlobalFilters([new HttpExceptionFilter(), new InvalidUrlFilter()])
        .applySentryError(Sentry)
        .run();
})();

export default app;
