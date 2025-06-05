//
// File.swift
// HighlightSwift
//
// Copyright © 2025 wangqiyangX.
// All Rights Reserved.
//

import SwiftUI

public protocol CodeTextHeaderStyle {
    var font: Font { get }
    var foregroundStyle: any ShapeStyle { get }
}

//  MARK: - Default

public struct DefaultCodeTextHeaderStyle: CodeTextHeaderStyle {
    public init() {}

    public let font: Font = .caption
    public let foregroundStyle: any ShapeStyle = Color.primary
}

extension CodeTextHeaderStyle where Self == DefaultCodeTextHeaderStyle {

    /// The default code text style with no decoration.
    public static var `default`: DefaultCodeTextHeaderStyle {
        DefaultCodeTextHeaderStyle()
    }
}
