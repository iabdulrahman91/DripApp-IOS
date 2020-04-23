//
//  ContentView.swift
//  DripApp
//
//  Created by abdulrahman alanazi on 4/22/20.
//  Copyright © 2020 abdulrahman alanazi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var ratio: Float = 15.0
    @State var water: Float = 150.0
    @State var coffee: Float = 10.0
    @State var roast: Float = 2
    @State var seconds: Int = 0
    @State var isPaused:Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common)

    @State var coffeeLast:Bool=false
    
    var body: some View {
        ZStack {
            Color(.systemGray6).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                
                HStack(alignment: .center){
                    //30475e
                    Image("coffee_pot3").resizable().frame(width: 75, height: 75).brightness(0.1)
                    
                    
                    VStack (alignment: .leading){
                        Text("DripApp").font(.title).fontWeight(.light).foregroundColor(.white)
                        
                        Text("Make Better Coffee").font(.headline).fontWeight(.thin).foregroundColor(.white)
                        
                    }.colorMultiply(Color(red: 48/255, green: 71/255, blue: 94/255))
                    
                }.padding(.top)
                
                
                VStack(alignment: .trailing,spacing: 30){
                    VStack(alignment: .leading) {
                        HStack {
                            Image("water").resizable().frame(width: 40, height: 40, alignment: .center)
                            Text("\(Int(self.water).description) ml")
                        }
                        Slider(value: self.$water, in: 5...2500, step: 10.0, onEditingChanged: { _ in
                            self.coffeeLast = false
                            self.coffee = self.water / self.ratio
                        })
                    }
                    
                    VStack(alignment: .leading)  {
                        Stepper("Ratio 1:\(Int(self.ratio).description)", value: self.$ratio, in: 5...25, step: 1.0, onEditingChanged: { _ in
                            if self.coffeeLast{
                                self.water = self.coffee*self.ratio
                            } else {
                                self.coffee = self.water / self.ratio
                            }
                        }).font(.title)
                        Text("One gram of coffee make \(Int(self.ratio).description) ml of coffee").font(.caption).fontWeight(.thin)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image("coffee_beans").resizable().frame(width: 40, height: 40, alignment: .center)
                            Text("\(Int(self.coffee).description) gram")
                        }
                        Slider(value: self.$coffee, in: 1...100, step: 1.0, onEditingChanged: { _ in
                            self.coffeeLast = true
                            self.water = self.coffee*self.ratio
                        })
                    }
                    HStack {
                        Image("roast_dark").resizable().frame(width: 30, height: 30, alignment: .center).brightness((Double(self.ratio)/150))
                        Spacer()
                        Button(action: {
                            self.ratio = 15
                            self.water = 150
                            self.coffee = 10
                        }){
                            Text("Reset").fontWeight(.semibold).padding(.horizontal)
                        }
                    }
                }.padding().background(Color(.systemGray5)).cornerRadius(15).shadow(radius: 2).padding()
               
            
                   
                
               
                
                VStack(alignment: .center){
                
                 VStack(alignment: .leading) {
                     HStack{
                         Text("Roast").font(.headline)
                     }
                     HStack {
                         Image("coffee_beans").resizable().frame(width: 40, height: 40, alignment: .center).colorMultiply(.yellow).saturation(0.5).brightness(-0.15)
                         Spacer()
                         Slider(value: self.$roast, in: 1...4, step: 1.0)
                         Spacer()
                         Image("coffee_beans").resizable().frame(width: 40, height: 40, alignment: .center).colorMultiply(.yellow).saturation(0.4).brightness(-0.25)
                     }
                     
                     
                 }
                 Text("About \((self.roast * -2 + 96).description) °C").font(.title).fontWeight(.thin).padding()
                 }.padding().background(Color(.systemGray5)).cornerRadius(15).shadow(radius: 2).padding()
                
                VStack(alignment: .leading) {
                                   
                                   Text("Timer").font(.headline)
                                   
                                   Text("\(self.seconds) Second").font(.title).fontWeight(.thin).padding().onReceive(timer){ _ in
                                       if !self.isPaused{self.seconds += 1}
                                   }
                                   HStack {
                                       Button(action: {
                                           self.isPaused = false
                                           _ = self.timer.connect()
                                           
                                       }){
                                           Text("Start")
                                               .fontWeight(.semibold)
                                       }
                                       Spacer()
                                       Button(action: {
                                           self.isPaused = true
                                       }){
                                           Text("Puase")
                                               .fontWeight(.semibold)
                                       }
                                       Spacer()
                                       Button(action: {
                                           self.seconds = 0
                                       }){
                                           Text("Reset")
                                               .fontWeight(.semibold)
                                       }
                                   }
                                   
                                   
                                   
                                   
                               }.padding().background(Color(.systemGray5)).cornerRadius(15).shadow(radius: 2).padding()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.colorScheme, .light)
            ContentView().environment(\.colorScheme, .dark)
        }

    }
}
