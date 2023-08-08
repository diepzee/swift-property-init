// The Swift Programming Language
// https://docs.swift.org/swift-book

/// # propertyinit
/// PropertyInit is a small macro which automagically generates an initializer for
/// stored properties, so you don't have to write the boilerplate initializer yourself
/// hand have them elegantly folded away behind this macro.
///
/// - Example Usage:
///
/// ``` swift
/// import SwiftData
/// import PropertyInit
///
/// @propertyInit
/// final class MySwiftDataModel {
///     var name: String
///     var number: Int
/// }
///
/// ```
@available(swift 5.9)
@available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
@attached(member, names: named(init))
public macro propertyInit() = #externalMacro(module: "PropertyInitMacros", type: "PropertyInitMacro")
