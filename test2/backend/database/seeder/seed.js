const AWS = require('aws-sdk')
const mysql = require('mysql2/promise')
const fs = require('fs').promises
const path = require('path')

// AWS SDK configuration
AWS.config.update({ region: 'us-east-1' })
const secretsManager = new AWS.SecretsManager()

async function getSecret(secretName) {
  try {
    const data = await secretsManager
      .getSecretValue({ SecretId: secretName })
      .promise()
    if ('SecretString' in data) {
      return JSON.parse(data.SecretString)
    } else {
      throw new Error(`Secret ${secretName} not found.`)
    }
  } catch (err) {
    console.error('Error retrieving secret:', err)
    throw err
  }
}

async function seedDatabase() {
  try {
    const secret = await getSecret('/test2-infrastructure/AppCredentials')

    const connection = await mysql.createConnection({
      host: secret.host,
      user: secret.username,
      password: secret.password,
      database: secret.dbname,
    })

    console.log('Connected to the database.')

    const sqlFilePath = path.join(__dirname, 'data.sql')
    const sql = await fs.readFile(sqlFilePath, 'utf8')

    const sqlStatements = sql
      .split(';')
      .filter((statement) => statement.trim() !== '')

    for (const statement of sqlStatements) {
      await connection.query(statement)
    }

    console.log('Database seeded successfully.')

    await connection.end()
    console.log('Connection closed.')
  } catch (error) {
    console.error('Error:', error)
  }
}

seedDatabase()
