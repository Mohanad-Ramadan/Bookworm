//
//  DetailView.swift
//  Bookworm
//
//  Created by Mohanad Ramdan on 20/08/2023.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book : Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottom){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                HStack {
                        
                    Text("\(book.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A")")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: 5, y: -5)
                    Spacer()
                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
            }
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "No review")
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .alert("Delete Book:", isPresented: $showingDeleteAlert, actions:{
            Button("Delete", role: .destructive, action: deleteBook);
            Button("Cancel", role: .cancel) { }
        },message: {
            Text("Are you sure?")
        })
    }
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}

