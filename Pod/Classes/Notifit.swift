//
//  Notifit.swift
//  Pods
//
//  Created by Tomas Sykora, jr. on 17/03/16.
//
//

import UIKit

public class Notifit: NSObject {
	public class func loginWithName(name: String, password: String){
		NTFNetwork.api.login(name, password: password)
	}
	
}
