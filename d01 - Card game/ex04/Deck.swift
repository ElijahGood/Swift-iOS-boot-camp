import Foundation

class Deck : NSObject {

	static let allHearts: [Card] = Value.allValues.map({ (item) -> Card in
        let temp = Card(color: Color.Hearts, value: item);
        return temp;
    })

    static let allClubs: [Card] = Value.allValues.map({ (item) -> Card in
        let temp = Card(color: Color.Clubs, value: item);
        return temp;
    })

    static let allDiamonds: [Card] = Value.allValues.map({ (item) -> Card in
        let temp = Card(color: Color.Diamonds, value: item);
        return temp;
    })

    static let allSpades: [Card] = Value.allValues.map({ (item) -> Card in
        let temp = Card(color: Color.Spades, value: item);
        return temp;
	})

    static let allCards: [Card] = allHearts + allClubs + allDiamonds + allSpades;
	//or
    //static let allSpades: [Card] = Value.allValues.map({Card(color: Color.Spades, value: $0)});
    
    
    var cards: [Card] = allCards;
    var discards: [Card] = [];
    var outs: [Card] = [];
    
    init(sorted: Bool){
        
        self.cards = Deck.allCards;
//         // mb?
//        self.discards = [];
//        self.outs = [];
        if sorted == false {
            self.cards.shuffle();
        }
    }
    
    override var description: String{
        return "\(self.cards)";
    }
    
    func draw() -> Card? {
        var drawCard : Card?;
        drawCard = self.cards.first;
        self.outs.append(drawCard!);
        self.cards.removeFirst();
        return drawCard;
    }
    
    func fold(c: Card) {
        var index = 0;
        for item in self.outs {
            if c == item {
                self.discards.append(item);
                self.outs.remove(at:index);
            }
            index += 1;
        }
    }
}


extension Array {
    mutating func shuffle() {
        for i in indices {
            let j = Int(arc4random_uniform(UInt32(self.count - i))) + i;
            if (j != i){
                self.swapAt(j, i);
            }
        }
    }
}
