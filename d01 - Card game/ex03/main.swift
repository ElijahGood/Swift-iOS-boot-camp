var cardDeck = Deck.allCards;

cardDeck.shuffle();

var i: Int = 0;
print(" -> Shuffle in da House:");
for item in cardDeck{
	print(item);
	i += 1;
}

print("*** Total number of cards =", i);