//
//  Notifit.swift
//  Pods
//
//  Created by Tomas Sykora, jr. on 17/03/16.
//
//

import UIKit

public class Notifit: NSObject {
	/**
	Register device to NOTIFIT server
	
	- parameter projectToken:     NOTIFIT project token
	- parameter applicationToken: NOTIFIT application token
	*/
	public class func registerDeviceForProject(projectToken: String, forApplication applicationToken: String){
		NTFNetwork.api.registerDeviceForProject(projectToken, forApplication: applicationToken)
	}
	
	/**
	Sends notification token recieved from apple to NOTIFIT
	
	- parameter notificationToken: recieved notification token
	*/
	public class func updateNotificationToken(notificationToken: NSData){
		NTFNetwork.api.updateNotificationToken(notificationToken)
	}
	
	/**
	Records project token to NOTIFIT
	
	- parameter value: Value for your defined key lets say "info@notifit.io"
	- parameter key:   Your defined key forexample "loggedUserEmail"
	*/
	public class func setProjectValue(value: String, forKey key: String) {
		NTFNetwork.api.sendKeyValue(value, key: key)
	}
}
