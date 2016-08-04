// Second.swift
// Functions and Closures
/*
Use func to declare a function. Call a function by following its name with a list of arguments in parentheses. Use -> to separate the parameter names and types from the function’s return type.
*/

func greet(name: String, day: String) -> String {
	return "Hello \(name), today is \(day)."
}
var greeting = greet("Bob", day:"Tuesday")
print(greeting)



func greetLunchSpecial(name: String, day: String, lunchSpecial: String) -> String {
	return "Hello \(name), today is \(day), lunch special is \(lunchSpecial)."
}
var greetingSpecial = greetLunchSpecial("Bob", day:"Tuesday", lunchSpecial:"tomato soup")
print(greetingSpecial)


// Use a tuple to make a compound value - for example, to return multiple values from a function. 
// The elements of a tuple can be referred to either by name or by number

func calculateStatistics(scores:[Int]) -> (min :Int, max:Int, sum:Int) {
	var min = scores[0]
	var max = scores[0]
	var sum = 0
	
	for score in scores {
		if score > max {
			max = score
		} else if score < min {
			min = score
		}
		sum += score
	}
	return (min, max, sum)
}

let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.min, statistics.max, statistics.sum)
print(statistics.2)
