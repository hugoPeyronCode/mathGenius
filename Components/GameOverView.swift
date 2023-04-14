//
//  GameOverView.swift
//  ViewsAndModifers
//
//  Created by Hugo Peyron on 07/04/2023.
//

import SwiftUI

struct GameOverView: View {
    
    var score: Int
    
    var body: some View {
        
        Text("Game Over")
        
        // Ici je veux afficher le score du joueur
        Text("Your score: \(score)")
        
        // je veux afficher un text en fonction du score du joueur
        
        // je veux afficher un text si le joueur à battu son meilleur score
        
        // je veux afficher les erreurs du joueur
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(score: 42)
    }
}
