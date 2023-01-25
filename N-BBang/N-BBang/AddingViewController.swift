//
//  AddingViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/27.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import RxCocoa

protocol AddingPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func detailImage()
    func editMoney()
    func camera()
    func library()
}

final class AddingViewController: UIViewController, AddingPresentable, AddingViewControllable {
    
    weak var listener: AddingPresentableListener?
    private let disposeBag = DisposeBag()
    private let calculates = BehaviorSubject(value: [Calculate.empty])
    private let imageView = UIImageView()
    
    private lazy var titleTxtField: UITextField = {
        let txtfield = UITextField()
        txtfield.placeholder = "\(Date())"
        txtfield.borderStyle = .roundedRect
        return txtfield
    }()
    
    private lazy var scrollview: UIScrollView = {
        let view  = UIScrollView()
        var asd = UIView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tbv = UITableView(frame: .zero, style: .insetGrouped)
        tbv.rowHeight = 150
        tbv.register(AddingTableViewCell.self, forCellReuseIdentifier: AddingTableViewCell.cellID)
        return tbv
    }()
    
    private lazy var calculateBtn: UIBarButtonItem = {
        let btn = UIButton()
        btn.setTitle("정산", for: .normal)
        let bar = UIBarButtonItem(customView: btn)
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = false
        self.title = "정산하기"
        layout()
        bind()
    }
    
    private func layout() {
        let inputView = UIView()
        self.view.addSubViews([scrollview])
        self.scrollview.addSubview(inputView)
        self.navigationItem.rightBarButtonItem = calculateBtn
        inputView.addSubViews([titleTxtField, tableView])
        inputView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        scrollview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        inputView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        titleTxtField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().inset(23)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(23)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleTxtField.snp.bottom)//.offset(50)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func bind() {
        calculates
            .bind(to: tableView.rx.items(cellIdentifier: AddingTableViewCell.cellID, cellType: AddingTableViewCell.self)) { [weak self] idx, calculate, cell in
                guard let self = self else { return }
                cell.captionBtn.rx.tap
                    .bind { [weak self] in
                        if calculate.recipe == nil {
                            Alert.showAlert(with: AddingAlert.camera)
                        } else {
                            self?.listener?.detailImage()
                        }
                    }.disposed(by: self.disposeBag)
                
                cell.editMoneyBtn.rx.tap
                    .bind { [weak self] in
                        self?.listener?.editMoney()
                    }.disposed(by: self.disposeBag)
                
                cell.moneyTxtField.rx.text
                    .map { $0 ?? "0" }
                    .bind { priceTxt in
                        var asd = calculate
                        let asdd = Int(priceTxt.isEmpty ? "0" : priceTxt)!
                        asd.price = asdd
                        //                        calculates.bind(onNext: asd)
                        //                        calculate.price = Int(priceTxt)
                    }.disposed(by: self.disposeBag)
                
                //                cell.participateTxtField.rx.text
                //                    .map { $0 ?? "" }
                //
                //                cell.placeTxtField.rx.text
                //                    .map { $0 ?? "" }
                
            }.disposed(by: disposeBag)
    }
    
    func selectedImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func present(_ viewController: RIBs.ViewControllable) {
        self.present(viewController.uiviewController, animated: true)
    }
}
