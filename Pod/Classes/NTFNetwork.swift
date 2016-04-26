//
//  NTFNetwork.swift
//  Pods
//
//  Created by Tomas Sykora, jr. on 17/03/16.
//
//

import UIKit
import Foundation

class NTFNetwork: NSObject {
	static let delegate = UIApplication.sharedApplication().delegate
	class var api: NTFNetwork {
		struct Static {
			static let instance: NTFNetwork = NTFNetwork()
		}
		return Static.instance
	}
	
	func updateNotificationToken(notificationToken: NSData?){
		addObservers()
		var parameters  = [
			NTFConstants.value.applicationToken : NTFDefaults.getApplicationToken(),
			NTFConstants.value.projectToken: NTFDefaults.getProjectToken()
			] as Dictionary<String, AnyObject>
		
		if notificationToken != nil {
			let characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
			let deviceTokenString: String = ( notificationToken!.description as NSString )
				.stringByTrimmingCharactersInSet( characterSet )
				.stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
			
			NTFLOG_I(deviceTokenString)
			parameters.updateValue(deviceTokenString, forKey: "NotificationToken")
		}
		
		parameters += self.gatherDeviceInformation()
		self.sendRequest(.PUT, url: NTFConstants.api.router.register, parameters: parameters)
	}
	
	func registerDeviceForProject(projectToken: String, forApplication applicationToken: String){
		addObservers()

		var parameters  = [
			"ProjectToken": projectToken,
			"ApplicationToken": applicationToken,
			"NotificationToken" : "Empty"
			] as Dictionary<String, AnyObject>
		
		parameters += self.gatherDeviceInformation()
		
		if let _ = NTFDefaults.getCommunicationToken() {
			self.sendRequest(.PUT, url: NTFConstants.api.router.register, parameters: parameters)
		}else{
			self.sendRequest(.POST, url: NTFConstants.api.router.register, parameters: parameters)
		}
	}
	
