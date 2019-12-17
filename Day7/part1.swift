
class Amplifier {

	var computer: IntCode;
	var isReset: Bool = true

	init(computer: IntCode) {
		self.computer = computer
	}

	func amplify(program: [Int], input: Int, phaseSetting: Int) -> Int {
		isReset = false;
		return computer.run(program: program, input: [phaseSetting, input])
	}

	func reset(){
		computer.reset()
		isReset = true
	}

}

let program: [Int] = (readLine() ?? "").split(separator: ",").map{Int(String($0))!}

let amplifiers = [
	Amplifier(computer: IntCode()),
	Amplifier(computer: IntCode()),
	Amplifier(computer: IntCode()),
	Amplifier(computer: IntCode()),
	Amplifier(computer: IntCode()),
]

func amplify(phaseSettings: [Int]) -> Int {
	var memory = 0;
	for i in 0...4 {
		if(!amplifiers[i].isReset){
			amplifiers[i].reset()
		}
		memory = amplifiers[i].amplify(program: program, input: memory, phaseSetting: phaseSettings[i] )
	}
	return memory
}

var highestOutput = 0
var highestPhase: [Int] = []
var firstPhase: [Int] = [0,1,2,3,4]
var currentPhase: [Int] = firstPhase
var i: Int = 0
repeat {
	let temp = currentPhase[i]
	currentPhase[i] = currentPhase[i+1]
	currentPhase[i+1] = temp
	i += 1
	if(i > 3){
		i = 0
	}
	let output = amplify(phaseSettings: currentPhase)
	if(output > highestOutput){
		highestOutput = output
		highestPhase = currentPhase
	}

} while firstPhase != currentPhase

print(highestOutput, " at ", highestPhase)
