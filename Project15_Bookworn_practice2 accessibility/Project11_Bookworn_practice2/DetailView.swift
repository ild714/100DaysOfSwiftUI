//
//  DetailView.swift
//  Project11_Bookworn_practice2
//
//  Created by Ильдар Нигметзянов on 23.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    let book: Book
    //let formatter = DateFormatter()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                ZStack(alignment: .bottomTrailing){
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "Fantasy")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(self.book.review ?? "No review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                
                Text(self.date(date: self.book.date ?? Date()))
                
                Spacer()
            }
        }
        .alert(isPresented: $showingDeleteAlert){
            Alert(title:Text("Delete book"),message: Text("Are you sure?"),primaryButton: .destructive(Text("Delete")){
                self.deleteBook()
                },secondaryButton: .cancel())
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action:{
            self.showingDeleteAlert = true
        }){
            Image(systemName: "trash")
        })
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    
    func date(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: date)
        return dateString
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView{
            DetailView(book:book)
        }
    }
}
