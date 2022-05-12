[![Prism](https://user-images.githubusercontent.com/90936861/167498476-bd8a4192-679c-4a53-ac87-b15dd1aaa769.png)](https://github.com/jordanbaird/Prism)

![Continuous Integration](https://img.shields.io/github/workflow/status/jordanbaird/Prism/Swift)
[![Code Coverage](https://codecov.io/gh/jordanbaird/Prism/branch/main/graph/badge.svg?token=C60OOWRYQ2)](https://codecov.io/gh/jordanbaird/Prism)
![Release](https://img.shields.io/github/v/release/jordanbaird/Prism)
![Swift](https://img.shields.io/badge/dynamic/json?color=orange&label=Swift&query=Swift&suffix=%2B&url=https%3A%2F%2Frunkit.io%2Fjordanbaird%2F627c27d5c44b1b0008980644%2Fbranches%2Fmaster)
![License](https://img.shields.io/github/license/jordanbaird/Prism)

`Prism` is a simple DSL that uses declarative syntax to create beautiful formatted text for Swift command line tools. While it is meant to be easy to use, it is also quite powerful. It works on both macOS and Linux.

## Install

Add the following to your `Package.swift` file:

```swift
import PackageDescription
let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/jordanbaird/Prism", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "PackageName",
            dependencies: ["Prism"]
        )
    ]
)
```

## Usage

[Read the full documentation here](https://jordanbaird.github.io/Prism/documentation/prism/)

Start by creating an instance of the `Prism` type. Its initializer accepts a closure, which you populate with various attributes.

```swift
let prism = Prism(spacing: .managed(.lineBreaks)) {
    ForegroundColor(.green, "This text's foreground is green.")
    BackgroundColor(.blue, "This text's background is blue.")
    Bold("This text is bold.")
    Dim("This text is dim.")
    Italic("This text is italic.")
    Underline("This text is underlined.")
    Blink("This text blinks.")
    Swap("This text has its foreground and background colors swapped.")
    Strikethrough("This text has a strikethrough.")
}
print(prism)
```

The result will look something like this:

<div align="center">
    <a href="https://github.com/jordanbaird/Prism">
        <img width="671" src="https://user-images.githubusercontent.com/90936861/167680957-bbf0caa8-9e7a-407f-98c1-ac52fe46f531.png">
    </a>
</div>

Each attribute functions similarly to `Prism` itself, in that you can nest other elements inside of them.

> Things may show up differently, depending on which terminal client is being used. It is up to the terminal to determine how it will display the control codes `Prism` provides it.
