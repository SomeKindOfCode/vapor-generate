//
//  GenerateModelCommand.swift
//  VaporToolbox-Generator
//
//  Created by Christopher Beloch on 26.10.16.
//
//

import Console
import Foundation
import Leaf

final class GenerateModelCommand: Command {
    public let id = "generate"
    public let help = ["This command will generate model files based on schemas in Config/model"]
    public let console: ConsoleProtocol
    
    private let sourceSchemes: URL = URL(fileURLWithPath: "./Config/models/")
    private let destination: URL = URL(fileURLWithPath: "./Sources/App/Models/")
    
    public init(console: ConsoleProtocol) {
        self.console = console
    }
    
    public func run(arguments: [String]) throws {
//        let response = try console.backgroundExecute(program: "pwd", arguments: [])
//        console.print(response)
                
        let sourceFiles = try FileManager.default.contentsOfDirectory(
            at: self.sourceSchemes, 
            includingPropertiesForKeys: nil, 
            options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles
        ).filter {
            $0.pathExtension == "json"
        }
        
        console.print("Found \(sourceFiles.count) schemes")
        
        // Begin rendering
        
        try sourceFiles.forEach { (sourceFile) in
            let renderedModel = try self.renderTemplate(with: self.loadModelContext(from: sourceFile))
            
            try self.writeModel(renderedModel, name: sourceFile.baseFilename.capitalized)
        }
    }
    
    private func loadModelContext(from: URL) throws -> Context {
        return try Context(SchemaLoader.parseModel(at: from))
    }
    
    /// renders the model template
    /// - Parameter context: Context Input as you would pass to Leaf
    /// - Returns: Rendered Model Source Code
    private func renderTemplate(with context: Context) throws -> String {
        
        let stem = Stem(workingDirectory: ".")
        stem.register(PropertyPreparationTag())
        stem.register(PropertyColumnTag())
        let template = try stem.spawnLeaf(raw: String(contentsOfFile: "model.leaf"))
        
        return try stem.render(template, with: context).toString()
    }
    
    private func writeModel(_ sourceCode: String, name: String) throws {
        try FileManager.default.createDirectory(at: self.destination, withIntermediateDirectories: true, attributes: nil)
        
        let destination = self.destination.appendingPathComponent("\(name).swift")
        
        if FileManager.default.fileExists(atPath: destination.path) {
            console.print("> Model \"\(name)\" exists - skipping")
        } else {
            console.print("Generating \(name)")
            let postProducedSource = self.postProduction(sourceCode)
            try postProducedSource.write(
                to: destination, 
                atomically: false, 
                encoding: .utf8
            )
        }
    }
    
    private func postProduction(_ sourceCode: String) -> String {
        // We have to replace the HTML encoded quotation marks
        // because we can't mix #raw and our custom tags in the leaf template
        // ¯\_(ツ)_/¯ 
        return sourceCode.replacingOccurrences(of: "&quot;", with: "\"")
    }
}
