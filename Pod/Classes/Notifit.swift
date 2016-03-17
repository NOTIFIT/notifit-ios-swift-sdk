//
//  Notifit.swift
//  Pods
//
//  Created by Tomas Sykora, jr. on 17/03/16.
//
//

import UIKit

class Notifit: NSObject {
	class func loginWithName(name: String, password: String){
		NTFNetwork.api.login(name, password: password)
	}
	
}
