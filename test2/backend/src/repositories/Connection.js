import mysql from 'mysql2/promise'
import { getSecretValue } from '../services/SecretsManager.js'

let db

async function getDb() {
  if (!db) {
    const connectionDetails = await getSecretValue(
      process.env.DB_CONNECTION_DATA
    )

    db = await mysql.createConnection({
      database: connectionDetails.dbname,
      host: connectionDetails.host,
      port: connectionDetails.port,
      password: connectionDetails.password,
      user: connectionDetails.username,
    })
  }
  return db
}

export { getDb }
