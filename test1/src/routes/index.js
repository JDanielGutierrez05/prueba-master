var express = require('express')
var router = express.Router()

const { Octokit } = require('@octokit/rest')

/**
 * @swagger
 * /index:
 *   get:
 *     produces:
 *       - application/json
 *     responses:
 *       200:
 *         description: Successful
 *       500:
 *         description: Rate Limit Exceeded
 */
router.get('/', async function (req, res, next) {
  try {
    const response = await fetchAllRepos('google')

    const repositories = response
      .sort((a, b) => b.stargazers_count - a.stargazers_count)
      .slice(0, 10)

    return res.status(200).json({ repositories })
  } catch (error) {
    next(error)
  }
})

async function fetchAllRepos(username) {
  const octokit = new Octokit({})

  let page = 1
  let repos = []
  let response

  do {
    response = await octokit.repos.listForUser({
      username,
      per_page: 100,
      page,
    })
    repos = repos.concat(response.data)
    page++
  } while (response.data.length === 100)

  return repos
}

module.exports = router
