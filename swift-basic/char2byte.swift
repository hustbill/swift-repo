import Foundation

// var str = "hello, world"
// var byteArray = [UInt8]()
// for char in str.utf8{
//     byteArray += [char]
// }
// print(byteArray)
//
// let fileName = "CAL1.TXT"
// var txBuffer:[UInt8] = [0x09, 0x70]
//   let buf = [UInt8](fileName.utf8)     // send file name
//   txBuffer += buf
//   let data = NSData(bytes: txBuffer, length: txBuffer.count)
//   print("\(data)")
//
//

// var testBytes : [UInt8] = [0x14, 0x00, 0xAB, 0x45, 0x49, 0x1F, 0xEF, 0x15,
//                           0xA8, 0x89, 0x78, 0x0F, 0x09, 0xA9, 0x07, 0xB0,
//                           0x01, 0x20, 0x01, 0x4E, 0x38, 0x32, 0x35, 0x56,
//                           0x20, 0x20, 0x20, 0x00]
//
// var msgData = NSData(bytes: testBytes, length: testBytes.count)
//
// print("\(msgData)")




var testBytes : [UInt8] = [0x14, 0x00]

var msgData = NSData(bytes: testBytes, length: testBytes.count)

print("\(msgData)")
  
// var arr : [UInt32] = [32,4,123,4,5,2];
//
// let data = NSData(bytes: arr, length: arr.count * sizeof(UInt32))
//
// println(data)  //data looks good in the inspector
//
//   // the number of elements:
//   let count = data.length / sizeof(UInt32)
//
//   // create array of appropriate length:
//   var array = [UInt32](count: count, repeatedValue: 0)
//
//   // copy bytes into array
//   data.getBytes(&array, length:count * sizeof(UInt32))
//
//   print(array)
//   // Output: [32, 4, 123, 4, 5, 2]