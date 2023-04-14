//
//  GameView.swift
//  MathBrainBoosterCopy
//
//  Created by Hugo Peyron on 13/04/2023.
//

import SwiftUI

struct GameView: View {
    
    var tableNumber: Int
    
    @FocusState var isInputFocused: Bool
    
    @State var tableArray = [String]()
    @State var currentTable = ""
    
    @State var lostLifes = 0
    @State var score = 0
    @State var isGameOver = false
    
    @State var userAnswer = ""
    @State var answerState: Bool? = nil
    
    init(tableNumber: Int) {
        self.tableNumber = tableNumber
        self.userAnswer = userAnswer
        fillArrayWithTableNumber()
    }
    
    
    func fillArrayWithTableNumber() {
        for number in (1..<11) {
            tableArray.append("\(tableNumber) x \(number)")
        }
    }
    
    func selectRandomElement(array: [String]) {
        currentTable = array.randomElement() ?? "No element to display"
    }
    
    func calculateResult(from question: String) -> Int {
        let components = question.components(separatedBy: " x ")
        if let firstNumber = Int(components[0]), let secondNumber = Int(components[1]) {
            return firstNumber * secondNumber
        }
        return 0
    }
    
    func checkAnswer() {
        let correctAnswer = calculateResult(from: currentTable)
        
        if let answer = Int(userAnswer) {
            if answer == correctAnswer {
                answerState = true
                score += 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    nextQuestion()
                }
                
            } else if userAnswer.count >= String(correctAnswer).count {
                answerState = false
                lostLifes += 1
                
                if lostLifes == 5 {
                    isGameOver = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    userAnswer = ""
                }
            }
        } else {
            answerState = nil }
    }
    
    func reset() {
        nextQuestion()
        score = 0
    }
    
    
    func nextQuestion() {
        userAnswer = ""
        answerState = nil
        selectRandomElement(array: tableArray)
    }
    
    var body: some View {
        
        VStack {
            
            Lifes(lostlifes: $lostLifes)
                .padding()
            
            Score(score: $score)
            
            Spacer()
            
            HStack {
                Text("\(currentTable) =")
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                
                TextField("", text: $userAnswer)
                    .onChange(of: userAnswer) { value in checkAnswer() }
                    .font(.system(size: 50))
                    .foregroundColor(answerState == true ? .green : (answerState == false ? .red : .black ))
                    .keyboardType(.numberPad)
                    .focused($isInputFocused)
            }
            .padding()
            
            Spacer()

        }
        .navigationTitle("Table: \(tableNumber)")
        .onAppear {
            fillArrayWithTableNumber()
            selectRandomElement(array: tableArray)
            isInputFocused = true
        }
        .sheet(isPresented: $isGameOver, onDismiss: { reset() }) {GameOverView(score: score)}
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(tableNumber: 2)
    }
}
