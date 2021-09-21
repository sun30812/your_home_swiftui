//
//  ContentView.swift
//  Your Home
//
//  Created by 이정민 on 2021/05/13.
//

import SwiftUI

extension String {
    func makeDate() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = self
        return formatter.string(from: now)
    }
}

struct DestinationPageView: View {
    var color: Color
    var name: String
    var body: some View {
        Text("Welcome to \(name) Page")
            .font(.title)
            .foregroundColor(color)
    }
}

struct SettingsPage: View {
    @State private var settings1: Bool = false
    var body: some View {
        List {
            Toggle("경고없이 삭제하기", isOn: $settings1)
        }
    }
}

struct TodoList : Identifiable {
    var id  = UUID()
    var title: String
    
    
}

struct MemoPage: View {
    var body: some View {
        Text("안녕!")
    }
    
}

struct ContentView: View {
    
    @State var name: String = ""
    
    @State var goSetting = false;
    @State var todoList = [TodoList(title: "할일 1")]
    

    func btnClick() {
        if (name == "/set") {
            goSetting.toggle()
        } else {
            todoList.append(TodoList(title: name))
        }
        name = ""
    }
    
    
    struct TodoListRow: View {
        @State var done = false
        func checkMark() -> Image {
            withAnimation{
                if (done) {
                    return Image(systemName: "checkmark.circle.fill")
                } else {
                    return Image(systemName: "checkmark.circle")
                }
            }
            
        }
        var list: TodoList
        var body: some View {
            HStack {
                Button(action: {done.toggle()}) {
                    checkMark()
                }
                Text(list.title)
                    .font(.title2)
                Spacer()
                Image(systemName: "trash")
                
            }
        }
    }
    
   
    var body: some View {
        NavigationView {
            TabView {
                VStack(alignment:.leading) {
                    
                    HStack {
                        TextField("여기에 할일 입력", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: btnClick) {
                            Image(systemName: "plus")
                        }
                        NavigationLink( destination: SettingsPage()) {
                            Image(systemName: "gearshape")
                        }
                    }
                    Text("M/dd".makeDate())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("오늘도 할일을 빨리 끝내봅시다!")
                        .font(.title)
                    List(todoList) { data in
                        TodoListRow(list: data)
                    }
                }.padding()
                .tabItem {
                    Image(systemName: "house")
                        .foregroundColor(.black)
                    
                }
                Text("이 기능은 지원하지 않습니다.")
                    .tabItem {
                        Image(systemName: "doc.append")
                    }
                Text("Your Home Swift UI포팅 버전")
                    .tabItem {
                        Image(systemName: "info.circle")
                    }
            }
            .navigationBarTitle("해야할 일", displayMode: .inline)
            .sheet(isPresented: $goSetting, content: {
                SettingsPage()
            })
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        SettingsPage()
    }
}
