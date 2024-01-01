import { DISCORD, NODE_ENV } from 'core/env';
import DiscordBot from 'packages/helpers/discordBot';

export async function logErrorToDiscord(err) {
    if (NODE_ENV === 'development') {
        const discordBot = new DiscordBot(
            DISCORD.WEBHOOK,
            DISCORD.BOT_NAME,
            DISCORD.BOT_AVATAR_URL,
        );
        await discordBot.logError(
            `**${err.name}**\n\`\`\`${err.message}\`\`\`\n**Stack Trace**\n\`\`\`${err.stack}\`\`\``,
        );
    }
}
