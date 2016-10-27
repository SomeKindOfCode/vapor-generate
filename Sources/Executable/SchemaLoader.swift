//
//  SchemaLoader.swift
//  VaporToolbox-Generator
//
//  Created by Christopher Beloch on 26.10.16.
//
//

import Foundation
import JSON

class SchemaLoader {
    class func parseModel(at: URL) throws -> Node {
        let content = try String(contentsOf: at)
        let json = try JSON(serialized: content.bytes)
        
        // Load Information
        let modelName = json["model"]?.string ?? at.baseFilename.capitalized
        
        return [
            "MODELNAME": modelName.makeNode(),
            "properties": self.properties(from: json["properties"])
        ]
    }
    
    private class func properties(from json: JSON?) -> Node {
        guard let json = json else { return Node.null }
        
        return json.makeNode()
    }
}
