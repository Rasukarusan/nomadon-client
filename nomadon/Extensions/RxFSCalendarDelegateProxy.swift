//
//  RxFSCalendarDelegateProxy.swift
//  nomadon
//
//  Created by tanaka naoto on 2019/08/11.
//  Copyright © 2019 tanaka.naoto. All rights reserved.
//

import RxSwift
import RxCocoa
import FSCalendar

public class RxFSCalendarDelegateProxy: DelegateProxy<FSCalendar,FSCalendarDelegate>, DelegateProxyType, FSCalendarDelegate {

    public init(fsCalendar: FSCalendar) {
        super.init(parentObject: fsCalendar, delegateProxy: RxFSCalendarDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { (fsCalendar) -> RxFSCalendarDelegateProxy in
            RxFSCalendarDelegateProxy(fsCalendar: fsCalendar)
        }
    }
    
    internal lazy var didSelect = PublishSubject<Date>()
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        _forwardToDelegate?.calendar(calendar, didDeselect: date, at: monthPosition)
        didSelect.onNext(date)
    }
    
    deinit {
        self.didSelect.on(.completed)
    }
    
    public static func currentDelegate(for object: FSCalendar) -> FSCalendarDelegate? {
        return object.delegate
    }

    public static func setCurrentDelegate(_ delegate: FSCalendarDelegate?, to object: FSCalendar) {
        object.delegate = delegate
    }
}

