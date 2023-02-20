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
import RxDataSources
import WSTagsFieldPrivate

protocol AddingPresentableListener: AnyObject {
    func detailImage(_ image: UIImage)
    func editMoney(_ calculate: Calculate)
    func camera()
    func library()
    func addParticipate(before: [String])
}

final class AddingViewController: UIViewController, AddingPresentable, AddingViewControllable {
    
    private var cellCnt = 2
    weak var listener: AddingPresentableListener?
    private let disposeBag = DisposeBag()
    private var imageIdx = 0
    private var reasd = Recipe.empty
    private var calculates = BehaviorRelay(value: [Calculate.empty, Calculate.empty])
    private var recipe = BehaviorRelay(value: Recipe.empty)
    
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
        let tbv = UITableView(frame: .zero, style: .plain)
        tbv.rowHeight = 150
        tbv.register(AddingTableViewCell.self, forCellReuseIdentifier: AddingTableViewCell.cellID)
        tbv.register(AddCalculateCell.self, forCellReuseIdentifier: AddCalculateCell.cellID)
        return tbv
    }()
    
    private lazy var calculateBtn: UIBarButtonItem = {
        let btn = UIButton()
        btn.setTitle("정산", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        let bar = UIBarButtonItem(customView: btn)
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = false
        self.title = "정산하기"
        self.navigationItem.rightBarButtonItem = setRightBarItem()
        layout()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func layout() {
        let inputView = UIView()
        self.view.addSubViews([scrollview])
        self.scrollview.addSubview(inputView)
        inputView.addSubViews([titleTxtField, tableView])
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
            $0.top.equalTo(titleTxtField.snp.bottom)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func bind() {
        //        let recipeImp = BehaviorRelay(value: Recipe.empty)
        //        let dataSource = RxTableViewSectionedReloadDataSource<Recipe> { dataSource, tableView, indexPath, item in
        //            let idx = indexPath.item
        //            //            if idx == indexPath.last {
        //            //                let cell = tableView.dequeueReusableCell(withIdentifier: AddCalculateCell.cellID, for: indexPath) as! AddCalculateCell
        //            //                return cell
        //            //            } else {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: AddingTableViewCell.cellID, for: indexPath) as! AddingTableViewCell
        //            cell.captionBtn.rx.tap
        //                .bind { [weak self] in
        //                    self?.imageIdx = idx
        //                    guard let image = item.recipe else { return Alert.showAlert(with: AddingAlert.camera) }
        //                    self?.listener?.detailImage(image)
        //                }.disposed(by: cell.disposeBag)
        //
        //            cell.editMoneyBtn.rx.tap
        //                .bind { [weak self] in
        //                    print(item)
        //                    self?.listener?.editMoney(item)
        //                }.disposed(by: cell.disposeBag)
        //
        //            let isTagEmpty = Observable.of(cell.tagView.tags.isEmpty)
        //            Observable.combineLatest(isTagEmpty, cell.moneyTxtField.rx.text.map { $0 ?? ""})
        //                .map { !($0.0 || $0.1 == "") }
        //                .bind(to: cell.editMoneyBtn.rx.isEnabled)
        //                .disposed(by: cell.disposeBag)
        //
        //            cell.moneyTxtField.rx.text
        //                .skip(1)
        //                .map { $0 ?? "0" }
        //                .map { $0.isEmpty ? "0" : $0 }
        //                .map { Int($0)! }
        //                .withLatestFrom(self.calculates) { (money: $0, calculates: $1) }
        //                .bind { [weak self] data in
        //                    var calcu = data.calculates
        //                    calcu[idx].price = data.money
        //                    self?.calculates.accept(calcu)
        //                }.disposed(by: cell.disposeBag)
        //
        //            let tabGesture = UITapGestureRecognizer()
        //            cell.tagView.addGestureRecognizer(tabGesture)
        //
        //            tabGesture.rx.event.bind { [weak self] _ in
        //                self?.imageIdx = idx
        //                let contacts = cell.tagView.tags.map { $0.text }
        //                self?.listener?.addParticipate(before: contacts)
        //            }.disposed(by: cell.disposeBag)
        //
        //            cell.placeTxtField.rx.text
        //                .skip(1)
        //                .map { $0 ?? "" }
        //                .withLatestFrom(self.calculates) { (place: $0, calculates: $1) }
        //                .bind { [weak self] data in
        //                    var calcu = data.calculates
        //                    calcu[idx].place = data.place
        //                    self?.calculates.accept(calcu)
        //                }.disposed(by: cell.disposeBag)
        //
        //            return cell
        //        }
        
        recipe.map { $0.calculates }
            .bind(to: tableView.rx.items) { [weak self] (tableView, idx, calculate) -> UITableViewCell in
                guard let self = self else { return UITableViewCell() }
                let indexPath = IndexPath(row: idx, section: 0)
                if self.cellCnt == idx + 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddCalculateCell.cellID, for: indexPath) as! AddCalculateCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AddingTableViewCell.cellID, for: indexPath) as! AddingTableViewCell
                    cell.captionBtn.rx.tap
                        .bind { [weak self] in
                            self?.imageIdx = idx
                            guard let image = calculate.recipe else { return Alert.showAlert(with: AddingAlert.camera) }
                            self?.listener?.detailImage(image)
                        }.disposed(by: cell.disposeBag)
                    
                    cell.editMoneyBtn.rx.tap
                        .withLatestFrom(self.calculates)
                        .filter { !($0[idx].members.isEmpty || (cell.moneyTxtField.text == "" || cell.moneyTxtField.text == nil)) }
                        .bind { [weak self] in
                            self?.listener?.editMoney($0[idx])
                        }.disposed(by: cell.disposeBag)
                    
                    cell.placeTxtField.rx.text
                        .skip(1)
                        .map { $0 ?? "" }
                        .withLatestFrom(self.calculates) { (place: $0, calculates: $1) }
                        .bind { [weak self] data in
                            var calcu = data.calculates
                            calcu[idx].place = data.place
                            self?.calculates.accept(calcu)
                        }.disposed(by: cell.disposeBag)
                    
                    cell.moneyTxtField.rx.text
                        .skip(1)
                        .map { $0 ?? "0" }
                        .map { $0.isEmpty ? "0" : $0 }
                        .map { Int($0)! }
                        .withLatestFrom(self.calculates) { (money: $0, calculates: $1) }
                        .bind { [weak self] data in
                            var calcu = data.calculates
                            calcu[idx].price = data.money
                            self?.calculates.accept(calcu)
                        }.disposed(by: cell.disposeBag)
                    
                    let tabGesture = UITapGestureRecognizer()
                    cell.tagView.addGestureRecognizer(tabGesture)
                    
                    tabGesture.rx.event.bind { [weak self] _ in
                        self?.imageIdx = idx
                        let contacts = cell.tagView.tags.map { $0.text }
                        self?.listener?.addParticipate(before: contacts)
                    }.disposed(by: cell.disposeBag)
                    
                    cell.tagView.onDidRemoveTag = { [weak self] _, tag in
                        var cal = self?.calculates.value ?? []
                        cal[idx].members.removeAll(where: { pre in
                            pre.name == tag.text
                        })
                        self?.calculates.accept(cal)
                    }
                    return cell
                }
            }.disposed(by: disposeBag)
        
        titleTxtField.rx.text
            .map { $0 ?? "" }
            .withLatestFrom(recipe) { (text: $0, recipe: $1) }
            .map { a -> Recipe in
                var new = a.recipe
                new.title = a.text
                return new
            }
            .bind(to: recipe)
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func selectedImage(_ image: UIImage?) {
        var newCal = calculates.value
        newCal[self.imageIdx].recipe = image
        calculates.accept(newCal)
    }
    
    func deleteImage() {
        var newCal = calculates.value
        newCal[self.imageIdx].recipe = nil
        calculates.accept(newCal)
    }
    
    func done(with contacts: [Person]) {
        if let cell = tableView.cellForRow(at: IndexPath(item: imageIdx, section: 0)) as? AddingTableViewCell {
            cell.tagView.removeTags()
            cell.tagView.addTags(contacts.map { $0.name })
            var cal = calculates.value
            cal[imageIdx].members = contacts
            calculates.accept(cal)
        }
    }
    
    func present(_ viewController: ViewControllable, _ style: UIModalPresentationStyle) {
        let vc = viewController.uiviewController
        vc.modalPresentationStyle = style
        self.present(vc, animated: true)
    }
    
    func push(_ viewController: RIBs.ViewControllable) {
        self.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
    
    private func setRightBarItem() -> UIBarButtonItem {
        let btn = UIButton()
        btn.setTitle("정산", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.rx.tap
            .withLatestFrom(recipe)
            .withLatestFrom(calculates) { (recipe: $0, calculates: $1) }
            .bind { data in
                var newdata = data.recipe
                newdata.calculates = data.calculates
                self.recipe.accept(newdata)
                print(data.calculates)
                               print("newdata", newdata)
            }.disposed(by: disposeBag)
        return UIBarButtonItem(customView: btn)
    }
}

extension AddingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.text = String(section + 1) + "차"
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        return view
    }
}
