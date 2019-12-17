let program: [Int] = (readLine() ?? "").split(separator: ",").map{Int(String($0))!}
var computor = IntCode(program: program)

print(computor.run(inputSignal:2))