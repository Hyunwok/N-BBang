//
//  DetailImageViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/07.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol DetailImagePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func deleteImage()
}

final class DetailImageViewController: UIViewController, DetailImagePresentable, DetailImageViewControllable {

    private let disposeBag = DisposeBag()
    weak var listener: DetailImagePresentableListener?
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let closeBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        return btn
    }()
    
    private let deleteBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "trash.circle.fill"), for: .normal)
        return btn
    }()
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit DetailImageViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
    
    private func layout() {
        self.view.addSubViews([closeBtn, deleteBtn, imageView])
        
        closeBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(40)
        }
        
        deleteBtn.snp.makeConstraints {
            $0.centerY.equalTo(closeBtn)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(40)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func bind() {
        closeBtn.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }.disposed(by: disposeBag)
        
        deleteBtn.rx.tap
            .bind { [weak self] in
                self?.listener?.deleteImage()
                self?.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }
}
