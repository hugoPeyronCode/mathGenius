//
//  MultiTablesInifnite.swift
//  ViewsAndModifers
//
//  Created by Hugo Peyron on 07/04/2023.
//

import SwiftUI

struct InfiniteGameView: View {
    
    @StateObject private var viewModel = MultitablesInfiniteViewModel()
    
    var body: some View {
        
        NavigationView {

            VStack(spacing: 20){
                                    
                Lifes(lostlifes: $viewModel.lostLifes)
                
                Score(score: $viewModel.score)
                                    
                Text("\(viewModel.fireIcon)")
                
                ForEach(0..<viewModel.shuffledQuestions.count, id: \.self) { index in
                    HStack(spacing: 55) {
                        VStack {
                            SelectionButton(
                                index: index,
                                selectedIndex: viewModel.selectedQuestionIndex,
                                state: viewModel.questionButtonStates[index],
                                content: viewModel.shuffledQuestions[index],
                                action: {
                                    
                                    viewModel.selectedQuestionIndex = index
                                    
                                    viewModel.questionButtonStates = viewModel.questionButtonStates.map { $0 == .touched ? .normal : $0 }
                                    
                                    viewModel.questionButtonStates[index] = .touched
                                    
                                    viewModel.checkResult()
                                    
                                }
                            )
                        }
                        
                        VStack {
                            SelectionButton(
                                index: index,
                                selectedIndex: viewModel.selectedAnswerIndex,
                                state: viewModel.answerButtonStates[index],
                                content: viewModel.shuffledAnswers[index],
                                action: {
                                    viewModel.selectedAnswerIndex = index
                                    
                                    viewModel.answerButtonStates = viewModel.answerButtonStates.map { $0 == .touched ? .normal : $0 }
                                    
                                    viewModel.answerButtonStates[index] = .touched
                                    
                                    viewModel.checkResult()
                                    
                                }
                            )
                        }
                    }
                }
                
                Button("Reset") { viewModel.restart() }
                Text("\(viewModel.lostLifes)")
            }
        }
        .navigationTitle("Match the pairs")
        .sheet(isPresented: $viewModel.isGameOver, onDismiss: {viewModel.restart() }) {GameOverView(score: viewModel.score)}
    }
}

struct InfiniteGameView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteGameView()
    }
}
