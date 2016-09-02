import Foundation

var str = "hello, world"
var byteArray = [UInt8]()
for char in str.utf8{
    byteArray += [char]
}
print(byteArray)

let fileName = "CAL1.TXT"
var txBuffer:[UInt8] = [0x09, 0x70]
  let buf = [UInt8](fileName.utf8)     // send file name
  txBuffer += buf
  let data = NSData(bytes: txBuffer, length: txBuffer.count)
  print("\(data)")