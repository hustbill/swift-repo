import Foundation
print("请输入一个年份，例如1982")
let year = 1982 // inputInt()
//&&-短路与运算（而且）
//||-短路或运算（或者）
//四年1闰，百年不闰，四百年又闰
if year % 4 == 0 && year % 100 != 0 || year % 400 == 0 {
    print("\(year)年是闰年")
}
else {
    print("\(year)年不是闰年")
}