import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(PropertyInitMacros)
import PropertyInitMacros

let testMacros: [String: Macro.Type] = [
    "propertyInit": PropertyInitMacro.self
]
#endif

final class PropertyInitTests: XCTestCase {
    func testMacro() throws {
        #if canImport(PropertyInitMacros)
        assertMacroExpansion(
            """
            @propertyInit
            class testclass {
                var a: Int
            }
            """,
            expandedSource: """
            
            class testclass {
                var a: Int

                public init  (a: Int) {
                    self.a = a

                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
