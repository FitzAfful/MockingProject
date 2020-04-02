//
//  AuthNetworkManager.swift
//  RideAlong
//
//  Created by Paa Quesi Afful on 20/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import Alamofire
import Foundation
import Alamofire

public class BaseNetworkManager {
	
	public func getErrorMessage<T>(response: DataResponse<T>)->String where T: Codable {
		var message = NetworkingConstants.networkErrorMessage
		if let data = response.data {
			if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
				if let error = json["errors"] as? NSDictionary {
					message = error["message"] as! String
				}else if let error = json["error"] as? NSDictionary {
					if let message1 = error["message"] as? String {
						message = message1
					}
				}else if let messages = json["message"] as? String {
					message = messages
				}
			}
		}
		return message
	}
}

struct NetworkingConstants{
	static let spaceID = "kk2bw5ojx476"
	static let access_token = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
	static let baseUrl = "https://cdn.contentful.com/spaces/\(NetworkingConstants.spaceID)/environments/master/entries"
	static let networkErrorMessage = "Please check your internet connection and try again."
}


protocol APIConfiguration: URLRequestConvertible {
	var method: HTTPMethod { get }
	var path: String { get }
	var body: [String: Any] { get }
	var headers: HTTPHeaders { get }
	var parameters: [String: Any] { get }
}


enum NetworkError: LocalizedError {
	case responseStatusError(message: String)
}

extension NetworkError {
	var errorDescription: String {
		switch self {
		case let .responseStatusError(message):
			return "\(message)"
		}
	}
}
