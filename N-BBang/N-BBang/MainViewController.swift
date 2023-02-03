//
//  MainViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import UIKit

import RIBs
import RxSwift
import RxCocoa
import SnapKit

protocol MainPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func setting()
    func adding()
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {
    
    private let disposeBag = DisposeBag()
    weak var listener: MainPresentableListener?
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        lbl.text = "더치페이"
        return lbl
    }()
    
    private lazy var settingBtn: UIButton = {
        let btn = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "gearshape.fill", withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate)
        btn.tintColor = .black
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    private lazy var segControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["전체", "미완료", "완료"])
        segControl.selectedSegmentIndex = 0
        return segControl
    }()
    
    private lazy var tableView: UITableView = {
        let tbv = UITableView(frame: .zero, style: .insetGrouped)
        tbv.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellID)
        return tbv
    }()
    
    private lazy var plusBtn: UIButton = {
        let btn = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let image = UIImage(systemName: "plus", withConfiguration: imageConfig)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .red
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        layout()
        bind()
    }
    
    func layout() {
        self.view.addSubViews([titleLabel, settingBtn, segControl, tableView, plusBtn])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().inset(23)
        }
        
        settingBtn.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(23)
            $0.width.height.equalTo(40)
        }
        
        segControl.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(segControl.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        plusBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(23)
            $0.bottom.equalToSuperview().inset(23)
            $0.width.height.equalTo(50)
        }
    }
    
    private func bind() {
        settingBtn.rx.tap
            .bind { [weak self] in
                self?.listener?.setting()
            }.disposed(by: disposeBag)
        
        plusBtn.rx.tap
            .bind { [weak self] in
                self?.listener?.adding()
            }.disposed(by: disposeBag)
    }
    
    func push(_ viewcontrollerable: ViewControllable) {
        let vc = viewcontrollerable.uiviewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ContactViewControllable
extension MainViewController: ContactViewControllable { }
