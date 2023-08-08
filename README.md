#  PropertyInit


## Description

The propertyInit Macro is a simple macro which automagically generates a memberwise initializer.

## Usage

1. Use the Swift PackageManager to obtain the Package from GitHub.
2. Import the PropertyInit Macro.
3. Attach the Macro to your class. 

```swift
import PropertyInit 

@propertyInit
class MyClass {
    var name: String
    var number: Int
}
```

The code above will generate the following initializer inside the class:

```swift
public init (name: String, number: Int) {
    self.name = name
    self.number = number
}
```

## Roadmap

Features coming soon:

- Initializer generation for `@Model` (SwiftData)
- Macro for generating the parameter label for the initializer.
- For the `propertyInit` macro, an argument for setting the initializer access level.

## Availability

**Swift**   - 5.9  
**macOS**   - Sonoma  
**iOS**     - 17  
**tvOS**    - 17  
**watchOS** - 10  


## License

PropertyInit is licensed onder the MIT License.
See LICENSE.txt for more information.




