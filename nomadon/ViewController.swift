//
//  ViewController.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/07.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var text1: UITextField!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        text1.rx.text.orEmpty
            .map {$0.description}
            .bind(to: label1.rx.text)
            .disposed(by: disposeBag)
    }


}

