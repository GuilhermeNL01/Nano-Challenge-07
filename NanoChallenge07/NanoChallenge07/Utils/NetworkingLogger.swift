//
//  NetworkingLogger.swift
//  NanoChallenge07
//
//  Created by Fabio Freitas on 24/06/24.
//

import Foundation
import OSLog

extension Logger {
    private static let bundle = Bundle.main.bundleIdentifier!
    static let networkingManager = Logger(subsystem: bundle, category: "Networking")
}
