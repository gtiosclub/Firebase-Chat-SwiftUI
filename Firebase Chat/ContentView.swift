//
//  ContentView.swift
//  Firebase Chat
//
//  Created by Jai Chawla on 11/2/21.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    @State var messages: [Message] = []
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Message", text: self.$text)
                    
                    Button(action: {
                        self.send()
                    }, label: {
                        Text("Send")
                    })
                }
                .padding()
                
                List {
                    ForEach(messages) { message in
                        MessageListView(message: message)
                    }
                }
            }
            .navigationTitle("Firebase Chat")
            .onAppear {
                fetchMessages()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    func send() {
        let time = Date().timeIntervalSince1970
        Message(text: self.text, time: time).send()
        self.text = ""
    }
    
    func fetchMessages() {
        Message.observe { message in
            self.messages.insert(message, at: 0)
            self.messages.sort(by: { (m1, m2) -> Bool in
                return m1.time < m2.time
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
