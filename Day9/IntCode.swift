
class IntCode {
	
	var paramModes: [Int] = [0,0,0,0]
	var index: Int = 0
	var program: [Int] = []
	var input: [Int] = []
	var isReset: Bool = true
	var halted: Bool = false
	var relativeBase: Int = 0
	
	init(phase: Int? = nil, program: [Int]) {
		self.program = program
		if(phase != nil){
			input.append(phase ?? 0)
		}
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

	func processOpCode(opCode: Int) -> Int {
		paramModes[1] = opCode / 100 % 10
		paramModes[2] = opCode / 1000 % 10
		paramModes[3] = opCode / 10000 % 10
		return opCode % 100
	}

	func run(inputSignal: Int) -> Int {
		if (halted) { return inputSignal }
		
		input.append(inputSignal)

		while !halted {
			switch processOpCode(opCode: getProgramValue(at: index)) {
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
			case 9:
				relativeBase += firstParam
				index += 2
			case 99:
				halted = true
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

	func reset() -> Void {
		paramModes = [0, 0, 0, 0]
		index = 0
		program = []
		input = []
		isReset = true
	}

	func getParam(param: Int) -> Int {
		switch paramModes[param] {
		case 0:
			return getProgramValue(at: getProgramValue(at: index + param))
		case 1:
			return getProgramValue(at: index + param)
		case 2:
			return getProgramValue(at: getProgramValue(at: index + param) + relativeBase)
		default:
			print("PARAM MODE ERROR: ", paramModes[param])
			return 0
		}
	}

	func setParam(param: Int, value: Int) -> Void {
		switch paramModes[param] {
		case 0:
			setProgramValue(at: getProgramValue(at: index + param), value: value)
		case 1:
			setProgramValue(at: index + param, value: value)
		case 2:
			setProgramValue(at: getProgramValue(at: index + param) + relativeBase, value: value)
		default:
			print("PARAM MODE ERROR: ", paramModes[param])
		}
	}

	func getProgramValue(at: Int) -> Int {
		checkIndex(i: at)
		return program[at]
	}

	func setProgramValue(at: Int, value: Int) -> Void {
		checkIndex(i: at)
		program[at] = value
	}

	func checkIndex(i: Int) -> Void {
		if i < 0 {
			print("ERROR negative index: ", i)
		}
		while i > (program.count - 1) {
			program.append(0)
		}
	}


}



