export const handler = async (event) => {
  try {
    const body = JSON.parse(event.body)
    const filteredPriceProducts = body.filter(
      (product) => product.price > 10000
    )
    return filteredPriceProducts.map((product) => {
      return {
        id: product.id,
        name: product.name.toUpperCase(),
        price: product.price,
      }
    })
  } catch (error) {
    console.error(error)
    throw error
  }
}
