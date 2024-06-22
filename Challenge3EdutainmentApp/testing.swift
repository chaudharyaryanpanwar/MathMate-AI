//
//  testing.swift
//  Challenge3EdutainmentApp
//
//  Created by Aryan Panwar on 22/06/24.
//

import SwiftUI
import GoogleGenerativeAI


struct testing: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default )
    @State private var userPrompt = ""
    @State private var response = "How can i help you today?"
    @State private var isLoading = false
    @State private var questions : [Question] = [Question]()
    @State private var gradeClass = 6
    @State private var difficulty = "Medium"
    @State private var userInput = "generate 10 questions of class 1 and of difficulty very high  and the answer should be numberic only without any use of any alphabets or special characters like e or variables 'x' or symbols like power or - in it , your output should be completely an json array in which every question is mapped with its numeric answer without any other detail"  
    var body: some View {
        VStack {
            Text("Welcome to Gemini AI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.indigo)
                .padding(.top , 40)
            ZStack {
//                ScrollView {
//                    Text(response)
//                        .font(.title)
//                }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(.indigo)
                        .scaleEffect(4)
                }
            }
            
//            TextField("Ask anything...." , text: $userInput , axis: .vertical)
//                .lineLimit(5)
//                .font(.title)
//                .padding()
//                .background(Color.indigo.opacity(0.2), in: Capsule())
//                .autocorrectionDisabled()
//                .onSubmit {
//                    generateResponse()
//                }
            
            ForEach(questions , id: \.self){ question in
                VStack(alignment: .leading){
                    Text(question.question)
                        .font(.headline)
                    Text("Answer : \(question.answer)")
                        .font(.subheadline)
                }
            }
        }
        .onAppear{
            generateResponse()
        }
        .padding()
    }
    
    func generateResponse() {
        isLoading = true
        response = ""
        
        Task {
            do {
                let result = try await model.generateContent(userInput)
                isLoading = false
                response = result.text ?? "No response found"
                
                loadQuestions()
                userPrompt = ""
            } catch {
                response = "Something went wrong \n \(error.localizedDescription)"
            }
        }
        
    }
    
    func loadQuestions() {
        let uncleanedJsonString = response
        let jsonString = cleanJsonString(uncleanedJsonString)
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Failed to convert JSON string to Data")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            questions = try decoder.decode([Question].self, from: jsonData)
            print("Successfully decoded JSON: \(questions)")
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
            
            // Additional debugging information
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(let type, let context):
                    print("Type mismatch error: \(type), context: \(context)")
                case .valueNotFound(let type, let context):
                    print("Value not found error: \(type), context: \(context)")
                case .keyNotFound(let key, let context):
                    print("Key not found error: \(key), context: \(context)")
                case .dataCorrupted(let context):
                    print("Data corrupted error: \(context) ,data : \(jsonData)")
                @unknown default:
                    print("Unknown decoding error")
                }
            }
        }
    }
    
    func cleanJsonString(_ jsonString: String) -> String {
            // Remove any backticks and unwanted characters
            let cleanedJsonString = jsonString
                .replacingOccurrences(of: "`", with: "")
                .replacingOccurrences(of: "\\", with: "") // Add more replacements as needed
                .replacingOccurrences(of: "json", with: "")
            print("Ceanded JSON String : \(cleanedJsonString)")
        return cleanedJsonString
        }

}



#Preview {
    testing()
}
