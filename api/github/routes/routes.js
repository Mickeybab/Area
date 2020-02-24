'use strict';

var cors = require('cors')

module.exports = function (app) {
    var controllers = require('../controllers/controllers');

    app.options('*', cors())

    // Incomes
    app.route('/v1/github/:owner/:repo/last/issue')
        .get(controllers.getRepoLastIssue)

    app.route('/v1/github/:owner/:repo/last/pull')
        .get(controllers.getRepoLastPull)

    app.route('/v1/github/:owner/:repo/last/commit')
        .get(controllers.getRepoLastCommit)

    app.route('/v1/github/:owner/:repo/merge/:pr')
        .get(controllers.mergePullRequest)

    app.route('/v1/github/:owner/:repo/:pr/last/commit')
        .get(controllers.getPullRequestCommits)
};