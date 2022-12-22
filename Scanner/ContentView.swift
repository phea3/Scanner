//
//  ContentView.swift
//  Scanner
//
//  Created by Luon Sokphea on 17/11/22.
//

import SwiftUI
import CodeScanner
import Foundation
import Apollo
import ActivityIndicatorView

struct ContentView: View {
    @StateObject var ScannerQR: ScanQRCodeViewModel = ScanQRCodeViewModel()
    @StateObject var attendant: CreateTeacherAttendanceViewModel = CreateTeacherAttendanceViewModel()
    @State private var isShowingScanner = false
    @State var scanCode: String?
    @State var error: Bool = false
    @State var success: Bool = false
    @State var scanSuccess: Bool = false
    @State var attendantSuccess: Bool = false
    @State private var timeRemaining = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
       
            VStack {
                if timeRemaining == 0 {
                    VStack{
                        Text(attendantSuccess ? "Teacher(គ្រូ)" : scanSuccess ? "Staff(បុគ្គលិក)" : "No Result(គ្មានលទ្ធផល)" )
                            .foregroundColor( attendantSuccess ? .blue : scanSuccess ? .green : .red)
                    }
                } else {
                    ActivityIndicatorView(isVisible: .constant(true), type: .arcs(count: 3, lineWidth: 2))
                         .frame(width: 20.0, height: 20.0)
                         .foregroundColor(.blue)
                }
                Button {
                    self.isShowingScanner = true
                    self.scanSuccess = false
                    self.attendantSuccess = false
                } label: {
                    VStack{
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150,height: 150)
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "sokphea", completion: handleScan)
                        .ignoresSafeArea()
                }
                .alert(isPresented: $success) {
                    Alert(
                        title:  Text("Success"),
                        message: Text("\(scanCode ?? "")"),
                        dismissButton: .default(Text("OK")){
                            ScannerQR.Scanner(StaffID: scanCode ?? "")
                            attendant.attendance(teacherCardId: scanCode ?? "")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.scanSuccess = ScannerQR.success
                                self.attendantSuccess = attendant.success
                            }
                            timeRemaining = 2
                        }
                    )
                }
                VStack{
                    EmptyView()
                }
                .alert(isPresented: $error) {
                    Alert(title: Text("Error"), message: Text("ម្តងទៀត"))
                }
            }
            .padding()
        
    }
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        // more code to come
        switch result {
        case .success(let result):
            DispatchQueue.main.async {
                self.scanCode = result.string
                self.success = true
            }
        case .failure(let error):
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.error = true
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Network1 {
    static let shared = Network1()
    
    let url1 = "https://employee-endpoint.go-globalschool.com/graphql"
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: url1)!)
    
}

class Network2 {
    static let shared = Network2()
    
    let url2 = "https://sms-endpoint.go-globalschool.com/graphql"
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: url2)!)
    
}

class ScanQRCodeViewModel: ObservableObject{
    @Published var success: Bool = false
    @Published var message: String = ""
    
    func Scanner(StaffID: String){
        Network1.shared.apollo.perform(mutation: QrCodeCheckAttendanceMutation(idCard: StaffID)){ [weak self] result in
            switch result{
            case .success(let graphQLResult):
                if let success = graphQLResult.data?.qrCodeCheckAttendance.status {
                    self?.success = success
                }
                if let message = graphQLResult.data?.qrCodeCheckAttendance.message {
                    self?.message = message
                }
            case .failure(let Error):
                print(Error)
            }
        }
    }
}

class CreateTeacherAttendanceViewModel: ObservableObject {
    @Published var success: Bool = false
    @Published var message: String = ""
    
    func attendance(teacherCardId: String){
        Network2.shared.apollo.perform(mutation: CreateTeacherAttendanceMutation(teacherCardId: teacherCardId, newData: TeacherAnntendanceInput(status: "PRESENT"))) { [weak self] result in
            switch result{
            case .success(let graphqlResult):
                if let success = graphqlResult.data?.createTeacherAttendance?.success {
                    DispatchQueue.main.async {
                        self?.success = success
                    }
                }
                if let message = graphqlResult.data?.createTeacherAttendance?.message {
                    DispatchQueue.main.async {
                        self?.message = message
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
