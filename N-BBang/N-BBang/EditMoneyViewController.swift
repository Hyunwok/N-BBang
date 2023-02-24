//
//  EditMoneyViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/30.
//

import RIBs
import RxSwift
import UIKit
import RxCocoa

protocol EditMoneyPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class EditMoneyViewController: UIViewController, EditMoneyPresentable, EditMoneyViewControllable {
    
    private var flag = false
    private var disposeBag = DisposeBag()
    weak var listener: EditMoneyPresentableListener?
    private let calculate: Calculate
    private lazy var tempCal = BehaviorRelay(value: calculate)
    
    private lazy var tableview: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(EditMoneyTableViewCell.self, forCellReuseIdentifier: EditMoneyTableViewCell.cellID)
        return view
    }()
    
    init(_ calculate: Calculate) {
        self.calculate = calculate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "금액 조정"
        self.navigationItem.rightBarButtonItems = [sasdetRightBarItem(), setRightBarItem()]
//        self.navigationItem.rightBarButtonItem = setRightBarItem()
        layout()
        bind()
    }
    
    private func layout() {
        self.view.addSubview(tableview)
        
        tableview.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.layoutMarginsGuide).offset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func bind() {
        tempCal.map { $0.members }
            .bind(to: tableview.rx.items(cellIdentifier: EditMoneyTableViewCell.cellID, cellType: EditMoneyTableViewCell.self)) { idx, member, cell in
                cell.setting(person: member)
                
                cell.priceField.rx.controlEvent([.editingDidEndOnExit])
                    .map { cell.priceField.text ?? "0" }
                    .bind {
                        self.flag = true
                        var cal = self.tempCal.value
                        cal.members[idx].isEdited = true
                        var memberCnt = cal.members.filter { !$0.isEdited }.count
                        
                        var leftMoney = cal.price - Int($0)!
                        
                        for i in 0..<cal.members.count {
                            if cal.members[i].uuid != cal.members[idx].uuid {
                                cal.members[i].loan = leftMoney / memberCnt
                            } else {
                                cal.members[i].loan = Int($0)!
                            }
                        }
                        
                        self.tempCal.accept(cal)
                        
                    }.disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
    }
    
    private func setRightBarItem() -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "goforward"), for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.tempCal.accept(self.calculate)
            }.disposed(by: disposeBag)
        return UIBarButtonItem(customView: btn)
    }
    
    private func sasdetRightBarItem() -> UIBarButtonItem {
        let btn = UIButton()
        btn.setTitle("done", for: .normal)
//        btn.setImage(UIImage(systemName: "goforward"), for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                print("ASDASDASD")
//                self.tempCal.accept(self.calculate)
            }.disposed(by: disposeBag)
        return UIBarButtonItem(customView: btn)
    }
    
    private func dismissAlert() {
        if flag {
//            뒤로가기 시 사라짐
        }
    }
}
