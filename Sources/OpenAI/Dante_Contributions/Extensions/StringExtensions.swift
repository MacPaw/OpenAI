import Foundation
import NaturalLanguage

extension String {
    var tokenCount: Int {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = self
        var tokenCount = 0
        tokenizer.enumerateTokens(in: self.startIndex..<self.endIndex) { (tokenRange, _) in
            tokenCount += 1
            return true
        }
        return tokenCount
    }
}


