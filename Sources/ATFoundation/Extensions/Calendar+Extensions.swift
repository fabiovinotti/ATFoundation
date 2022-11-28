//
//  Calendar+Extensions.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation

extension Calendar {

    public func elapsedDays(since date: Date) -> Int {
        dateComponents([.day], from: date, to: Date()).day!
    }

    public func elapsedDays(from start: Date, to end: Date) -> Int {
        dateComponents([.day], from: start, to: end).day!
    }

}
