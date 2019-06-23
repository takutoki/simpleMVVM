//
//  ValidationError.swift
//  simpleMVVM
//
//  Created by 常盤 匠 on 2019/06/22.
//  Copyright © 2019 takutoki. All rights reserved.
//

import Foundation

enum ValidationError: Error {
    case inValidUser
    case inValidPassword
    case inValidUserAndPassword
}

extension ValidationError {

    var errorText: String {
        switch self {
        case .inValidUser: return "ユーザーが未入力です。"
        case .inValidPassword: return "パスワードが未入力です"
        case .inValidUserAndPassword: return "ユーザーとパスワードが未入力です"
        }
    }
}
