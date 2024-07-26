//
//  FirstPage.swift
//  Challenge3EdutainmentApp
//
//  Created by Aryan Panwar on 08/06/24.
//

import SwiftUI

struct FirstPage: View {
    @State private var choosenCharacter : String = ""
    @State private var isNavigationActive  = false
    @State private var noOfQuestions : Int = 10
    @State var name : String = ""
    @State private var difficulty = "Easy"
    @State private var gradeClass = 1
    let difficultyChoices = ["Easy" , "Medium" , "Hard"]
    let classes = [1 , 2, 3, 4, 5 , 6, 7, 8]
    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 53/255, green: 114/255 , blue: 123/255)
                    .ignoresSafeArea()
                VStack{
                    Text("MathMate AI")
                        .font(.largeTitle.bold())
                        .frame(alignment: .top)
                    Section ("Select total questions"){
                        Stepper("Total questions : \(noOfQuestions)", value: $noOfQuestions , in : 5...20)
                            .font(.title3)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 20), style: FillStyle())
                        
                    }
                    .padding()
                    .font(.title3)
                    Text("Select Difficulty Level")
                    Picker("Select difficulty", selection: $difficulty, content: {
                        ForEach(difficultyChoices , id : \.self){
                            Text($0)
                                .foregroundStyle(.white)
                        }
                    })
                    .pickerStyle(.palette )
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10), style: FillStyle())

                    //                .offset(y : -80)
                    
                    Text("Select Class Level")
                    Picker("Select class", selection: $gradeClass , content: {
                        ForEach(classes , id : \.self){
                            Text("\($0)")
                                .foregroundStyle(.white)
                        }
                    })
                    .pickerStyle(.palette )
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10), style: FillStyle())

                    //                .offset(y : -80)
                    
                    Text("Choose a character")
                        .padding()
                    HStack {
                        VStack {
                            Text("Dev")
                                .offset(y:50)
                                .font(.title.bold().monospaced())
                                .foregroundStyle(.yellow)
                            Image("character_maleAdventurer_wide")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .shadow(color : .white , radius: 5)
                                .shadow(color : .white , radius: 5)
                        }
                        .background(.mint)
                        .clipShape(.rect(cornerRadius: 20))
                        .onTapGesture {
                            choosenCharacter = "character_maleAdventurer_"
                            isNavigationActive = true
                        }
                        .shadow(color : .white , radius: 5)
                        .shadow(color : .white , radius: 5)
                        
                        
                        VStack {
                            Text("Devi")
                                .offset(y:50)
                                .font(.title.bold().monospaced())
                                .foregroundStyle(.yellow)
                            Image("character_femalePerson_wide")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .shadow(color : .white , radius: 5)
                                .shadow(color : .white , radius: 5)
                        }
                        .background(.mint)
                        .clipShape(.rect(cornerRadius: 20))
                        .onTapGesture {
                            choosenCharacter = "character_femalePerson_"
                            isNavigationActive = true
                        }
                        .shadow(color : .white , radius: 5)
                        .shadow(color : .white , radius: 5)
                        
                    }
                    .navigationDestination(isPresented: $isNavigationActive){
                        SecondPage(numberOfQuestions: $noOfQuestions, character: $choosenCharacter , difficulty: $difficulty , standard: $gradeClass)
                    }
                }
                .padding()
            }
            .foregroundStyle(.white)
            
                
        }
    }
}

#Preview {
    FirstPage()
}
