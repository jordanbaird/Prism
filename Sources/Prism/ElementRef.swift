//===----------------------------------------------------------------------===//
//
// ElementRef.swift
//
//===----------------------------------------------------------------------===//

// MARK: - ElementRef

class ElementRef {
    weak var parent: ElementRef?

    private var _nestedElements = [PrismElement]()
    var nestedElements: [PrismElement] {
        get {
            _nestedElements.reduce(into: []) {
                $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer()
            }
        }
        set {
            _nestedElements = newValue
        }
    }

    private var _prism: Prism?
    var prism: Prism? {
        get { _prism ?? parent?.prism }
        set { _prism = newValue }
    }

    private var _spacing: Prism.Spacing?
    var spacing: Prism.Spacing? {
        get {
            _spacing ?? prism?.spacing
        }
        set {
            if newValue == prism?.spacing {
                _spacing = nil
            } else {
                _spacing = newValue
            }
        }
    }
}

// MARK: - ReferencingElement

protocol ReferencingElement: PrismElement {
    associatedtype RefType: ElementRef
    var ref: RefType { get }
}

// MARK: ReferencingElement Default Implementation
extension ReferencingElement {
    public internal(set) var nestedElements: [PrismElement] {
        get {
            ref.nestedElements
        }
        nonmutating set {
            ref.nestedElements = newValue
            updateNestedElements()
        }
    }

    public var prism: Prism? {
        get {
            ref.prism
        }
        nonmutating set {
            ref.prism = newValue
        }
    }

    public var spacing: Prism.Spacing {
        get { ref.spacing ?? .spaces }
        set { ref.spacing = newValue }
    }
}

// MARK: - AttributeRef

class AttributeRef: ElementRef {
    var onSequence = ControlSequence()
    var offSequence = ControlSequence()
}

// MARK: - ReferencingAttribute

protocol ReferencingAttribute: ReferencingElement, Attribute where RefType == AttributeRef { }

// MARK: ReferencingAttribute Default Implementation
extension ReferencingAttribute {
    public internal(set) var onSequence: ControlSequence {
        get {
            ref.onSequence
        }
        nonmutating set {
            ref.onSequence = newValue
        }
    }

    public internal(set) var offSequence: ControlSequence {
        get {
            ref.offSequence
        }
        nonmutating set {
            ref.offSequence = newValue
        }
    }
}
