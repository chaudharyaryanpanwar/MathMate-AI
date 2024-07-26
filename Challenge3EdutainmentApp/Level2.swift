//
//  Level2.swift
//  Challenge3EdutainmentApp
//
//  Created by Aryan Panwar on 08/06/24.
//

import SwiftUI

struct Level2: View {
    @Binding var numberOfQuestions : Int
    @Binding var name : String
    @Binding var character : String
    @State private var score : Int = 0
    @State private var totalQuestions : Int = 0
    @State private var answer : Int?
    @FocusState private var isAnswerFocused : Bool
    
    

    var body: some View {
        NavigationStack{
            ZStack {
                Color(red: 53/255, green: 114/255 , blue: 123/255)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        
                        Text("Score : \(score) / \(totalQuestions)")
                            .font(.title.bold().monospacedDigit())
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 30))
                    
                    VStack {
                        Text(" 2 x 3 = __?")
                            .font(.title.bold())
                            .padding()
                            .background(.gray)
                            .font(.title)
                            .clipShape(.rect(cornerRadius: 20))
                            .foregroundStyle(.white)
                            .frame(alignment: .trailing)
                            .onTapGesture {
                                print(numberOfQuestions)
                            }
                        Image("\(character)think")
                            .frame(alignment: .leading)
                            .offset(y:-80)
                    }
                    TextField("  Enter answer", value : $answer , format: .number)
                        .keyboardType(.numberPad)
                        .focused($isAnswerFocused)
                        .padding()
                        .foregroundStyle(.white)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 20), style: FillStyle())
                        .padding()
                        .font(.title)
                        .offset(y : -70)
                    Button("Answer"){
                        isAnswerFocused.toggle()
                    }
                    .padding()
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    .offset(y:-80)
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    if isAnswerFocused {
                        Button("Done"){
                            isAnswerFocused = false
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    Level2(numberOfQuestions: .constant(10), name: .constant("Aryan"), character: .constant("character_maleAdventurer_"))
}
