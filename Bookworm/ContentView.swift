//
//  ContentView.swift
//  Bookworm
//
//  Created by Mohanad Ramdan on 18/08/2023.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(books) { book in
                        NavigationLink {
                            DetailView(book: book)
                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                        .font(.largeTitle)
                                VStack(alignment: .leading) {
                                    switch book.rating {
                                    case 1:Text(book.title ?? "Unknown Title")
                                            .font(.headline)
                                            .foregroundColor(.red)
                                    case 2:Text(book.title ?? "Unknown Title")
                                            .font(.headline)
                                            .foregroundColor(.mint)
                                    case 3:Text(book.title ?? "Unknown Title")
                                            .font(.headline)
                                            .foregroundColor(.blue)
                                    case 4:Text(book.title ?? "Unknown Title")
                                            .font(.headline)
                                            .foregroundColor(.purple)
                                    default:
                                        Text(book.title ?? "Unknown Title")
                                            .font(.headline)
                                            .foregroundColor(.orange)
                                    }
                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("created on: \(book.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A") ")
                                    .font(.callout)
                                    .fontWeight(.thin)
                                    .foregroundColor(.gray)
                                    .padding(.leading)
                                    .padding(.top)
                            }
                        }
                    }
                .onDelete(perform: deleteItems)
//                .onMove(perform: moveItems)
            }
            .navigationTitle("Bookworm")
            .navigationBarItems(
                leading:
                    EditButton(),
                trailing:
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
            )
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
       }
    }
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { books[$0] }.forEach(moc.delete)
        try? moc.save()
    }
//    func moveItems(from: IndexSet, to: Int) {
//        books.move(fromOffsets: from, toOffset: to)
//        try? moc.save()
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
