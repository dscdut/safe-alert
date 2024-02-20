import admin from 'firebase-admin';
import serviceAccount from './serviceAccount.json';

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

export const adminApp = admin;
