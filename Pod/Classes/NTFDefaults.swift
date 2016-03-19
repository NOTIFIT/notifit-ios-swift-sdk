//
//  NTFDefaults.swift
//  Pods
//
//  Created by Tomas Sykora, jr. on 19/03/16.
//
//

import UIKit

class NTFDefaults: NSObject {

	class func setCommunicationToken(token: String){
		NSUserDefaults.standardUserDefaults().setObject(token, forKey: NTFConstants.value.communicationToken)
		NSUserDefaults.standardUserDefaults().synchronize()
	}
	
	class func getCommunicationToken() -> String?{
		return NSUserDefaults.standardUserDefaults().objectForKey(NTFConstants.value.communicationToken) as? String
	}
	
	class func deleteCommunicationToken(){
		NSUserDefaults.standardUserDefaults().removeObjectForKey(NTFConstants.value.communicationToken)
		NSUserDefaults.standardUserDefaults().synchronize()
	}
	
	class func setApplicationToken(token: String){
		NSUserDefaults.standardUserDefaults().setObject(token, forKey: NTFConstants.value.applicationToken)
		NSUserDefaults.standardUserDefaults().synchronize()
	}
	
	class func getApplicationToken() -> String{
		return String(NSUserDefaults.standardUserDefaults().objectForKey(NTFConstants.value.applicationToken))
	}
	
	class func setProjectToken(token: String){
		NSUserDefaults.standardUserDefaults().setObject(token, forKey: NTFConstants.value.projectToken)
		NSUserDefaults.standardUserDefaults().synchronize()
	}
	
	class func getProjectToken() -> String{
		return String(NSUserDefaults.standardUserDefaults().objectForKey(NTFConstants.value.projectToken))
	}
}
