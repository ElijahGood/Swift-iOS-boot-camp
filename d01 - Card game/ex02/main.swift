let fulldeck = Deck.allCards;

print("--> Deck consist of:");
for item in fulldeck {
	print(" ", item);	
}

let hearts = Deck.allHearts;
print("-->> Hearts family includes:");
for item in hearts {
	print(" ", item);	
}

let clubs = Deck.allClubs;
print("-->> Clubs family includes:");
for item in clubs {
	print(" ", item);	
}

let diamonds = Deck.allDiamonds;
print("-->> Diamonds family includes:");
for item in diamonds {
	print(" ", item);	
}

let spades = Deck.allSpades;
print("-->> Spades family includes:");
for item in spades {
	print(" ", item);	
}

print("Total num of cards=", fulldeck.count);