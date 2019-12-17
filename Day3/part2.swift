enum direction {

	case L, R, U, D
}


struct Step {
	var x1: Int;
	var x2: Int;
	var y1: Int;
	var y2: Int;
	var distance: Int;
	var direction: direction;

	var isOnXAxis: Bool {
		return self.y1 == self.y2
	}
	var isOnYAxis: Bool {
		return self.x1 == self.x2
	}

	init(x1: Int, x2: Int, y1: Int, y2: Int, distance: Int, direction: direction){
		self.x1 = x1
		self.x2 = x2
		self.y1 = y1
		self.y2 = y2
		self.distance = distance
		self.direction = direction
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
				let newStep: Step = Step(x1: x, x2: x, y1: y, y2: y + distance!, distance: distance!, direction: direction.U)
				positions.append(newStep)
				y += distance!
				case "R":
				let newStep: Step = Step(x1: x, x2: x + distance!, y1: y, y2: y, distance: distance!, direction: direction.R)
				positions.append(newStep)
				x += distance!
				case "D":
				let newStep: Step = Step(x1: x, x2: x, y1: y - distance!, y2: y, distance: distance!, direction: direction.D)
				positions.append(newStep)
				y -= distance!
				case "L":
				let newStep: Step = Step(x1: x - distance!, x2: x, y1: y, y2: y, distance: distance!, direction: direction.L)
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
				if(step1.direction == direction.R){
					return abs(step2.x2 - step1.x1)
				} else {
					return abs(step1.x2 - step2.x2)
				}
		}
	} else if (step1.isOnYAxis && step2.isOnXAxis){
		if (step1.y1 < step2.y1 && step1.y2 > step2.y1
			&& step1.x1 > step2.x1 && step1.x1 < step2.x2){
				if(step1.direction == direction.U){
					return abs(step2.y2 - step1.y1)
				} else {
					return abs(step1.y2 - step2.y1)
				}
		}
	}
	return 0
}

func sumUpWireLength(wiring: [Step], index: Int) -> Int {
	var i = 0;
	var length = 0;
	while(i < index ){
		length += wiring[i].distance
		i += 1
	}
	return length
}

func findFirstIntersectionWireLength(wiring1: [Step], wiring2: [Step]) -> Int {

	for i in 0...(wiring1.count-1) {
		for j in 0...(wiring2.count-1) {
			let distance1 = findDistance(step1: wiring1[i], step2: wiring2[j])
			let distance2 = findDistance(step1: wiring2[j], step2: wiring1[i])
			if(distance1 != 0 && distance2 != 0){
				print(sumUpWireLength(wiring: wiring1, index: i), sumUpWireLength(wiring: wiring2, index: j), distance1 , distance2)
				return sumUpWireLength(wiring: wiring1, index: i) + sumUpWireLength(wiring: wiring2, index: j) + distance1 + distance2
			}
		}
	}

	return -1
}

let wire1: Wire = Wire(input: parseInput())
let wire2: Wire = Wire(input: parseInput())

let wiring1 = wire1.wire();
let wiring2 = wire2.wire();

var wiringLength = findFirstIntersectionWireLength(wiring1: wiring1, wiring2: wiring2)

print(wiringLength)