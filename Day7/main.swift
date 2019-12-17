
class Amplifier {

	var computer: IntCode;

	var halted: Bool {
		return computer.halted
	}

	init(computer: IntCode) {
		self.computer = computer
	}

	func amplify(signal: Int) -> Int {
		return computer.run(inputSignal: signal)
	}

}


class AmplifiersController {

	let program: [Int]
	let amplifiers: [Amplifier]

	var halted: Bool {
		return amplifiers[0].halted && amplifiers[1].halted && amplifiers[2].halted && amplifiers[3].halted && amplifiers[4].halted 
	}

	init(program: [Int], phases: [Int]){
		self.program = program
		self.amplifiers = [
			Amplifier(computer: IntCode(phase: phases[0], program: program)),
			Amplifier(computer: IntCode(phase: phases[1], program: program)),
			Amplifier(computer: IntCode(phase: phases[2], program: program)),
			Amplifier(computer: IntCode(phase: phases[3], program: program)),
			Amplifier(computer: IntCode(phase: phases[4], program: program)),
		]
	}

	func amplify(inputSignal: Int) -> Int {
		
		var nrOfLoops = 0
		var signal = inputSignal

		while !halted {
			for i in 0...(amplifiers.count - 1) {
				signal = amplifiers[i].amplify(signal: signal)
			}

			nrOfLoops += 1

		} 

		return signal
	}

}

let program: [Int] = (readLine() ?? "").split(separator: ",").map{Int(String($0))!}


var highestOutput = 0
var highestPhase: [Int] = []
var firstPhase: [Int] = [6,8,7,9,5]
var currentPhase: [Int] = firstPhase
var i: Int = 0
var loops: Int = 0
var loopindex: Int = 0

func permutations(_ n:Int, _ a: inout Array<Int>) -> [[Int]] {
    
	if n == 1 { return [a]}

	var arr: [[Int]] = []

    for i in 0..<n-1 {
        arr += permutations(n-1,&a)
        a.swapAt(n-1, (n%2 == 1) ? 0 : i)
    }
    return arr + permutations(n-1,&a)
}

var perm = [5,6,7,8,9]
let phases = permutations(5, &perm)

for phase in phases {

	let amplifiersController: AmplifiersController = AmplifiersController(program: program, phases: phase)

	let output = amplifiersController.amplify(inputSignal: 0)

	if(output > highestOutput){
		highestOutput = output
		highestPhase = phase
	}
} 

print(highestOutput, " at ", highestPhase, " on loop ", loopindex, " after loops ", loops)

