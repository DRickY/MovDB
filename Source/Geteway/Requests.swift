//
//  Requests.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public extension ExtendedApiRequest {
    static func retrive(category: String,
                                   page: Int) -> ExtendedApiRequest
    {
        let queries = [.apiKey,
                       .defaultL10n,
                       QueryField(key: "page", value: page.description)]
        
        return self.extendedRequest(path: category, method: .get, headers: [.acceptJson], queryArr: queries)
    }
}
