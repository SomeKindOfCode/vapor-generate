//
//  PropertyPreparationTag.swift
//  VaporToolbox-Generator
//
//  Created by Christopher Beloch on 27.10.16.
//
//

import Leaf

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
        
        return "\(typeMapping[type] ?? type)(\(parameters))".makeNode()
    }
    
    private func parameters(for propertyConfig: [String:Polymorphic]) -> String {
        return ""
    }
}
