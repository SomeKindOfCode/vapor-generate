//
//  URL+Filename.swift
//  VaporToolbox-Generator
//
//  Created by Christopher Beloch on 26.10.16.
//
//

import Foundation

extension URL {
    /// return filename without extension
    var baseFilename: String {
        let filename = self.lastPathComponent
        var split = filename.components(separatedBy: ".")
        _ = split.popLast()
        
        return split.joined(separator: ".")
    }
}
