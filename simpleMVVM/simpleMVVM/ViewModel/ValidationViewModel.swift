//
//  ValidationViewModel.swift
//  simpleMVVM
//
//  Created by 常盤 匠 on 2019/06/22.
//  Copyright © 2019 takutoki. All rights reserved.
//

import RxSwift
import RxCocoa

class ValidationViewModel {

    var validationTextStream: Observable<String>
    var validationColorStream: Observable<UIColor>

    init(userTextStream: Observable<String?>, passwordTextStream: Observable<String?>, inject model: ValidationModelProtocol) {

        // テキスト入力のたびにStreamに値が流れる
        let eventStream = Observable
            .combineLatest(userTextStream, passwordTextStream)
            .skip(1)
            .flatMap{ user, password -> Observable<Event<Void>> in
                return model.validate(user, password).materialize() }
            .share() // ここまでHot

        validationTextStream = eventStream
            .debug("validationTextStream", trimOutput: false)
            .flatMap{ (event: Event<Void>) -> Observable<String> in
                switch event {
                case .next(_): return .just("OK!!!")
                case .error(let error as ValidationError): return .just(error.errorText)
                case .completed, .error: return .empty() }
            }
            .startWith("ユーザーとパスワードを入力してください。")

        validationColorStream = eventStream
            .debug("validationColorStream", trimOutput: false)
            .flatMap{ (event: Event<Void>) -> Observable<UIColor> in
                switch event {
                case .next: return .just(.green)
                case .error: return .just(.red)
                case .completed: return .empty() }
            }
    }
}
