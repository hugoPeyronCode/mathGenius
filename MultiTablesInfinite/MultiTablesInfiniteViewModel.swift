//
//  MultiTablesViewModel
//  ViewsAndModifers
//
//  Created by Hugo Peyron on 07/04/2023.
//

import Foundation
import SwiftUI

// The view model class to manage the game state
class MultitablesInfiniteViewModel : ObservableObject {
    // initialise the multiplications tables
    let table = Tables()
    
    // all the published properties required to manage the game state
    @Published var score = 0
    @Published var streak = 0
    @Published var fireIcon = " "
    @Published var lostLifes = 0
    @Published var isGameOver = false
    
    // Managing my button state for both questions and answers
    @Published var questionButtonStates: [ButtonState] = Array(repeating: .normal, count: 5)
    @Published var answerButtonStates: [ButtonState] = Array(repeating: .normal, count: 5)
    
    @Published var questionTouchedStates: [Bool] = Array(repeating: false, count: 5)
    @Published var answerTouchedStates: [Bool] = Array(repeating: false, count: 5)
    
    // Current pair of questions/answer pair
    @Published var selectedQuestionIndex: Int? = nil
    @Published var selectedAnswerIndex: Int? = nil
    
    
    // Last pair of question/answer selected
    @Published var previousSelectedQuestionIndex: Int? = nil
    @Published var previousSelectedAnswerIndex: Int? = nil
    
    @Published var shuffledQuestions: [String] = ["6 x 8","7 x 6","4 x 3","2 x 8", "9 x 7"]
    @Published var shuffledAnswers: [String] = ["42", "63", "48", "16", "12"]
    
    
    // Check the result. Triggered once a pairs as been done. Could be done in both ways, first an answer selected then a question and vice versa
    func isGoodAnswer() -> Bool {
        
        var result: Bool
        
        guard let questionIndex = selectedQuestionIndex, let answerIndex = selectedAnswerIndex else { return false }
        
        let question = shuffledQuestions[questionIndex]
        let answer = shuffledAnswers[answerIndex]
        
        guard let correctAnswer = table.tables.first(where: { $0.key == question })?.value else { return false }
        
        if correctAnswer == answer {result = true}
        else {result = false}
        
        return result
    }
    
    func checkResult() {
        guard let questionIndex = selectedQuestionIndex, let answerIndex = selectedAnswerIndex else { return }
        
        if isGoodAnswer() {
            withAnimation(.linear(duration: 0.5).delay(0.5)) {
                handleCorrectAnswer(questionIndex: questionIndex, answerIndex: answerIndex)
            }
        } else {
            withAnimation {
                handleIncorrectAnswer(questionIndex: questionIndex, answerIndex: answerIndex)

            }
        }
        
        //resetTouchStates(questionIndex: questionIndex, answerIndex: answerIndex)
        updateSelectedIndexes()
    }
    

    func handleCorrectAnswer(questionIndex: Int, answerIndex: Int) {

        // Set the state of the selected question and answer buttons to .valid
            questionButtonStates[questionIndex] = .valid
            answerButtonStates[answerIndex] = .valid
    
        // Update streak and score
            updateStreakAndScore()
        
        // Replace the previous selected question and answer with new ones.
        if let prevQuestionIndex = previousSelectedQuestionIndex, let prevAnswerIndex = previousSelectedAnswerIndex {
            replaceQuestionAndAnswer(questionIndex: prevQuestionIndex, answerIndex: answerIndex )
            // Replace the current selected question and answer with new ones.
            replaceQuestionAndAnswer(questionIndex: questionIndex, answerIndex: prevAnswerIndex )
            // Reset the previous selected question and answer indexes.
            previousSelectedQuestionIndex = nil
            previousSelectedAnswerIndex = nil
        } else {
            // If there was no previously selected question and answer, store the current ones.
            previousSelectedQuestionIndex = questionIndex
            previousSelectedAnswerIndex = answerIndex
        }
        
        
    }

    func handleIncorrectAnswer(questionIndex: Int, answerIndex: Int) {
        
        withAnimation {
            streak = 0
            lostLifes += 1
        }
        
        // Set the state of the selected question and answer buttons to .wrong
        questionButtonStates[questionIndex] = .wrong
        answerButtonStates[answerIndex] = .wrong
        
        // Add a delay before resetting the button states back to .normal
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              withAnimation(.easeIn(duration: 0.3)) {
                  self.questionButtonStates[questionIndex] = .normal
                  self.answerButtonStates[answerIndex] = .normal
              }
          }
        
        if lostLifes >= 5 {
            isGameOver = true
        }
    }

    func updateStreakAndScore() {
        
        streak += 1
        
        let bonusPoints: Int
        let fireIcons: String
        
        if streak >= 20 {
            bonusPoints = 12
            fireIcons = "🔥🔥🔥"
        } else if streak >= 10 {
            bonusPoints = 6
            fireIcons = "🔥🔥"
        } else if streak >= 5 {
            bonusPoints = 3
            fireIcons = "🔥"
        } else {
            bonusPoints = 0
            fireIcons = " "
        }
        
        score += 1 + bonusPoints
        fireIcon = fireIcons
    }

    func restart() {
        score = 0
        streak = 0
        fireIcon = " "
        lostLifes = 0
    }

    func resetTouchStates(questionIndex: Int, answerIndex: Int) {
        questionTouchedStates[questionIndex] = false
        answerTouchedStates[answerIndex] = false
    }

    func updateSelectedIndexes() {
        selectedQuestionIndex = nil
        selectedAnswerIndex = nil
    }

    func selectRandomValue() -> (key: String, value: String) {
        let shuffledData = table.tables.shuffled()
        let randomValue = shuffledData.first!
        return (key: randomValue.key, value: randomValue.value)
    }

    func replaceQuestionAndAnswer(questionIndex: Int, answerIndex: Int) {
        let newPair = selectRandomValue()
        
        withAnimation(.linear(duration: 1).delay(1)) {
            questionButtonStates[questionIndex] = .normal
        }
        
        withAnimation(.linear(duration: 1.5).delay(1.5)) {
            answerButtonStates[answerIndex] = .normal
        }
        
        shuffledQuestions[questionIndex] = newPair.key
        shuffledAnswers[answerIndex] = newPair.value
    }
}

