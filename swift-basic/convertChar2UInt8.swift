import Foundation

let charArray: [Character] = [ "T"]
let asUInt8Array = String(charArray).utf8.map{ UInt8($0) }

print(asUInt8Array)
/* [84] */

print(asUInt8Array.dynamicType)

var txBuffer = Array(count: 20, repeatedValue: UInt8(0))
let char : Character = "T"
let byte : UInt8 = Array(String(char).utf8)[0]
let fileCounter = 0
txBuffer[fileCounter] = byte
print("byte = \(byte)")
