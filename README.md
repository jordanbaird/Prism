[![Prism](/media/header.svg)](https://github.com/jordanbaird/Prism)

[![Continuous Integration](https://img.shields.io/github/workflow/status/jordanbaird/Prism/Swift?style=flat-square)]()
[![Code Coverage](https://img.shields.io/codecov/c/github/jordanbaird/Prism?label=codecov&logo=codecov&style=flat-square)](https://codecov.io/gh/jordanbaird/Prism)
[![Swift Versions](https://img.shields.io/badge/dynamic/json?color=F05138&label=Swift&query=%24.message&url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjordanbaird%2FPrism%2Fbadge%3Ftype%3Dswift-versions&style=flat-square)](https://swiftpackageindex.com/jordanbaird/Prism)
[![Supported Platforms](https://img.shields.io/badge/dynamic/json?color=F05138&label=Platforms&query=%24.message&url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjordanbaird%2FPrism%2Fbadge%3Ftype%3Dplatforms&style=flat-square)](https://swiftpackageindex.com/jordanbaird/Prism)
[![Latest Release](https://img.shields.io/github/v/release/jordanbaird/Prism?style=flat-square)](https://github.com/jordanbaird/Prism/releases/latest)
[![License](https://img.shields.io/github/license/jordanbaird/Prism?style=flat-square)](https://github.com/jordanbaird/Prism/blob/main/LICENSE)

`Prism` is a DSL that uses declarative syntax to create beautiful formatted text for Swift command line tools. While it's meant to be easy to use, it is quite powerful, and works on both macOS and Linux.

[![Styles](/media/styles.svg)](https://github.com/jordanbaird/Prism)

## Install

Add the following dependency to your `Package.swift` file:

```swift
.package(url: "https://github.com/jordanbaird/Prism", from: "0.0.6")
```

## Usage

[Read the full documentation here](https://swiftpackageindex.com/jordanbaird/Prism/documentation)

Start by creating an instance of the `Prism` type. Its initializer accepts a closure, which you populate with various attributes.

```swift
let text = Prism {
    ForegroundColor(.green, "This text's color is green.")
    Bold("This text is bold.")
    Italic("This text is italic.")
    Underline("This text is underlined.")
    Strikethrough("This text has a strikethrough.")
}
```

Each attribute behaves similarly to `Prism` itself, in that you can nest other elements inside of them.

```swift
let text = Prism {
    Bold {
        "This text is bold."
        Italic {
            "This text is bold and italic."
        }
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

The DSL backend implicitly wraps strings inside the non-modifying `Standard` attribute, allowing instances of the `String` type — including string literals — to be used inline with other elements and attributes.

```swift
let text1 = Prism {
    Standard("Just regular old text.")
}

let text2 = Prism {
    "Just regular old text."
}

print(text1 == text2)
// Prints: "true"
```

The `Prism` type can be directly used in a `print()` function, and the formatted string will be printed directly to the terminal or console. If the terminal or console does not support formatted text, the unformatted version of the string will be automatically printed instead.

- NOTE: Some terminal clients may display certain elements differently than others. `Prism` simply provides the terminal with a set of control codes for each attribute. It is up to the terminal to determine how it will display the control codes that `Prism` provides it.

## License

Prism is licensed under the [MIT license](http://www.opensource.org/licenses/mit-license).
