
struct Position {
	let x: Int
	let y: Int

	init(x: Int, y: Int) {
		self.x = x
		self.y = y
	}
	
}

class Point {
	var asteroid: Bool
	var position: Position

	init(asteroid: Bool, position: Position) {
		self.asteroid = asteroid
		self.position = position
	}
}


struct Grid {

	var grid: [[Point]] = []

	func printGrid() -> Void {
		for row in grid {
			print(row)
		}
	}
	
}

var grid: Grid = Grid()

while var row = readLine().map{$0} {
	var pointRow: [Point] = []
	for i in 0...(row.count - 1) {
		let point = Point(asteroid: row[i] == "#", position: Position(x: i, y: grid.grid.count))
		pointRow.append(point)
	}
	grid.grid.append(pointRow)
}

grid.printGrid()