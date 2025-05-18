//
//  ResyHeaderConfig+User
//  ResyPro
//
//  Created by Ben Fortier on 5/18/25.
//

import Network

extension ResyHeaderConfiguration {
    public init(user: User) {
        self.init(
            userID: user.id,
            bearerToken: "some-token",
            resyAuthToken: user.resyAuthToken
        )
    }
}
