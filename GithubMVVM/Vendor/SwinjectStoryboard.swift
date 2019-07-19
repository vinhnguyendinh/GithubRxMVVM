//
//  SwinjectStoryboard.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup () {
        Container.loggingFunction = nil
        
        defaultContainer.register(RepoServiceProtocol.self, factory: { _ in return RepoService() })
        defaultContainer.register(EventServiceProtocol.self, factory: { _ in return EventService() })
    }
}
