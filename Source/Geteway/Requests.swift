//
//  Requests.swift
//  MovDB
//
//  Created by Dmytro Kozak on 12/10/20.
//

import Foundation

public extension ExtendedApiRequest {
    static func retriveMovie(_ subpath: String,
                                   page: Int) -> ExtendedApiRequest
    {
        let queries = [.apiKey,
                       .defaultL10n,
                       QueryField(key: "page", value: page.description)]
        
        return self.extendedRequest(path: subpath, method: .get, headers: [.acceptJson], queryArr: queries)
    }
    
    static func retriveDetail(_ id: String) -> ExtendedApiRequest
    {
        let queries = [QueryField.apiKey,
                       .defaultL10n]
        
        return self.extendedRequest(path: id, method: .get, headers: [.acceptJson], queryArr: queries)
    }

}
