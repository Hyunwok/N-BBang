//
//  ParticipateViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/08.
//

import RIBs
import RxSwift
import UIKit
import RxCocoa
import WSTagsFieldPrivate
import ContactsUI

protocol ParticipatePresentableListener: AnyObject {
    func initContact()
    func done(contacts: [Person])
}

final class ParticipateViewController: UIViewController, ParticipatePresentable, ParticipateViewControllable {
    
    private let disposeBag = DisposeBag()
    weak var listener: ParticipatePresentableListener?
    private var contactsRelay = BehaviorRelay(value: [Person]())
    private var contacts: [Person] = []
    
    private lazy var searchField: WSTagsField = {
        let field = WSTagsField()
        field.spaceBetweenLines = 5.0
        field.spaceBetweenTags = 10.0
        field.font = .systemFont(ofSize: 12.0)
        field.backgroundColor = .white
        field.tintColor = .green
        field.textColor = .black
        field.fieldTextColor = .blue
        field.selectedColor = .black
        field.selectedTextColor = .red
//        field.isDelimiterVisible = true
        field.placeholderColor = .green
        field.placeholderAlwaysVisible = true
        field.keyboardAppearance = .dark
        field.returnKeyType = .next
        //        field.acceptTagOption = .space
        //        field.shouldTokenizeAfterResigningFirstResponder = true
        //        field.textField.isUserInteractionEnabled = false
        field.placeholder = "연락처 입력 또는 검색"
        return field
    }()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        return btn
    }()
    
    private lazy var doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Done", for: .normal)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.rowHeight = 50
        view.register(ParticipateTableViewCell.self, forCellReuseIdentifier: ParticipateTableViewCell.cellID)
        return view
    }()
    
    init(people: [String]) {
        super.init(nibName: nil, bundle: nil)
        searchField.addTags(people)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit ParticipateViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = false
        listener?.initContact()
        layout()
        bind()
    }
    
    private func layout() {
        self.view.addSubViews([closeBtn, doneBtn, searchField, tableView])
        
        closeBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(40)
        }
        
        doneBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(40)
        }
        
        searchField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(closeBtn.snp.bottom).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(searchField.snp.bottom).offset(10)
        }
    }
    
    private func bind() {
        closeBtn.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }.disposed(by: disposeBag)
        
        searchField.textField.rx.text
            .map { $0 ?? "" }
            .skipWhile { $0 == "" }
            .map { [weak self] text in
                let isChosungCheck = self?.isChosung(word: text) ?? false
                return self?.contacts.filter ({ person in
                    if isChosungCheck {
                        return (person.name.contains(text) || self?.chosungCheck(word: person.name).contains(text) ?? false)
                    } else {
                        return person.name.contains(text)
                    }
                }) ?? []
            }.bind(to: contactsRelay)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Person.self)
            .bind { [weak self] in
                self?.searchField.addTag("\($0.name)")
                self?.searchField.text = ""
            }.disposed(by: disposeBag)
        
        contactsRelay
            .bind(to: tableView.rx.items(cellIdentifier: ParticipateTableViewCell.cellID, cellType: ParticipateTableViewCell.self)) { a, b, c in
                c.bind(with: b)
            }.disposed(by: disposeBag)
        
        doneBtn.rx.tap
            .bind { [weak self] in
                let contacts = self?.searchField.tags ?? []
                let persons = contacts.map { Person(name: $0.text, loan: 0, isPaid: false) }
                self?.listener?.done(contacts: persons)
                self?.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }
    
    func contacts(with: [Person]) {
        contacts = with
        contactsRelay.accept(with)
    }
    
    let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
    /// 1. 초성분리해주는 함수
    /// - Parameter word: 검색어
    /// - Returns: 초성분리된 결과
    func chosungCheck(word: String) -> String {
        var result = ""
        /*
         참고 : https://hongssup.tistory.com/130
         유니코드에서 한글 분리
         
         유니코드에서 한글은 0xAC00에서 0xD7A3 사이의 코드 값을 갖는다. 각 16진수 값은 10진수로 표시하면 44032와 55203으로 총 11,172개. 유니코드 내 한글은 초/중/종성의 조합으로 표현되며, 초성 19개, 중성 21개, 종성 28개를 조합하여 하나의 글자가 된다.
         초성 = ((문자코드 - 0xAC00) / 28) / 21
         중성 = ((문자코드 - 0xAC00) / 28 % 21
         종성 = (문자코드 - 0xAC00) % 28
         */
        
        /*
         부하예상되는 부분으로 초성 검색해야하는 (갯수 * 각 글자수) 만큼 for 문이 진행될텐데
         몇개 없을때는 괜찮겠지만, 1000개, 10000개 되었을때 이슈가 생기지 않을까..?
         애플 주소록도 첫번째 문자가 초성일때만 초성검색 하고 두개이상일때는 초성검색 하고 있지 않음.
         띄어쓰기 이슈, 특수문자 이슈 (한글유니코드값 범위 예외 추가함)
         */
        
        // 문자열하나씩 짤라서 확인
        for char in word {
            let octal = char.unicodeScalars[char.unicodeScalars.startIndex].value
            if 44032...55203 ~= octal { // 유니코드가 한글값 일때만 분리작업
                let index = (octal - 0xac00) / 28 / 21
                result = result + hangul[Int(index)]
            }
        }
        
        return result
    }
    
    /// 2. 현재 문자열이 초성으로만 이뤄졌는지
    /// - Parameter word: 검색어
    /// - Returns: Bool
    func isChosung(word: String) -> Bool {
        // 해당 문자열이 초성으로 이뤄져있는지 확인하기.
        var isChosung = false
        for char in word {
            // 검색하는 문자열전체가 초성인지 확인하기
            if 0 < hangul.filter({ $0.contains(char)}).count {
                isChosung = true
            } else {
                // 초성이 아닌 문자섞이면 false 끝.
                isChosung = false
                break
            }
        }
        return isChosung
    }
}

extension ParticipateViewController: ContactViewControllable {} 
