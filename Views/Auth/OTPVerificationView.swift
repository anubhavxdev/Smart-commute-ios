import SwiftUI

struct OTPVerificationView: View {
    @Binding var isVerified: Bool
    let phoneNumber: String
    
    @State private var otpDigits: [String] = ["", "", "", "", "", ""]
    @FocusState private var focusedIndex: Int?
    @State private var timeRemaining = 30
    @State private var canResend = false
    @State private var isVerifying = false
    @State private var showError = false
    @State private var timer: Timer?
    
    let brandYellow = Color.brand
    
    var body: some View {
        ZStack {
            brandYellow.ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.black)
                    
                    Text("Verify Phone")
                        .font(.system(size: 28, weight: .black))
                        .foregroundColor(.black)
                }
                .padding(.top, 60)
                
                Spacer()
                
                // OTP Card
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text("Enter the 6-digit code sent to")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(phoneNumber)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    // OTP Fields
                    HStack(spacing: 10) {
                        ForEach(0..<6, id: \.self) { index in
                            OTPDigitField(
                                digit: $otpDigits[index],
                                isFocused: focusedIndex == index
                            )
                            .focused($focusedIndex, equals: index)
                            .onChange(of: otpDigits[index]) { _, newValue in
                                if newValue.count == 1 && index < 5 {
                                    focusedIndex = index + 1
                                } else if newValue.isEmpty && index > 0 {
                                    focusedIndex = index - 1
                                }
                                
                                // Auto-verify when all digits entered
                                if otpDigits.allSatisfy({ !$0.isEmpty }) {
                                    verifyOTP()
                                }
                            }
                        }
                    }
                    
                    if showError {
                        Text("Invalid OTP. Please try again.")
                            .font(.caption)
                            .foregroundColor(.red)
                            .transition(.opacity)
                    }
                    
                    // Resend timer
                    if canResend {
                        Button(action: resendOTP) {
                            Text("Resend OTP")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(brandYellow)
                                .cornerRadius(10)
                        }
                    } else {
                        HStack(spacing: 4) {
                            Text("Resend OTP in")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(timeRemaining)s")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    
                    // Verify Button
                    Button(action: verifyOTP) {
                        HStack {
                            if isVerifying {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: brandYellow))
                            } else {
                                Text("Verify & Continue")
                                    .fontWeight(.bold)
                            }
                        }
                        .foregroundColor(brandYellow)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                    }
                    .disabled(otpDigits.contains("") || isVerifying)
                    .opacity(otpDigits.contains("") ? 0.6 : 1)
                    
                    // Change number
                    Button(action: {
                        withAnimation { isVerified = false }
                    }) {
                        Text("Change phone number")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(30)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -5)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .onAppear {
            focusedIndex = 0
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func startTimer() {
        timeRemaining = 30
        canResend = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                canResend = true
                timer?.invalidate()
            }
        }
    }
    
    func resendOTP() {
        otpDigits = ["", "", "", "", "", ""]
        showError = false
        focusedIndex = 0
        startTimer()
    }
    
    func verifyOTP() {
        isVerifying = true
        showError = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isVerifying = false
            // Accept any 6-digit code for demo
            let code = otpDigits.joined()
            if code.count == 6 {
                withAnimation(.spring()) { isVerified = true }
            } else {
                withAnimation { showError = true }
            }
        }
    }
}

struct OTPDigitField: View {
    @Binding var digit: String
    let isFocused: Bool
    let brandYellow = Color.brand
    
    var body: some View {
        TextField("", text: $digit)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.title2)
            .fontWeight(.bold)
            .frame(width: 48, height: 56)
            .background(Color.gray.opacity(0.08))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? brandYellow : Color.clear, lineWidth: 2)
            )
            .onChange(of: digit) { _, newValue in
                if newValue.count > 1 {
                    digit = String(newValue.suffix(1))
                }
            }
    }
}
