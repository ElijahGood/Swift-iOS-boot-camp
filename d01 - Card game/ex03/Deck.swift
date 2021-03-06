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
