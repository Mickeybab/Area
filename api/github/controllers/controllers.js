var model = require('../models/models')


module.exports = {
    getPullRequestCommits,
    mergePullRequest,
    getRepoLastCommit,
    getRepoLastIssue,
    getRepoLastPull
}

function getPullRequestCommits(req, res) {
    res.set('Content-Type', 'application/json');

    let repo = req.params.repo
    let owner = req.params.owner
    let pr = req.params.pr
    let auth = req.get('Authorization')

    model.getPullRequestCommits(auth, owner, repo, pr).then(function (json) {
        console.log(json)
        var data = Array(json.length)
        for (let index = 0; index < json.length; index++) {
            const element = json[index];
            var newelem = {}
            newelem.message = element.commit.message
            newelem.date = element.commit.author.date
            newelem.author = element.commit.author.email
            data[index] = newelem
        }
        res.status(200).json({ status: 'success', code: 200, data: data })
    }).catch((err) => setImmediate(() => {
        console.log(err)
        res.status(400).json({ status: 'failure', code: 400, error: err })
    }))
}

function mergePullRequest(req, res) {
    res.set('Content-Type', 'application/json');

    let repo = req.params.repo
    let owner = req.params.owner
    let pr = req.params.pr
    let auth = req.get('Authorization')

    model.mergePullRequest(auth, owner, repo, pr).then(function (json) {
        console.log(json)
        res.status(200).json({ status: 'success', code: 200, data: json })
    }).catch((err) => setImmediate(() => {
        console.log(err)
        res.status(400).json({ status: 'failure', code: 400, error: err })
    }))
}

function getRepoLastCommit(req, res) {
    res.set('Content-Type', 'application/json');

    let repo = req.params.repo
    let owner = req.params.owner
    let auth = req.get('Authorization')

    model.getLastCommit(auth, owner, repo).then(function (json) {
        var data = {}
        data.size = json.length
        data.commits = Array(data.size)
        for (let index = 0; index < json.length; index++) {
            const element = json[index];
            var newelem = {}
            newelem.message = element.commit.message
            newelem.author = element.commit.author.name
            newelem.url = element.commit.url
            newelem.date = element.commit.author.date
            data.commits[index] = newelem
        }
        // console.log(json)
        res.status(200).json({ status: 'success', code: 200, data: data })
    }).catch((err) => setImmediate(() => {
        console.log(err)
        res.status(400).json({ status: 'failure', code: 400, error: err })
    }))
    return
}

function getRepoLastIssue(req, res) {
    res.set('Content-Type', 'application/json');

    let repo = req.params.repo
    let owner = req.params.owner
    let auth = req.get('Authorization')

    model.getLastIssueOfRepo(auth, owner, repo).then(function (json) {
        var data = {}
        if (json.length > 0) {
            data.name = json[0].title
            data.url = json[0].html_url
            data.number = json[0].number
        }
        res.status(200).json({ status: 'success', code: 200, data: data })
    }).catch((err) => setImmediate(() => {
        console.log(err)
        res.status(400).json({ status: 'failure', code: 400, error: err })
    }))
    return
}

function getRepoLastPull(req, res) {
    res.set('Content-Type', 'application/json');

    let repo = req.params.repo
    let owner = req.params.owner
    let auth = req.get('Authorization')

    model.getLastPullOfRepo(auth, owner, repo).then(function (json) {
        var data = {}
        if (json.length > 0) {
            data.name = json[0].title
            data.url = json[0].url
            data.number = json[0].number
        }
        res.status(200).json({ status: 'success', code: 200, data: data })
    }).catch((err) => setImmediate(() => {
        console.log(err)
        res.status(400).json({ status: 'failure', code: 400, error: err })
    }))
    return
}