//
//  PropertyColumnTag.swift
//  VaporToolbox-Generator
//
//  Created by Christopher Beloch on 27.10.16.
//
//

import Leaf

class PropertyColumnTag: BasicTag {
    let name = "propcolumn"
    
    func run(arguments: [Argument]) throws -> Node? {
        guard
            arguments.count == 1,
            let propertyConfig = arguments[0].value?.object,
            let propertyName = propertyConfig["key"]?.string
            else { return nil }
        
        guard let propertyColumn = propertyConfig["column"]?.string 
            else { return propertyName.makeNode() }
        
        return propertyColumn.makeNode()
    }
}
