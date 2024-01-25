import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = [
        Card(id: 0, color: .red),
        Card(id: 1, color: .green),
        Card(id: 2, color: .yellow),
        Card(id: 3, color: .blue),
        Card(id: 4, color: .indigo),
        Card(id: 5, color: .mint),
        Card(id: 6, color: .cyan),
        Card(id: 7, color: .pink),
        Card(id: 8, color: .red),
        Card(id: 9, color: .green),
        Card(id: 10, color: .yellow),
        Card(id: 11, color: .blue),
        Card(id: 12, color: .indigo),
        Card(id: 13, color: .mint),
        Card(id: 14, color: .cyan),
        Card(id: 15, color: .pink)
    ]
    
    var body: some View {
        
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 4), spacing: 10) {
                ForEach(cards) { card in
                    CardView(card: card) {
                        cardTapped(card)
                    }
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(height: 120)
                }
            }
        }
        .padding()
    }
    
    private func cardTapped(_ selectedCard: Card) {
        guard let selectedIndex = cards.firstIndex(where: { $0.id == selectedCard.id && !$0.isFaceUp && !$0.isMatched }) else {
            return
        }

        cards[selectedIndex].isFaceUp.toggle()

        let faceUpCards = cards.filter { $0.isFaceUp && !$0.isMatched }

        if faceUpCards.count == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let isMatch = faceUpCards[0].color == faceUpCards[1].color

                for index in cards.indices {
                    if cards[index].isFaceUp && !cards[index].isMatched {
                        cards[index].isMatched = isMatch
                        cards[index].isFaceUp = isMatch || !cards[index].isFaceUp
                    }
                }
            }
        }
    }

}

struct CardView: View {
    let card: Card
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(card.color)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.5))
            }
        }
        .onTapGesture {
            onTap()
        }
    }
}

struct Card: Identifiable {
    let id: Int
    let color: Color
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
