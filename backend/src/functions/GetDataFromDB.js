import { getProducts } from '../repositories/Products.js'
import { getSales } from '../repositories/Sales.js'

export const handler = async (event) => {
  try {
    const products = await getProducts()
    const sales = await getSales()

    return {
      products,
      sales: products.map((prod) => {
        return {
          result: prod.name,
          quantity: sales.filter((sale) => sale.product_id === prod.id).length,
        }
      }),
      higherPriceProduct: products.reduce((maxPriceProduct, currentProduct) => {
        return currentProduct.price > maxPriceProduct.price
          ? currentProduct
          : maxPriceProduct
      }, products[0]),
    }
  } catch (error) {
    console.error(error)
    throw error
  }
}
