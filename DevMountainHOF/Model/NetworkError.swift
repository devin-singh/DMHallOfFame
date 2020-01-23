//
//  NetworkError.swift
//  DevMountainHOF
//
//  Created by Devin Singh on 1/23/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation


enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case thrownError(Error)
}
