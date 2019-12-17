
struct IntCode {
	
	var noun: Int
	var verb: Int
	var paramModes: [Int] = [0,0,0,0]
	var index: Int = 0
	var code: [Int] = []


	var opCode: Int {
		get { return code[index] }
		set (value) { code[index] = value }
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

	init(noun: Int, verb: Int){
		self.noun = noun
		self.verb = verb
	}

	mutating func processOpCode(code: Int) -> Int {
		paramModes[1] = code / 100 % 10
		paramModes[2] = code / 1000 % 10
		paramModes[3] = code / 10000 % 10
		//print("PARAM MODES:", paramModes)
		return code % 100
	}

	mutating func compute(input: [Int], inputParam: Int) -> Int {
		print("COMPUTING")
		code = input
		index = 0
		
		while index < code.count {
			//print("OPCODE: ", processOpCode(code: code[index]), " CODE: ", code)
			switch processOpCode(code: code[index]) {
			case 1:
				thirdParam = firstParam + secondParam
				index += 4
			case 2:
				thirdParam = firstParam * secondParam
				index += 4
			case 3:
				firstParam = inputParam
				index += 2
			case 4:
				print("OUTPUT: ", firstParam)
				index += 2
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
				print("HALTING")
				return code.first!
			default:
				print("ERROR", index)
				index += 4
			}
				
		}
		return code.first!
	}


	func getParam(param: Int) -> Int {
		switch paramModes[param] {
		case 0:
			return code[code[index + param]]
		case 1:
			return code[index + param]
		default:
			print("ERROR")
			return 0
		}
	}

	mutating func setParam(param: Int, value: Int) -> Void {
		switch paramModes[param] {
		case 0:
			code[code[index + param]] = value
		case 1:
			code[index + param] = value
		default:
			print("ERROR")
		}
	}

}



