# ``Prism/PrismColor/EightBit``

A color code that produces one of the ECMA-48 standard's 256 8-bit colors.

## Overview

Due to the difficult nature of the ECMA-48 8-bit standard, the codes have been broken up into smaller "subcodes", such as ``EightBit/Grayscale``. An instance of ``EightBit`` can be created by passing a value of one of these subcodes, or by accessing one of the static convenience methods.

Alternatively, if you know the exact numeric code you wish to use, you can construct an instance using the ``EightBit/init(numericCode:)`` initializer. All possible numeric codes, along with their colors are displayed in the grid below.

![8-Bit Colors](ecma-colors-grid)

## Topics

### Subcodes

- ``EightBit/Grayscale``
- ``EightBit/StandardColor``
- ``EightBit/AnySubcode``
