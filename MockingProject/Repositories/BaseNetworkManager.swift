//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire

public class BaseNetworkManager {

	public func getErrorMessage<T>(response: DataResponse<T, AFError>) -> String where T: Codable {
		var message = NetworkingConstants.networkErrorMessage
		if let data = response.data {
			if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
				if let error = json["errors"] as? NSDictionary {
					message = error["message"] as! String
				} else if let error = json["error"] as? NSDictionary {
					if let message1 = error["message"] as? String {
						message = message1
					}
				} else if let messages = json["message"] as? String {
					message = messages
				}
			}
		}
		return message
	}
}

class DictionaryEncoder {
    private let jsonEncoder = JSONEncoder()

    /// Encodes given Encodable value into an array or dictionary
    func encode<T>(_ value: T) throws -> Any where T: Encodable {
        let jsonData = try jsonEncoder.encode(value)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
}

class DictionaryDecoder {
    private let jsonDecoder = JSONDecoder()

    /// Decodes given Decodable type from given array or dictionary
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}

extension Encodable {
    var dictionary: [String: Any] {
        var param: [String: Any] = [: ]
        do {
            let param1 = try DictionaryEncoder().encode(self)
            param = param1 as! [String: Any]
        } catch {
            print("Couldnt parse parameter")
        }
        return param
    }
}

struct NetworkingConstants {
	static let baseUrl = "http://dummy.restapiexample.com/api/v1/"
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
