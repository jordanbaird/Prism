# ``Prism``

Colored text for Swift command line tools.

## Overview

`Prism` is a DSL that uses declarative syntax to create beautiful formatted text for Swift command line tools. It's powerful, easy to use, and supports both macOS and Linux.

Start by creating an instance of the `Prism` type. Its initializer accepts a closure, which you populate with various attributes.

```swift
let text = Prism(spacing: .spaces) {
    ForegroundColor(.green, "This text's color is green.")
    Bold("This text is bold.")
    Italic("This text is italic.")
    Underline("This text is underlined.")
    Strikethrough("This text has a strikethrough.")
}
```

Attributes behave similarly to `Prism` itself, giving you the ability to nest other elements inside them. 

```swift
let text = Prism(spacing: .newlines) {
    Bold {
        "This text is bold."
        Italic("This text is bold and italic.")
        Underline("This text is bold and underlined.")
        BackgroundColor(.cyan) {
            Underline {
                "This text is bold, underlined, and has a cyan background."
                IgnoreFormatting("This text has no formatting.")
                "Back to bold and underlined, with a cyan background."
            }
        }
    }
}
```

The DSL's `ElementBuilder` implicitly wraps strings inside a special, non-modifying `Standard` attribute, allowing instances of the `String` type — including string literals — to be used inline with other elements and attributes. In the following example, the two `Prism` blocks are semantically identical.

```swift
let text1 = Prism {
    Bold("Some bold text.")
    Standard("Just regular old text.")
    Italic("Some italic text.")
}

let text2 = Prism {
    Bold("Some bold text.")
    "Just regular old text."
    Italic("Some italic text.")
}

print(text1 == text2)
// Prints: "true"
```

The `Prism` type conforms to the `CustomStringConvertible` protocol, allowing its formatted contents to be printed directly to `stdout`. If the output destination (i.e. terminal or console) does not support formatted text, the unformatted version will be automatically printed instead.

```swift
let text = Prism {
    "I see"
    ForegroundColor(.blue) {
        "skies that are blue."
    }
    ForegroundColor(.red) {
        "Red roses, too."
    }
}

print(text)
```

![Output Example](output-example)

Note that some terminal clients may display certain elements differently than others. `Prism` simply provides the terminal with a set of control codes for each attribute. It is up to the terminal to determine how it will display the control codes that `Prism` provides it.

## Topics

### Creating a Prism

- ``Prism/Prism``

### Attributes

- ``Standard``
- ``Bold``
- ``Dim``
- ``Italic``
- ``Underline``
- ``Overline``
- ``Blink``
- ``Swap``
- ``Hide``
- ``Strikethrough``
- ``ForegroundColor``
- ``BackgroundColor``
- ``IgnoreFormatting``

### Other Elements

- ``Spacer``
- ``LineBreak``
- ``Reset``

### Colors

- ``Color``
- ``Color/RGBCode``
- ``Color/Hexadecimal``
- ``Color/EightBit``
