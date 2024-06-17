import { getDb } from './Connection.js'

async function getSales() {
  const db = await getDb()
  const [results] = await db.execute('SELECT * FROM sales')
  return results
}

export { getSales }
