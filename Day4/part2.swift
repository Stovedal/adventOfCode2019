

func isIncreasing(array: [Int]) -> Bool {
	if(array.count == 2){
		return array[0] <= array[1]
	} else {
		return (array[0] <= array[1] && isIncreasing(array: array.suffix(array.count - 1)));
	}
}

func hasConsecutiveNumbers(array: [Int]) -> Bool {
	if(array.count == 3){
		return (array[0] != array[1] && array[1] == array[2])
	}
	return (array[0] != array[1] && array[1] == array[2] && array[2] != array[3]) || hasConsecutiveNumbers(array: array.suffix(array.count - 1))
}


func meetsCriteria (password: Int) -> Bool {
	let passwordArray: [Int] = String(password).map {String($0)}.map {Int($0)!}
	return isIncreasing(array: passwordArray) && (((passwordArray[0] == passwordArray[1]) && (passwordArray[1] != passwordArray[2])) || hasConsecutiveNumbers(array: passwordArray))
}

var start : Int = 206938
let end : Int = 679128

var i : Int = start
var count: Int = 0
while i <= end {
	if(meetsCriteria(password: i)){
		print(i)
		count += 1
	}
	i += 1
}

print(count)