	private func addObservers(){
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NTFNetwork.didFinishLaunchingWithOptions), name: UIApplicationDidFinishLaunchingNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NTFNetwork.applicationWillResignActive), name: UIApplicationWillResignActiveNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NTFNetwork.applicationDidEnterBackground), name: UIApplicationDidEnterBackgroundNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NTFNetwork.applicationWillEnterForeground), name: UIApplicationWillEnterForegroundNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NTFNetwork.applicationDidBecomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
	}
	
	
	func sendNotificationToken(notificationToken: String, projectToken: String, applicationToken: String){
		
		
		var parameters  = [
			"NotificationToken" : notificationToken,
			"ProjectToken": projectToken,
			"ApplicationToken": applicationToken
			] as Dictionary<String, AnyObject>
		parameters += self.gatherDeviceInformation()
		
		
		if let _ = NTFDefaults.getCommunicationToken() {
			self.sendRequest(.PUT, url: NTFConstants.api.router.register, parameters: parameters)
		}else{
			self.sendRequest(.POST, url: NTFConstants.api.router.register, parameters: parameters)
		}
	}
	
	
	func sendKeyValue(value: String, key: String){
		let parameters = [
			"Value" : value,
			"Key" : key
		]
		
		self.sendRequest(.POST, url: NTFConstants.api.router.keyValue, parameters: parameters)
	}
	
	func updateDeviceInformation(){
		var parameters  = [
			NTFConstants.value.applicationToken : NTFDefaults.getApplicationToken(),
			NTFConstants.value.projectToken: NTFDefaults.getProjectToken()
			] as Dictionary<String, AnyObject>
		parameters += self.gatherDeviceInformation()
		debugPrint(parameters)
		self.sendRequest(.PUT, url: NTFConstants.api.router.register, parameters: parameters)
	}
	
	func logApplicationState(state: NTFAppState){
		let parameters = [
			NTFConstants.api.applicationState : state.rawValue
		]
		debugPrint(parameters)
		sendRequest(.POST, url: NTFConstants.api.router.logState ,parameters: parameters)
		
	}
	
	
	private func gatherDeviceInformation() -> Dictionary<String,AnyObject> {
		let device = UIDevice.currentDevice()
		return [
			"DeviceName":device.name,
			"DeviceSystemName" : device.systemName,
			"DeviceSystemVersion" : device.systemVersion,
			"DeviceModel" : device.model,
			"DeviceLocalizedModel" : device.localizedModel,
			"DeviceIdentifierForVendor" : device.identifierForVendor?.UUIDString ?? "",
			"DeviceTimeZone" : String(NSTimeZone.localTimeZone()),
			"DevicePreferedLanguage" : NSLocale.preferredLanguages().first ?? "",
			"DeviceCFBundleDisplayName" : (NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDisplayName") ?? "") as! String,
			"DeviceCFBundleShortVersionString" : (NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") ?? "") as! String,
			"DeviceCFBundleVersion" : (NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") ?? "") as! String,
			"DeviceBundleIdentifier" : NSBundle.mainBundle().bundleIdentifier ?? "",
			"DeviceDifferenceToGMT" : NSTimeZone.localTimeZone().secondsFromGMT / 3600
		]
	}
	
	private func sendRequest(method: NTFMethod, url: String, parameters: NSDictionary){
		do {
			NTFLOG_I("Method: \(method.rawValue), URL: \(url), parameters: \(parameters)")
			let jsonData = try NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
			let url = NSURL(string: url)!
			let request = NSMutableURLRequest(URL: url)
			request.HTTPMethod = method.rawValue
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
			if let token = NTFDefaults.getCommunicationToken() {
				NTFLOG_I("Comunication token: \(token)")
				request.setValue(NTFDefaults.getCommunicationToken()!, forHTTPHeaderField: NTFConstants.value.communicationToken)
			}
			
			request.HTTPBody = jsonData
			
			let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
				if let httpResponse = response as? NSHTTPURLResponse {
					
					if let url = httpResponse.URL?.absoluteString {
						NTFLOG_I("Status: \(httpResponse.statusCode) URL: \(url)")
						if httpResponse.statusCode != 200 {
							NTFDefaults.deleteCommunicationToken()
							self.registerDeviceForProject(NTFDefaults.getProjectToken(), forApplication: NTFDefaults.getApplicationToken())
						}
						if url == NTFConstants.api.router.register{
							do {
								if let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject] {
									if let communicationToken = result["CommunicationToken"] as? String{
										NTFDefaults.setCommunicationToken(communicationToken)
									}
								}
								
							} catch {
								NTFLOG_F(" \(error)")
							}
						}
					}
					
				}
				if error != nil{
					print("Error -> \(error)")
					return
				}
				
				
			}
			
			task.resume()
			
			
			
		} catch {
			print(error)
		}
	}
	
	//MARK: - Application State
	
	func didFinishLaunchingWithOptions(){
		logApplicationState(.LAUNCH)
	}
	
	func applicationWillResignActive() {
		logApplicationState(NTFAppState.RESIGNACTIVE)
	}
	
	func applicationDidEnterBackground() {
		logApplicationState(NTFAppState.ENTERBACKGROUND)
	}
	
	func applicationWillEnterForeground(){
		logApplicationState(NTFAppState.ENTERFOREGROUND)
	}
	
	func applicationDidBecomeActive() {
		logApplicationState(NTFAppState.BECOMEACTIVE)
	}
	
	func applicationWillTerminate(){
		logApplicationState(NTFAppState.TERMINATE)
	}
}

// MARK: - Helpers

func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
	for (k, v) in right {
		left.updateValue(v, forKey: k)
	}
}


func NTFLOG_S(format: String = "")
{
	debugPrint("NOTIFIT SUCCESS $ \(format)")
}

func NTFLOG_F(format: String = "")
{
	debugPrint("NOTIFIT FAILURE $ \(format)")
}

func NTFLOG_I(format: String = "")
{
	debugPrint("NOTIFIT INFO $ \(format)")
}