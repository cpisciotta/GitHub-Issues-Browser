//
//  String+Capitalize.swift
//  GHIssues
//
//  Created by Charles Pisciotta on 10/26/20.
//

import Foundation

/*
 This extension was taken from Hacking with Swift.

 https://www.hackingwithswift.com/example-code/strings/how-to-capitalize-the-first-letter-of-a-string
 */

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
