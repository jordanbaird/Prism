# ``Prism/Color/ECMA256``

A color code that produces one of the ECMA-48 standard's 256 colors.

## Overview

Due to the difficult nature of the ECMA-48 256-color mode standard, the codes have been broken up into smaller "subcodes", such as ``Grayscale``. An instance of `ECMA256` can be created by passing a value of one of these subcodes, or by accessing one of the static convenience methods.

Alternatively, if you know the exact numeric code you wish to use, you can construct an instance using the ``init(numericCode:)`` initializer. All possible numeric codes, along with their colors are displayed in the grid below.

![ECMA256 Colors](ecma-colors-grid.svg)

## Topics

### Subcodes

- ``Grayscale``
- ``StandardColor``
- ``AnySubcode``
