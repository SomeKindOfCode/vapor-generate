//
//  PropertyPreparationTag.swift
//  VaporToolbox-Generator
//
//  Created by Christopher Beloch on 27.10.16.
//
//

import Leaf
import Node

class PropertyPreparationTag: BasicTag {
    let name = "propprep"
        
    private let typeMapping = [
        "integer": "int"
    ]
    
    func run(arguments: [Argument]) throws -> Node? {
        guard
            arguments.count == 1,
            let propertyConfig = arguments[0].value?.object,
            let type = propertyConfig["type"]?.string?.lowercased()
            else { return nil }
        
        let parameters = self.parameters(for: propertyConfig)
        
        let column = PropertyColumnTag()
        let columnName = try column.run(arguments: arguments)?.string ?? ""
        
        return String(
            format: "%@(\"%@\"%@)",
            typeMapping[type] ?? type,
            columnName,
            parameters
        ).makeNode()
    }
    
    private func parameters(for propertyConfig: [String:Polymorphic]) -> String {
        return ""
    }
}
