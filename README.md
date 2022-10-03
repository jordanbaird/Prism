[![Prism](/media/header.svg)](https://github.com/jordanbaird/Prism)

![Continuous Integration](https://img.shields.io/github/workflow/status/jordanbaird/Prism/Swift)
[![Code Coverage](https://codecov.io/gh/jordanbaird/Prism/branch/main/graph/badge.svg?token=C60OOWRYQ2)](https://codecov.io/gh/jordanbaird/Prism)
![Release](https://img.shields.io/github/v/release/jordanbaird/Prism)
![Swift Version](https://img.shields.io/badge/Swift-5.5%2B-orange)
![License](https://img.shields.io/github/license/jordanbaird/Prism)

`Prism` is a simple DSL that uses declarative syntax to create beautiful formatted text for Swift command line tools. While it's meant to be easy to use, it is quite powerful, and works on both macOS and Linux.

[![Styles](/media/styles.svg)](https://github.com/jordanbaird/Prism)

## Install

Add the following dependency to your `Package.swift` file:

```swift
.package(url: "https://github.com/jordanbaird/Prism", from: "0.0.4")
```

## Usage

[Read the full documentation here](https://swiftpackageindex.com/jordanbaird/Prism/main/documentation/prism)

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

NOTE: Things may show up differently, depending on which terminal client is being used. It is up to the terminal to determine how it will display the control codes that `Prism` provides it.
