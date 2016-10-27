//
//  Bytes+String.swift
//  VaporToolbox-Generator
//
//  Created by Christopher Beloch on 26.10.16.
//
//

enum GeneratorError: Error {
    case unparsable
}

extension Collection where Iterator.Element == UInt8 {
    
    public func toString() throws -> String {
        var utf = UTF8()
        var gen = self.makeIterator()
        var chars = String.UnicodeScalarView()
        while true {
            switch utf.decode(&gen) {
            case .emptyInput: //we're done
                return String(chars)
            case .error: //error, can't describe what however
                throw GeneratorError.unparsable
            case .scalarValue(let unicodeScalar):
                chars.append(unicodeScalar)
            }
        }
    }
}
