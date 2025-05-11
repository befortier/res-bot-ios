//
//  ResyBaseHeaderProvider.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

public enum HeaderProvider {
    public static func commonHeaders(authToken: String? = nil) -> [String: String] {
        var headers = [
            "authority": "api.resy.com",
            "accept": "application/json, text/plain, */*",
            "accept-language": "en-US,en;q=0.9,la;q=0.8",
            "authorization": "ResyAPI api_key=\"VbWk7s3L4KiK5fzlO7JD3Q5EYolJI7n5\"",
            "cache-control": "no-cache",
            "origin": "https://resy.com",
            "referer": "https://resy.com/",
            "sec-ch-ua": "\"Chromium\";v=\"118\", \"Google Chrome\";v=\"118\", \"Not=A?Brand\";v=\"99\"",
            "sec-ch-ua-mobile": "?0",
            "sec-ch-ua-platform": "\"macOS\"",
            "sec-fetch-dest": "empty",
            "sec-fetch-mode": "cors",
            "sec-fetch-site": "same-site",
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36",
            "x-origin": "https://resy.com"
        ]

        if let token = authToken {
            headers["x-resy-auth-token"] = token
            headers["x-resy-universal-auth"] = token
        }

        return headers
    }
}
