//
//  NTFConstants.swift
//  Pods
//
//  Created by Tomas Sykora, jr. on 17/03/16.
//
//

import UIKit
import Foundation

struct NTFConstants {
	struct api {
		struct router {
            static let baseURL  = "http://notifit.io/api/"
            static let register = NTFConstants.api.router.baseURL + "DeviceApple"
            static let logState = NTFConstants.api.router.baseURL + "ApplicationState"
            static let keyValue = NTFConstants.api.router.baseURL + "KeyValues"
		}
		static let applicationState = "state"
	}
	
	struct value {
        static let communicationToken = "Communication-Token"
        static let projectToken       = "ProjectToken"
        static let applicationToken   = "ApplicationToken"
	}
	
	struct state {
        static let launch          = "Launch"
        static let resignActive    = "ResignActive"
        static let enterBackground = "EnterBackground"
        static let enterForeground = "EnterForeground"
        static let becomeActive    = "BecomeActive"
        static let terminate       = "Terminate"
	}
}

enum NTFMethod: String {
	case POST = "POST"
	case PUT = "PUT"
}

enum NTFAppState: String {
	case LAUNCH          = "Launch"
	case RESIGNACTIVE    = "ResignActive"
	case ENTERBACKGROUND = "EnterBackground"
	case ENTERFOREGROUND = "EnterForeground"
	case BECOMEACTIVE    = "BecomeActive"
	case TERMINATE       = "Terminate"
}