import admin from 'firebase-admin';
import serviceAccount from './google-services.json';

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

export const adminApp = admin;
