import Authentication
import DesignSystem
import SwiftUI
import User
import Network

/// Simple login/sign-up flow that authenticates the user.
public struct OnboardingView: View {
    @State private var isSignUp = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var errorMessage: String?

    @Environment(\.modelContext) private var modelContext
    @Environment(\.tokenStore) private var tokenStore
    private let networkService: any NetworkService
    public init(
        networkService: any NetworkService
    ) {
        self.networkService = networkService
    }

    public var body: some View {
        VStack(spacing: 16) {
            if isSignUp {
                IconTextField(placeholder: "First Name", text: $firstName)
                IconTextField(placeholder: "Last Name", text: $lastName)
            }

            IconTextField(placeholder: "Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)

            Button(isSignUp ? "Sign Up" : "Login") {
                Task { await authenticate() }
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(phoneNumber.isEmpty || (isSignUp && (firstName.isEmpty || lastName.isEmpty)))

            Button(isSignUp ? "Already have an account? Login" : "Need an account? Sign Up") {
                isSignUp.toggle()
                errorMessage = nil
            }
            .buttonStyle(SecondaryButtonStyle())

            if let errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding(20)
    }

    private func authenticate() async {
        do {
            let repo = AuthenticationRepositoryLive(networkService: networkService, tokenStore: tokenStore)
            let userInfo: UserInfo
            if isSignUp {
                userInfo = try await repo.signUp(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
            } else {
                userInfo = try await repo.login(phoneNumber: phoneNumber)
            }

            let user = User(
                id: userInfo.userID,
                name: "\(userInfo.firstName) \(userInfo.lastName)",
                email: "",
                createdAt: Date(),
                resyAuthToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJleHAiOjE3NTExNDg0ODcsInVpZCI6MjAxNzU5NTQsImd0IjoiY29uc3VtZXIiLCJncyI6W10sImxhbmciOiJlbi11cyIsImV4dHJhIjp7Imd1ZXN0X2lkIjo4NDE2MjcwN319.AMZb1EK_GTMQcp-bv4NZXQQqGmapIZP7Ld_qdkx6LFMdL1CQUNTz3Idg388jMu-9QKKOUdMsdBUelq6-LEBhKfrtAF7_B0ZQ0WLUKvuwnuurGZKTsTs8-xVLQK6paC4wBOUkjxEVORGkyH8vTYiVW1kanQzs-7uSTGPb5a9yFn5KfCN-"
            )
            // Hard coded resy token above. In reality this probably should either not be on the user and be a separate flow where
            // there is like a ResyTokenStore that has .valid(lastUsedDate), .invalid, .none

            modelContext.insert(user)
        } catch {
            errorMessage = "Authentication failed"
        }
    }
}
