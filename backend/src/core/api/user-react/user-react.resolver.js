import { Module } from 'packages/handler/Module';
import { UserReactController } from './user-react.controller';

export const UserReactResolver = Module.builder()
    .addPrefix({
        prefixPath: '/user-reacts',
        tag: 'user-reacts',
        module: 'UserReactModule',
    })
    .register([
        {
            route: '',
            method: 'post',
            controller: UserReactController.createUserReact,
            body: 'AddUserReactDto',
            model: { $ref: 'MessageDto' },
            preAuthorization: true,
            description:
                'Do LIKE or DISLIKE to a comment or post actioned by user',
        },
        {
            route: '',
            method: 'delete',
            controller: UserReactController.deleteUserReact,
            body: 'DeleteUserReactDto',
            model: { $ref: 'MessageDto' },
            description:
                'Delete a LIKE or DISLIKE of a comment or post actioned by owner',
            preAuthorization: true,
        },
    ]);
