export const Statuss = {
    TEST_AUTHORIZATION: {
        name: 'UPDATE_PUBLIC_TASK',
        dataPreload: 'local=UserService.mustBeAuthor()',
        policies: ['UserService.isRoleAdmin(authContext,something)']
    }
};

export const Status = {
    WAITING: {
        value: 0,
        description: ['waiting for support']
    },
    ACCEPTED: {
        value: 1,
        description: ['One person has accepted support']
    },
    DONE: {
        value: 2,
        description: ['Enough people to support']
    },
    CANCEL: {
        value: -1,
        description: ['Cancel signal']
    }
};