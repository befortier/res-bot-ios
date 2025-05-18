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
                createdAt: Date()
            )

            modelContext.insert(user)
        } catch {
            errorMessage = "Authentication failed"
        }
    }
}
