//* commit convention: <type>[optional scope]: <description>

module.exports = {
    extends: ['@commitlint/config-conventional'],
    rules: {
        'type-enum': [
            2,
            'always',
            [
                'feat', // new feature
                'fix', // fix bug
                'improve', // improve code
                'perf', // improve performance
                'refactor', // refactor code
                'docs', // add or update document
                'chore', // add something without touching production code
                'reformat', // change code format (indentation, spacing, etc)
                'test', // test
                'revert', // revert a previous commit
                'ci', // change ci/cd config
                'build', // changes that affect the build system or external dependencies
                'db', // changes that affect the database
            ],
        ],
        'type-case': [2, 'always', 'lower-case'],
        'type-empty': [2, 'never'],
        'subject-empty': [2, 'never'],
        'subject-full-stop': [2, 'never', '.'],
        'header-max-length': [2, 'always', 72],
        'scope-empty': [0],
    },
};
