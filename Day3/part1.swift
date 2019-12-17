enum direction {

	case xAxis, yAxis
}

struct Step {
	var x1: Int;
	var x2: Int;
	var y1: Int;
	var y2: Int;

	var isOnXAxis: Bool {
		return self.y1 == self.y2
	}
	var isOnYAxis: Bool {
		return self.x1 == self.x2
	}

	init(x1: Int, x2: Int, y1: Int, y2: Int){
		self.x1 = x1
		self.x2 = x2
		self.y1 = y1
		self.y2 = y2
	}

	func toString() -> String {
		return "(\(x1), \(y1)) -> (\(x2), \(y2))"
	}

}

struct Wire {

	var wiring: [String] = [String]()

	public init(input: [String]){
		wiring = input
	}

	public func wire() -> [Step] {

		var x: Int = 0;
		var y: Int = 0;

		var positions: [Step] = []
		for step in wiring {
			let distance = Int( step.suffix(step.count - 1) )
			switch (step.prefix(1)) {
				case "U":
				let newStep: Step = Step(x1: x, x2: x, y1: y, y2: y + distance!)
				positions.append(newStep)
				y += distance!
				case "R":
				let newStep: Step = Step(x1: x, x2: x + distance!, y1: y, y2: y)
				positions.append(newStep)
				x += distance!
				case "D":
				let newStep: Step = Step(x1: x, x2: x, y1: y - distance!, y2: y)
				positions.append(newStep)
				y -= distance!
				case "L":
				let newStep: Step = Step(x1: x - distance!, x2: x, y1: y, y2: y)
				positions.append(newStep)
				x -= distance!
				default:
				print("Error in switch")
			}
		}
		return positions
	}
}

func parseInput() -> [String] {

	let array = readLine()?
		.split {$0 == ","}
		.map (String.init)

	if let stringArray = array {
		return stringArray
	}

	return [""]

}

func findDistance(step1: Step, step2: Step) -> Int {
	if (step1.isOnXAxis && step2.isOnYAxis){
		if (step1.x1 < step2.x1 && step1.x2 > step2.x1
			&& step1.y1 > step2.y1 && step1.y1 < step2.y2){
			print("step1 on x axis")
			return abs(step2.x1) + abs(step1.y1)
		}
	} else if (step1.isOnYAxis && step2.isOnXAxis){
		if (step1.y1 < step2.y1 && step1.y2 > step2.y1
			&& step1.x1 > step2.x1 && step1.x1 < step2.x2){
			print("step1 on y axis")
			return abs(step1.x1) + abs(step2.y1)
		}
	}
	return 0
}

let wire1: Wire = Wire(input: parseInput())
let wire2: Wire = Wire(input: parseInput())

let wiring1 = wire1.wire();
let wiring2 = wire2.wire();

var shortestDistance = 0;

for i in 0...(wiring1.count-1) {
    for j in 0...(wiring2.count-1) {
		let distance = findDistance(step1: wiring1[i], step2: wiring2[j])
		if( (distance != 0 && shortestDistance == 0) || (distance != 0 && distance < shortestDistance) ){
			shortestDistance = distance
		}
	}
}

print(shortestDistance)