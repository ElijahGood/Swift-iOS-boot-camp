//first pair

var card1 = Card(color: Color.Spades, value: Value.Two);
print("You picked first card ->", card1.description);

var card2 = Card(color: Color.Diamonds, value: Value.Two);
print("You picked second card ->", card1.description);

if card1 == card2 {
	print(" Equal!");
} else {
	print(" Not equal!");
}


// second pair

card1 = Card(color: Color.Spades, value: Value.Two);
print("You picked first card ->", card1.description);

card2 = Card(color: Color.Spades, value: Value.Two);
print("You picked second card ->", card1.description);

if card1 == card2 {
	print(" Equal!");
} else {
	print(" Not equal!");
}