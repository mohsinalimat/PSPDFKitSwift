//
//  Copyright (c) 2018 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from
//  this file.
//

import Foundation
@_exported import PSPDFKit // Clang module

public typealias PDFAnnotation = PSPDFAnnotation

extension PSPDFAnnotation {
    /// Additional action types.
    public var additionalActions: [PSPDFAnnotationTriggerEvent: PSPDFAction]? {
        get {
            var dictionary = [PSPDFAnnotationTriggerEvent: PSPDFAction]()
            for (key, value) in __additionalActions ?? [:] {
                dictionary[PSPDFAnnotationTriggerEvent(rawValue: key.uint8Value)!] = value
            }
            return dictionary.isEmpty ? nil : dictionary
        }
        set {
            var intenalDictionary = [NSNumber: PSPDFAction]()
            for (key, value) in newValue ?? [:] {
                intenalDictionary[NSNumber(value: key.rawValue)] = value
            }
            __additionalActions = intenalDictionary.isEmpty ? nil : intenalDictionary
        }
    }

    /**
     (Optional; valid only if the value of `borderStyle` is `PSPDFAnnotationBorderStyleDashed`)
     Array of boxed integer-values defining the dash style.

     Values |        Dash
     --------------------------------
     []     |   ━━━━━━━━━━━━━━━━━━━━
     [3]    |   ━   ━━━   ━━━   ━━━
     [2]    |   ━  ━  ━  ━  ━  ━  ━
     [2,1]  |   ━━ ━━ ━━ ━━ ━━ ━━ ━━
     [3,5]  |   ━━━     ━━━     ━━
     [2,3]  |   ━   ━━   ━━   ━━   ━
     */
    public var dashArray: [Int]? {
        get {
            return __dashArray?.map { $0.intValue }
        }
        set {
            __dashArray = newValue?.map { NSNumber(value: $0) }
        }
    }

    /// Certain annotation types like highlight can have multiple rects.
    public var rects: [CGRect]? {
        get {
            return __rects?.map { value -> CGRect in
                value.rectValue
            }
        }
        set {
            __rects = newValue?.map { cgRect -> NSValue in
                NSValue(rect: cgRect)
            }
        }
    }

    /**
     Line, Polyline and Polygon annotations have points.
     Contains `NSValue` objects that box a `CGPoint`.

     @note These values might be generated on the fly from an internal, optimized representation.
     */
    public var points: [CGPoint]? {
        get {
            return __points?.map { value -> CGPoint in
                value.pointValue
            }
        }
        set {
            __points = newValue?.map { cgPoint -> NSValue in
                NSValue(point: cgPoint)
            }
        }
    }
}
