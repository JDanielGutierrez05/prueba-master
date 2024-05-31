const errorHandler = (err, req, res, next) => {
  console.error(err)

  let errStatus = 500
  let errMsgs = err.message

  res.status(errStatus).json({ errors: errMsgs })
}

module.exports = errorHandler
