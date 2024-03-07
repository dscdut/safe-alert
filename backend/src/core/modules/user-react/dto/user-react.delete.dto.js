import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';
import {
    REACTION_IN_REQUEST_OF_TYPE,
    REACTION_OF_TYPE,
} from '../user-react.const';

ApiDocument.addModel('DeleteUserReactDto', {
    reactableId: SwaggerDocument.ApiProperty({ type: 'int' }),
    reactableType: SwaggerDocument.ApiProperty({
        type: 'enum',
        model: REACTION_IN_REQUEST_OF_TYPE,
    }),
});

export const DeleteUserReactDto = body => ({
    reactableId: body.reactableId,
    reactableType: REACTION_OF_TYPE[body.reactableType],
});
