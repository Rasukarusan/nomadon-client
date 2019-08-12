//
//  FSCalendar+Rx.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/11.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//
import RxSwift
import RxCocoa
import FSCalendar

extension Reactive where Base: FSCalendar {
    var delegate: DelegateProxy<FSCalendar, FSCalendarDelegate> {
        return RxFSCalendarDelegateProxy.proxy(for: base)
    }
    public var didSelect: Observable<Date> {
        return RxFSCalendarDelegateProxy.proxy(for: base).didSelect.asObservable()
    }
}
