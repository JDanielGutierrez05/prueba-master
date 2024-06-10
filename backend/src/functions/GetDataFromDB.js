import { getProducts } from '../repositories/Products.js'

export const handler = async (event) => {
  try {
    return await getProducts()
  } catch (error) {
    console.error(error)
    throw error
  }
}
