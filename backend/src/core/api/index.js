import { MediaResolver } from 'core/api/media';
import { UserResolver } from 'core/api/user/user.resolver';
import { ApiDocument } from 'core/config/swagger.config';
import { HelpSignalResolver } from 'core/api/helpSignal';
import { HandlerResolver } from '../../packages/handler/HandlerResolver';
import { AuthResolver } from './auth/auth.resolver';
import { EmergencyResolver } from './emergency';
import { RelativeResolver } from './relative';
import { CommentResolver } from './comment/comment.resolver';
import { UserReactResolver } from './user-react/user-react.resolver';
import { ContactResolver } from './contact/contact.resolver';
import { PostResolver } from './post/post.resolver';

export const ModuleResolver = HandlerResolver.builder()
    .addSwaggerBuilder(ApiDocument)
    .addModule([
        AuthResolver,
        UserResolver,
        MediaResolver,
        HelpSignalResolver,
        EmergencyResolver,
        RelativeResolver,
        CommentResolver,
        UserReactResolver,
        ContactResolver,
        PostResolver
    ]);
