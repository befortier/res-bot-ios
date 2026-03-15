import Authentication
import DesignSystem
import SwiftUI
import User
import NetworkKit

/// Simple login/sign-up flow that authenticates the user.
public struct OnboardingView: View {
    public typealias CompletionHandler = @MainActor (UserSession) -> Void
    @State private var isSignUp = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var errorMessage: String?

    @Environment(\.modelContext) private var modelContext
    private let networkService: any NetworkService
    private let completed: CompletionHandler

    public init(
        networkService: any NetworkService,
        completed: @escaping CompletionHandler
    ) {
        self.networkService = networkService
        self.completed = completed
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
                Task {
                    guard let userSession = await authenticate() else {
                        return
                    }
                    completed(userSession)
                }
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

    private func authenticate() async -> UserSession? {
        do {
            let repo = OnboardingRepositoryLive(
                networkService: networkService,
                tokenStore: TokenStoreFile()
            )
            let authResponse: AuthResponse
            if isSignUp {
                authResponse = try await repo.signUp(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
            } else {
                authResponse = try await repo.login(phoneNumber: phoneNumber)
            }

            let user = User(
                id: authResponse.user.userID,
                name: "\(authResponse.user.firstName) \(authResponse.user.lastName)",
                email: "",
                createdAt: Date(),
                resyAuthToken: .stubResyToken
            )
            // Hard coded resy token above. In reality this probably should either not be on the user and be a separate flow where
            // there is like a ResyTokenStore that has .valid(lastUsedDate), .invalid, .none

            modelContext.insert(user)
            return UserSession(
                user: user,
                token: .init(
                    token: authResponse.token,
                    refreshToken: authResponse.refreshToken
                )
            )
        } catch {
            errorMessage = "Authentication failed"
            return nil
        }
    }
}
