//
//  ContentView.swift
//  Calculator
//
//  Created by Maria Theussl on 25.07.23.
//

import SwiftUI

struct FunctionButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80)
            .frame(height: 80)
            .clipShape(Capsule())
            .controlSize(.large)
            .buttonStyle(.bordered)
            .background(.blue)
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct NumberButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80)
            .frame(height: 80)
            .clipShape(Capsule())
            .controlSize(.large)
            .buttonStyle(.bordered)
            .background(.gray)
            .foregroundStyle(.black)
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView: View {
    @State var number = 0
    @State var number_string = "0"
    @State var zahl = 0
    @State var counter = 1
    @State var res = 0
    @State var op = ""
    @State var zahlen: [Int] = []
    @State var ops: [String] = []
    @State var op_len = 0
    @State var zahlen_len = 0
    @State var calculationActive = false
    @State var calculated = false
    
    func numberButtonAction(num: Int)
    {
        if (Int(number_string)! == 0)
        {
            number = num
            number_string = String(num)
        }
        else if (number_string.contains("%"))
        {
            number = num
            number_string = String(num)
        }
        else if (calculationActive == true)
        {
            number = num
            number_string = String(num)
        }
        else {
            number_string = String(number) + String(num)
            number = Int(number_string)!
        }
        calculationActive = false
        calculated = false
    }
    
    func functionButtonAction(op2: String)
    {
        if (counter == 1) {
            zahl = number
            op = op2
            zahlen.append(zahl)
            ops.append(op)
            counter += 1
        }
        else {
            zahl = number
            op = op2
            zahlen.append(zahl)
            ops.append(op)
            counter += 1
            
            
            switch ops[counter-3]
            {
            case "+":
                number = zahlen[counter-3] + zahlen[counter-2]
                number_string = String(number)
                zahlen[counter-2] = number
            case "-":
                number = zahlen[counter-3] - zahlen[counter-2]
                number_string = String(number)
                zahlen[counter-2] = number
            case "*":
                number = zahlen[counter-3] * zahlen[counter-2]
                number_string = String(number)
                zahlen[counter-2] = number
            case ":":
                if (zahlen[counter-2] == 0)
                {
                    number_string = "DIV0!"
                }
                else
                {
                    number = zahlen[counter-3] / zahlen[counter-2]
                    number_string = String(number)
                    zahlen[counter-2] = number
                }
                
            default:
                zahl = 0
            }
        }
        calculationActive = true
        calculated = false
    }
        
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                Text(number_string)
                Spacer()
                HStack {
                    Spacer()
                    Button("AC") {
                        number_string = "0"
                        number = 0
                        counter = 1
                        zahlen = []
                        ops = []
                    }
                    .buttonStyle(FunctionButton())
                    Spacer()
                    Button("+/-") {
                        if (number_string.contains("%"))
                        {
                            number_string = "0"
                            number = 0
                            counter = 1
                            zahlen = []
                            ops = []
                        }
                        else
                        {
                            number = Int(number_string)! * (-1)
                            number_string = String(number)
                        }
                        
                    }.buttonStyle(FunctionButton())
                    Spacer()
                    Button("%") {
                        number_string = String(number * 100) + "%"
                    }.buttonStyle(FunctionButton())
                    Spacer()
                    Button(":") {
                        functionButtonAction(op2: ":")
                    }.buttonStyle(FunctionButton())
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button("7") {
                        numberButtonAction(num: 7)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("8") {
                        numberButtonAction(num: 8)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("9") {
                        numberButtonAction(num: 9)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("x") {
                        functionButtonAction(op2: "*")
                    }.buttonStyle(FunctionButton())
                    Spacer()
                }
                .controlSize(.large)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                HStack {
                    Spacer()
                    Button("4") {
                        numberButtonAction(num: 4)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("5") {
                        numberButtonAction(num: 5)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("6") {
                        numberButtonAction(num: 6)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("-") {
                        functionButtonAction(op2: "-")
                    }.buttonStyle(FunctionButton())
                    Spacer()
                }
                .controlSize(.large)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                HStack {
                    Spacer()
                    Button("1") {
                        numberButtonAction(num: 1)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("2") {
                        numberButtonAction(num: 2)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("3") {
                        numberButtonAction(num: 3)
                    }.buttonStyle(NumberButton())
                    Spacer()
                    Button("+") {
                        functionButtonAction(op2: "+")
                    }.buttonStyle(FunctionButton())
                    Spacer()
                }
                .controlSize(.large)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                HStack {
                    Spacer()
                    Button("0") {
                        numberButtonAction(num: 0)
                    }
                        .frame(width: 160)
                        .buttonStyle(NumberButton())
                    Spacer()
                    Spacer()
                    Button(",") {
                        //action for komma
                    }.buttonStyle(FunctionButton())
                    Spacer()
                    Button("=") {
                        zahl = number
                        zahlen.append(zahl)
                        counter += 1
                        
                        
                        switch ops[counter-3]
                        {
                        case "+":
                            number = zahlen[counter-3] + zahlen[counter-2]
                            number_string = String(number)
                            zahlen[counter-2] = number
                        case "-":
                            number = zahlen[counter-3] - zahlen[counter-2]
                            number_string = String(number)
                            zahlen[counter-2] = number
                        case "*":
                            number = zahlen[counter-3] * zahlen[counter-2]
                            number_string = String(number)
                            zahlen[counter-2] = number
                        case ":":
                            if (zahlen[counter-2] == 0)
                            {
                                number_string = "DIV0!"
                            }
                            else
                            {
                                number = zahlen[counter-3] / zahlen[counter-2]
                                number_string = String(number)
                                zahlen[counter-2] = number
                            }
                            
                        default:
                            zahl = 0
                        }
                    calculationActive = true
                    calculated = true
                    
                    zahlen.removeAll()
                    counter = 2
                    zahlen.append(zahl)
                        
                    }.buttonStyle(FunctionButton())
                    Spacer()
                }
            }
            .padding()
            .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
