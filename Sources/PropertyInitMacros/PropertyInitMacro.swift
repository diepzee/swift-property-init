import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

struct StoredProperty {
    var name: String
    var type: String
}

extension DeclSyntaxProtocol {
    var storedProperty: StoredProperty? {
        guard let property = self.as(VariableDeclSyntax.self) else { return nil }
        guard let binding = property.bindings.first else { return nil }
        guard let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else { return nil }
        guard binding.accessorBlock == nil else { return nil }
        guard let type = binding.typeAnnotation?.type else { return nil }
        return StoredProperty(name: identifier, type: type.description)
    }
}

public struct PropertyInitMacro: MemberMacro {
    
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        let storedProperties = declaration.memberBlock.members.filter { item in
            item.decl.storedProperty != nil
        }.map { $0.decl.storedProperty! }
        var initializerParamsSyntax: String = ""
        for property in storedProperties {
            initializerParamsSyntax += "\(property.name): \(property.type), "
        }
        initializerParamsSyntax = String(initializerParamsSyntax.dropLast(2))
        
        var initializerAssignSyntax: String = ""
        for property in storedProperties {
            initializerAssignSyntax +=
             """
            self.\(property.name) = \(property.name)\n
            """
        }
        
        
    
        let storedPropertyInitializerDeclSyntax: DeclSyntax =
                """
                public init  (\(raw: initializerParamsSyntax)) {
                    \(raw: initializerAssignSyntax)
                }
                """
        return [storedPropertyInitializerDeclSyntax]
    }
    
    
}

@main
struct PropertyInitPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        PropertyInitMacro.self,
    ]
}
