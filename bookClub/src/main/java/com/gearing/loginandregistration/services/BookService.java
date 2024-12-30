package com.gearing.loginandregistration.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gearing.loginandregistration.models.Book;
import com.gearing.loginandregistration.repositories.BookRepository;

@Service
public class BookService {
	@Autowired
	private BookRepository bookRepo;
	
	// CRUD - retrieve all books
		public List<Book> allBooks() {
			return bookRepo.findAll();
		}
		
		// CRUD - create new book
		public Book createBook(Book book) {
			return bookRepo.save(book);
		}
		
		// CRUD - retrieve book by id
		public Book findBookById(Long id) {
			Optional<Book> optionalBook = bookRepo.findById(id);
			if(optionalBook.isPresent())
				return optionalBook.get();
			else 
				return null;
		}
		
		// CRUD - update book
		public Book updateBook(Book book) {
			return bookRepo.save(book);
		}
		
		// CRUD - delete book by id
		public void deleteBookById(Long id) {
			bookRepo.deleteById(id);
		}
}
