//
//  AuthEndpoints.swift
//  RideAlong
//
//  Created by Paa Quesi Afful on 20/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter : APIConfiguration {
	
	case getRecipes
	
	internal var method: HTTPMethod {
		switch self {
		case .getRecipes:
			return .get
		}
	}
	
	internal var path: String {
		switch self {
		default:
			return ""
		}
	}
	
	
	internal var parameters: [String : Any] {
		switch self {
		case .getRecipes:
			return ["access_token": NetworkingConstants.access_token, "content_type":Recipe.contentTypeId]
		}
	}
	
	
	
	internal var body: [String : Any] {
		switch self {
		default:
			return [:]
		}
	}
	
	
	
	internal var headers: HTTPHeaders {
		switch self {
		default:
			return ["Content-Type":"application/json", "Accept":"application/json"]
		}
	}
	
	
	
	func asURLRequest() throws -> URLRequest {
		var urlComponents = URLComponents(string: NetworkingConstants.baseUrl)!
		var queryItems:[URLQueryItem] = []
		for item in parameters {
			queryItems.append(URLQueryItem(name: item.key, value: "\(item.value)"))
		}
		if(!(queryItems.isEmpty)){
			urlComponents.queryItems = queryItems
		}
		let url = urlComponents.url!
		var urlRequest = URLRequest(url: url)
		
		
		urlRequest.httpMethod = method.rawValue
		urlRequest.allHTTPHeaderFields = headers.dictionary
		
		if(!(body.isEmpty)){
			urlRequest = try URLEncoding().encode(urlRequest, with: body)
			
			let jsonData1 = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
			urlRequest.httpBody = jsonData1
		}
		
		return urlRequest
		
	}
}


