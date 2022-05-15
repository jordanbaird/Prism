# ``Prism``

Colored text for Swift command line tools.

## Overview

`Prism` is a simple DSL that uses declarative syntax to create beautiful formatted text for Swift command line tools. While it's meant to be easy to use, it is quite powerful, and works on both macOS and Linux.

Start by creating an instance of the `Prism` type. Its initializer accepts a closure, which you populate with various attributes.

```swift
let prism = Prism {
    ForegroundColor(.green, "This text's color is green.")
    Bold("This text is bold.")
    Italic("This text is italic.")
    Underline("This text is underlined.")
    Strikethrough("This text has a strikethrough.")
}
```

Each attribute functions similarly to `Prism` itself, in that you can nest other elements inside of them. The `String` type conforms to `PrismElement`, so you can use string literals inline with other elements and attributes.

```swift
let prism = Prism {
    Bold {
        "This text is bold."
        Italic {
            "This text is bold and italic."
        }
        Underline("This text is bold and underlined.")
        BackgroundColor(.cyan) {
            Underline {
                "This text is bold, underlined, and has a cyan background."
            }
        }
    }
}
```

The `Prism` type can be directly used in a `print()` function, and the formatted string will be printed directly to the terminal or console. If the terminal or console does not support formatted text, the unformatted version of the string will be printed instead.

> Things may show up differently, depending on which terminal client is being used. It is up to the terminal to determine how it will display the control codes that `Prism` provides it.

## Topics

### Creating a Prism

- ``Prism/Prism``
