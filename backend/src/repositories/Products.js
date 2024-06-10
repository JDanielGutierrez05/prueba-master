import { getDb } from './Connection.js'

async function getProducts() {
  const db = await getDb()
  const [results] = await db.execute('SELECT * FROM products')
  return results
}

export { getProducts }
