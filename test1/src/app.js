let express = require('express')
let logger = require('morgan')

const swaggerUi = require('swagger-ui-express')
const swaggerSpec = require('./swaggerConfig')
const errorHandler = require('./middleware/error')

let indexRouter = require('./routes/index')

let app = express()

app.use(logger('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec))
app.use('/index', indexRouter)

app.use(errorHandler)

module.exports = app
