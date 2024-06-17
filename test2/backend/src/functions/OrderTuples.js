export const handler = async (event) => {
  try {
    const people = [
      ['Alice', 30],
      ['Bob', 25],
      ['Charlie', 35],
      ['Diana', 28],
      ['Eve', 32],
      ['Frank', 27],
      ['Grace', 22],
      ['Hank', 40],
      ['Ivy', 29],
      ['Jack', 33],
      ['Kathy', 24],
      ['Leo', 36],
      ['Mona', 31],
      ['Nick', 26],
      ['Olivia', 38],
      ['Paul', 23],
      ['Quinn', 34],
      ['Rita', 21],
      ['Sam', 39],
      ['Tina', 37],
    ]

    people.sort((a, b) => a[1] - b[1])
    return people
  } catch (error) {
    console.error(error)
    throw error
  }
}
