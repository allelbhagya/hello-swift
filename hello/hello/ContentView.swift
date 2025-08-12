//
//  ContentView.swift
//  hello
//
//  Created by Bhagyalaxmi A on 12/08/25.
//

import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool
}

struct ContentView: View {
    @State private var todos: [TodoItem] = [
        TodoItem(title: "study swift", isDone: false),
        TodoItem(title: "first app hello", isDone: true)
    ]
    
    @State private var newTodo = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("hey bhagya :)")
                .font(.title2)
                .padding(.bottom)

            List {
                ForEach($todos) { $todo in
                    HStack {
                        Toggle("", isOn: $todo.isDone)
                            .toggleStyle(.checkbox) // macOS-specific style
                        Text(todo.title)
                            .strikethrough(todo.isDone, color: .gray)
                            .foregroundColor(todo.isDone ? .gray : .primary)
                    }
                }
                .onDelete { indexSet in
                    todos.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.inset)

            HStack {
                TextField("New task", text: $newTodo)
                Button("Add") {
                    guard !newTodo.isEmpty else { return }
                    todos.append(TodoItem(title: newTodo, isDone: false))
                    newTodo = ""
                }
            }
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
