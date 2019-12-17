
struct IntCode {
	
	var paramModes: [Int] = [0,0,0,0]
	var index: Int = 0
	var program: [Int] = []
	var input: [Int] = []
	var isReset: Bool = true
	var halted: Bool = false
	var phase: Int

	init(phase: Int, program: [Int]) {
		self.phase = phase
		self.program = program
		input.append(phase)
	}
	
	var firstParam: Int {
		get { getParam(param: 1) }
		set (value) { setParam(param: 1, value: value) }
	}

	var secondParam: Int {
		get { getParam(param: 2) }
		set (value){ setParam(param: 2, value: value) }
	}

	var thirdParam: Int {
		get { getParam(param: 3) }
		set (value){ setParam(param: 3, value: value) }
	}

	mutating func processOpCode(opCode: Int) -> Int {
		paramModes[1] = opCode / 100 % 10
		paramModes[2] = opCode / 1000 % 10
		paramModes[3] = opCode / 10000 % 10
		return opCode % 100
	}

	mutating func run(inputSignal: Int) -> Int {

		if (halted) { return inputSignal }
		
		input.append(inputSignal)

		while index < program.count {
			//print("OPCODE: \(program[index]) for code: \(program)")
			switch processOpCode(opCode: program[index]) {
			case 1:
				thirdParam = firstParam + secondParam
				index += 4
			case 2:
				thirdParam = firstParam * secondParam
				index += 4
			case 3:
				firstParam = self.input.removeFirst()
				index += 2
			case 4:
				let output = firstParam
				index += 2
				return output
			case 5:
				if(firstParam != 0){
					index = secondParam
				} else {
					index += 3
				}
			case 6:
				if(firstParam == 0){
					index = secondParam
				} else {
					index += 3
				}
			case 7:
				if(firstParam < secondParam){
					thirdParam = 1
				} else {
					thirdParam = 0
				}
				index += 4
			case 8:
				if(firstParam == secondParam){
					thirdParam = 1
				} else {
					thirdParam = 0
				}
				index += 4
			case 99:
				halted = true
				//print("HALTED")
				return inputSignal
			default:
				print("ERROR", index)
				index += 4
			}
				
		}
		halted = true
		print("ERROR")
		return -1
	}

	mutating func reset() -> Void {
		paramModes = [0, 0, 0, 0]
		index = 0
		program = []
		input = []
		isReset = true
	}

	func getParam(param: Int) -> Int {
		switch paramModes[param] {
		case 0:
			return program[program[index + param]]
		case 1:
			return program[index + param]
		default:
			print("ERROR")
			return 0
		}
	}

	mutating func setParam(param: Int, value: Int) -> Void {
		switch paramModes[param] {
		case 0:
			program[program[index + param]] = value
		case 1:
			program[index + param] = value
		default:
			print("ERROR")
		}
	}

}



