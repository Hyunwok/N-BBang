//
//  AppComponent.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/19.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
