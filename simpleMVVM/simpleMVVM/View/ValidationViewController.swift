//
//  ValidationViewController.swift
//  simpleMVVM
//
//  Created by 常盤 匠 on 2019/06/22.
//  Copyright © 2019 takutoki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ValidationViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!

    // ViewInputStreamをViewModelに渡す
    private lazy var viewModel = ValidationViewModel(userTextStream: userTextField.rx.text.asObservable(), passwordTextStream: passwordTextField.rx.text.asObservable(), inject: ValidationModel())

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindMessageLabel()
        bindMessageLabelColor()
    }

    private func bindMessageLabel() {
        viewModel.validationTextStream
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func bindMessageLabelColor() {
        viewModel.validationColorStream
            .bind(to: messageColorBinder)
            .disposed(by: disposeBag)
    }

    private var messageColorBinder: Binder<UIColor> {
        return Binder(self) { base, color in
            base.messageLabel.textColor = color
        }
    }
}
