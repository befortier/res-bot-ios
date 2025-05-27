//
//  ResyHeaderConfig+User
//  ResyPro
//
//  Created by Ben Fortier on 5/18/25.
//

import Network

extension HeaderConfiguration {
    public init(
        user: User,
        token: @escaping BearerToken
    ) {
        self.init(
            userID: user.id,
            bearerToken: token,
            resyAuthToken: user.resyAuthToken ?? "should-probably-fix-this"
        )
    }
}
