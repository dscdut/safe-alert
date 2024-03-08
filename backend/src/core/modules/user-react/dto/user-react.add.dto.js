import { ApiDocument } from 'core/config/swagger.config';
import { SwaggerDocument } from 'packages/swagger';
import {
    REACTION_IN_REQUEST_OF_TYPE,
    REACTION_OF_TYPE,
    REACTION_TYPE,
    REACTION_TYPE_IN_REQUEST,
} from '../user-react.const';

ApiDocument.addModel('AddUserReactDto', {
    reactableId: SwaggerDocument.ApiProperty({ type: 'int' }),
    reactableType: SwaggerDocument.ApiProperty({
        type: 'enum',
        model: REACTION_IN_REQUEST_OF_TYPE,
    }),
    reactType: SwaggerDocument.ApiProperty({
        type: 'enum',
        model: REACTION_TYPE_IN_REQUEST,
    }),
});

export const AddUserReactDto = body => ({
    reactableId: body.reactableId,
    reactableType: REACTION_OF_TYPE[body.reactableType],
    reactType: REACTION_TYPE[body.reactType],
});
