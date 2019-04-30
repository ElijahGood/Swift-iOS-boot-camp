//var cardDeck = Deck(sorted: true); //sorted
var cardDeck = Deck(sorted: false); //mixed
print("-->> Before: ", cardDeck, " SUM=", cardDeck.cards.count);

//draw testing
for _ in 1...5 {
	let drawCard = cardDeck.draw();
	print("-+-+- DRAWN= ", drawCard!);
}

print("\n-->> After: ", cardDeck, " SUM=", cardDeck.cards.count);
print("\n=> OUTS= ", cardDeck.outs);

//fold testing
print("\n>>>FOLDING HERE!<<<");
//valid fold
cardDeck.fold(c: cardDeck.outs[0]);
cardDeck.fold(c: cardDeck.outs[1]);
//invalid fold
cardDeck.fold(c: cardDeck.cards[0]);

// finish check
print("\n=> OUTS= ", cardDeck.outs);
print("\n=> DISCARDS= ", cardDeck.discards);
print("-->> At the end: ", cardDeck, " SUM=", cardDeck.cards.count);