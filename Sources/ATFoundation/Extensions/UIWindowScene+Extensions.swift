//
//  UIWindowScene+Extensions.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import UIKit

extension UIWindowScene {

    /// An active scene onscreen and visible to the user.
    static var foregroundActive: UIWindowScene? {
        let connectedScenes = UIApplication.shared.connectedScenes

        let activeScene = connectedScenes.first {
            $0.activationState == .foregroundActive
        }

        return activeScene as? UIWindowScene
    }

}
