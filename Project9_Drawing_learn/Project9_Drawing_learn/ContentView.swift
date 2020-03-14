//
//  ContentView.swift
//  Project9_Drawing_learn
//
//  Created by Ильдар Нигметзянов on 11.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Array: InsettableShape {
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        return self
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 50, y: 0))
        
        path.addLine(to: CGPoint(x: 0, y: 50))
        path.addLine(to: CGPoint(x: 30, y: 50))
        path.addLine(to: CGPoint(x: 30, y: 100))
        path.addLine(to: CGPoint(x: 70, y: 100))
        path.addLine(to: CGPoint(x: 70, y: 50))
        path.addLine(to: CGPoint(x: 100, y: 50))
        path.addLine(to: CGPoint(x: 50, y: 0))
        
        return path
    }
}

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from:0,to: CGFloat.pi * 2, by: CGFloat.pi / 8){
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX:rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x:CGFloat(petalOffset),y:0,width:CGFloat(petalWidth),height: rect.width / 2))
            
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount: CGFloat = 0
    
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x:rect.midX,y:rect.midY),radius: rect.width / 2 - insetAmount,startAngle: modifiedStart,endAngle:  modifiedEnd,clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape{
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Trapezoid: Shape {
    
    var animatableData: CGFloat{
        get {insetAmount}
        set {self.insetAmount = newValue}
    }
    
    var insetAmount: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
    
        path.move(to: CGPoint(x:0,y:rect.maxY))
        path.addLine(to:CGPoint(x:insetAmount,y:rect.minY))
        path.addLine(to: CGPoint(x:rect.maxX - insetAmount,y:rect.minY))
        path.addLine(to: CGPoint(x:rect.maxX,y:rect.maxY))
        path.addLine(to:CGPoint(x:0,y:rect.maxY))
        
        return path
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    public var animatableData: AnimatablePair<Double,Double>{
        get {
            AnimatablePair(Double(rows),Double(columns))
        }
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2){
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY,width: columnSize,height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: CGFloat
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius,outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from:0,through: endPoint,by : 0.01){
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x:x,y:y))
            }
        }
        
        return path
    }
    
}

struct ContentView: View {
    
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var amount1: Double = 0.0
    @State private var amount2: Double = 0.0
    @State private var amount3: Double = 0.0
    @State private var insetAmount: CGFloat = 50
    
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 125.0
    //@State private var amount : CGFloat = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        
        //Array()
            //.strokeBorder(10)
            //.frame(width:100,height:100)
        
//            //.animation(rotationEffect(10.))
//            .offset(x:0,y:400)
    
//        Path { path in
//            path.move(to:CGPoint(x:200,y:100))
//            path.addLine(to: CGPoint(x:100,y: 300))
//            path.addLine(to: CGPoint(x:300,y:300))
//            path.addLine(to: CGPoint(x:200,y:100))
//            //path.addLine(to:CGPoint(x:100,y:300))
//
//        }
//        .fill(Color.blue)
//            .stroke(Color.blue,lineWidth: 10)
//            .stroke(Color.blue,style:StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//        Triangle()
//            .fill(Color.red)
//            .frame(width:300,height: 300)
        
//        Arc(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
//            .stroke(Color.blue,lineWidth: 10)
//            .frame(width:300,height: 300)
//        Circle()
//        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
//            .strokeBorder(Color.blue,lineWidth: 9)

//        VStack {
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                //.stroke(Color.red,lineWidth: 1)
//                .fill(Color.red,style:FillStyle(eoFill:true))
//
//            Text("Offset")
//            Slider(value: $petalOffset,in: -40...40)
//                .padding([.horizontal,.bottom])
//
//            Text("Width")
//            Slider(value: $petalWidth,in: 0...100)
//                .padding(.horizontal)
//        }
        
//        Rectangle()
//            .strokeBorder(ImagePaint(image:Image("Example"),scale:0.6),lineWidth: 50)
            //.frame(width:400,height:400)
        
//        ZStack{
//            Image("Example")
//                .colorMultiply(.red)
//
//            Rectangle()
//                .fill(Color.red)
//                .blendMode(.multiply)
//        }
//        .frame(width:400,height:500)
//        .clipped()
        
//        VStack{
//            ZStack{
//                Circle()
//                    .fill(Color(red:1,green:0,blue:0))
//                    .frame(width:200*amount)
//                    .offset(x:-50,y:-80)
//                    .blendMode(.screen)
//                Circle()
//                    .fill(Color(red:0,green:1,blue:0))
//                    .frame(width:200*amount)
//                    .offset(x:50,y:-80)
//                    .blendMode(.screen)
//                Circle()
//                    .fill(Color(red:0,green:0,blue:1))
//                    .frame(width:200*amount)
//                    .blendMode(.screen)
//            }
//            .frame(width:300,height:300)
//            
//            Slider(value:$amount)
//                .padding()
//        }
//        .frame(maxWidth:.infinity,maxHeight: .infinity)
//        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)

                VStack{
                    ZStack{
                        Circle()
                            .fill(Color(red:amount1,green:amount2,blue:amount3))
                            //.frame(width:200)
                            //.offset(x:-50,y:-80)
                            .blendMode(.screen)
                       
                    }
                    //.frame(width:300,height:300)
        
                    Slider(value:$amount1,in: 0...1)
                        .padding()
                    Slider(value:$amount2,in: 0...1)
                    .padding()
                    Slider(value:$amount3,in: 0...1)
                    .padding()
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color.black)
               
        
        
//       Trapezoid(insetAmount: insetAmount)
//        .frame(width: 200, height:100)
//        .onTapGesture {
//            withAnimation{
//                self.insetAmount = CGFloat.random(in: 10...90)
//            }
//        }
        
//        Checkerboard(rows: rows,columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration:3)){
//                    self.rows = 8
//                    self.columns = 16
//                }
//        }
        
//        VStack(spacing: 0){
//            Spacer()
//
//            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
//                           .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
//                           .frame(width: 300, height: 300)
//        Spacer()
//
//        Group {
//            Text("Inner radius: \(Int(innerRadius))")
//            Slider(value: $innerRadius, in: 10...150, step: 1)
//                .padding([.horizontal, .bottom])
//
//            Text("Outer radius: \(Int(outerRadius))")
//            Slider(value: $outerRadius, in: 10...150, step: 1)
//                .padding([.horizontal, .bottom])
//
//            Text("Distance: \(Int(distance))")
//            Slider(value: $distance, in: 1...150, step: 1)
//                .padding([.horizontal, .bottom])
//
//            Text("Amount: \(amount, specifier: "%.2f")")
//            Slider(value: $amount)
//                .padding([.horizontal, .bottom])
//
//            Text("Color")
//            Slider(value: $hue)
//                .padding(.horizontal)
//        }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
