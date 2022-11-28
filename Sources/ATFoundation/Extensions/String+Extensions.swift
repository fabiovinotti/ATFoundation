//
//  String+Extensions.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation

extension String {

    public var lastPathComponent: String {
        (self as NSString).lastPathComponent
    }

}
