import Foundation

class Card: NSObject {
	
    var color: Color;
    var value: Value;

	init(color: Color, value: Value) {
        self.color = color;
        self.value = value;
	}
    
    override var description: String {
        let res = "\(self.value) of \(self.color)";
        return (res);
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let temp = object as? Card {
            return (self.value == temp.value && self.color == temp.color);
        }
        return (false);
    }
    
}
