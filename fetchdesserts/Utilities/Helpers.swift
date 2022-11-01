//
//  Helpers.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/19/22.
//

import UIKit

extension UIView {
    /// Adds a view to the end of the receiver’s list of subviews.
    func addFullscreenSubview(_ subview: UIView) {
        addSubview(subview)
        let constraints = [
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.leftAnchor.constraint(equalTo: leftAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor),
            subview.rightAnchor.constraint(equalTo: rightAnchor)
        ]
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

extension KeyedDecodingContainer {
    /// Decodes a string value for the given key, if present and if the string is not empty
    func decodeIfPresentAndNonEmpty(_ type: String.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> String? {
        guard let value = try? self.decodeIfPresent(type, forKey: key),
              value.isEmptyOrWhitespace == false else {
            return nil
        }
        return value
    }
}

extension String {
    /// A Boolean value indicating whether a string has no characters, including those in the `whitespaces` character set
    var isEmptyOrWhitespace: Bool {
        return self.isEmpty || self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

extension NSDirectionalEdgeInsets {
    /// Creates a directional edge insets structure that corresponds to a singular specified value
    init(_ value: CGFloat) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }
}
