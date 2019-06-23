//
//  ValidationModel.swift
//  simpleMVVM
//
//  Created by 常盤 匠 on 2019/06/22.
//  Copyright © 2019 takutoki. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ValidationModelProtocol: AnyObject {

    // domain & domain logic
    func validate(_ user: String?, _ password: String?) -> Observable<Void>
}

class ValidationModel: ValidationModelProtocol {

    func validate(_ user: String?, _ password: String?) -> Observable<Void> {
        switch (user, password) {
        case (.none, .none): return .error(ValidationError.inValidUserAndPassword)
        case (.none, .some): return .error(ValidationError.inValidUser)
        case (.some, .none): return .error(ValidationError.inValidPassword)
        case ( let user, let password ):
            switch (user?.isEmpty, password?.isEmpty) {
            case (true, true): return .error(ValidationError.inValidUserAndPassword)
            case (false, false): return .just(())
            case (false, true): return .error(ValidationError.inValidPassword)
            case (true, false): return .error(ValidationError.inValidUser)
            default: return .error(ValidationError.inValidUserAndPassword)
            }
        }
    }
}
