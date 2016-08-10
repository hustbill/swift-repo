// nested functions

func returnFifteen() -> Int {
	var y = 10
	func add() {
		y += 5
	}
	
	add()
	return y
}

print(returnFifteen())


//  A function can return anonther function as its value
func makeIncrementer() -> ((Int) -> Int) {
	func addOne(number: Int) -> Int {
		return 1 + number
	}
	return addOne
}

var increment = makeIncrementer()
print(increment(7))


// A function can take another function as one of its arguments
func hasAnyMatches(list :[Int], condition: (Int) -> Bool) -> Bool {
	for item in list {
		if condition(item) {
			return true
		}
	}
	return false
}

func lessThanTen(number: Int) -> Bool {
	return number < 10
}

var numbers = [20, 19, 7, 12]

print(hasAnyMatches(numbers, condition: lessThanTen))

// numbers.map({
// 	(number : Int) -> Int in
// 	let result = 3 * number
// 	print(result)
// 	return result
// })
// writing closures more concisely
let mappedNumbers = numbers.map({ number in 3 * number})
print(mappedNumbers)

