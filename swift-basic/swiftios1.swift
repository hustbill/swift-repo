//3 变量和常量
// 元组
let stu:(id:Int,name:String,gender:Bool,age:Int) = (1001,"王大锤",true,23)
//输出方法1
print(stu.0)
print(stu.1)
print(stu.2)
print(stu.3)
//输出方法2
print(stu.age)
print(stu.gender)
print(stu.id)
print(stu.name)


// tips：元组可以很方便的交换2个数的大小
var xx = 10, yy = 11
// 交换
(xx, yy) = (yy, xx)
// 输出
print("xx=\(xx), yy=\(yy)")
print()


// 4 运算符
var  a = 100
let b = 50
var c = a + b
//输出时在双引号内使用\()是转义字符，可以直接输出括号内部值
print("\(c)")
//不加双引号直接输出值
print(a-b)
print(a*b)
//整数除以整数结果也是整数（不会出现小数部分）a/b表示a除以b取整数（不会四舍五入，直接切掉小数部分），而a%b表示a除以b取余数
print(a/b)
//12.0 swift 自动推断出为double
//手动定义x，y为常量,类型为Double,值为321和123，输出以小数的形式输出
let x: Double = 321
let y: Double = 123
print(x/y)
//进行数学运算时左右两边必须类型相同
print(x/Double(b))
//Int取整数时不会四舍五入


//定义一个常量str
let str = "有兽焉"
//定义TEMP获得str中的文字序号
for temp  in str.utf16{
//打印temp
    print(temp)
}