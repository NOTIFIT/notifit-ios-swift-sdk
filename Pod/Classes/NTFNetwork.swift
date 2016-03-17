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
	static let api = NTFNetwork()
	static let baseURL = "http://wics.ajty.cz/api/v1"
	
	func login(name: String, password: String){
		let parameters = [
			"username": "admin@admin.cz",
			"password": "Fekal123"
		]
		self.POST(parameters)
	}
	
	private func POST(parameters: NSDictionary){


		
		do {
			
			let jsonData = try NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
			let url = NSURL(string: NTFConstants.api.router.login)!
			let request = NSMutableURLRequest(URL: url)
			request.HTTPMethod = "POST"
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
			request.HTTPBody = jsonData
			
			let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
				if error != nil{
					print("Error -> \(error)")
					return
				}
				
				do {

					let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
					print("Result -> \(result)")
					
				} catch {
					NTFLOG_F(" \(error)")
				}
			}
			
			task.resume()
			
			
			
		} catch {
			print(error)
		}
	}
}

func NTFLOG_S(format: String = "", args:[CVarArgType] = [])
{
	debugPrint("NOTIFIT SUCCESS $ \(format)", getVaList(args))
}

func NTFLOG_F(format: String = "", args:[CVarArgType] = [])
{
	debugPrint("NOTIFIT FAILURE $ \(format)", getVaList(args))
}

func NTFLOG_I(format: String = "", args:[CVarArgType] = [])
{
	debugPrint("NOTIFIT INFO $ \(format)", getVaList(args))
}