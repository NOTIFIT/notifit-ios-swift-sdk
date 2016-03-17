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
			static let baseURL = "http://notifit.io/api/"
			static let login = NTFConstants.api.router.baseURL + "Account/Login"
		}
	}
}
