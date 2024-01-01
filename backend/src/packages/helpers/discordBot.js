import axios from 'axios';

class DiscordBot {
    #webhook;

    #username;

    #avatar_url;

    constructor(webhook, botName, avatarUrl) {
        this.#webhook = webhook;
        this.#username = botName;
        this.#avatar_url = avatarUrl;
    }

    async logError(content) {
        try {
            const url = this.#webhook;
            const data = {
                username: this.#username,
                avatar_url: this.#avatar_url,
                content,
            };
            await axios.post(url, data);
        } catch (error) {
            // eslint-disable-next-line no-console
            console.error(error);
        }
    }
}

export default DiscordBot;
