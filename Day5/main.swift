

var input: [Int] = String(readLine() ?? "cat").split(separator: ",").map {String($0)}.map{Int($0)!}

var intCode = IntCode(noun: 12, verb: 2)

print(intCode.compute(input:input, inputParam: 5))
