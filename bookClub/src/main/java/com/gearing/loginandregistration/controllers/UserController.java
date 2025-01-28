package com.gearing.loginandregistration.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.gearing.loginandregistration.models.Book;
import com.gearing.loginandregistration.models.LoginUser;
import com.gearing.loginandregistration.models.User;
import com.gearing.loginandregistration.services.BookService;
import com.gearing.loginandregistration.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {
	@Autowired
	private UserService userServ;
	@Autowired
	private BookService bookServ;
	
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		if(session.getAttribute("userId") != null)
			return "redirect:/books";
		
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}
	
	@PostMapping("/register")
	public String register(Model model, @Valid @ModelAttribute("newUser") User newUser,
			BindingResult result, HttpSession session) {
		// Attempt to register the new user
		userServ.register(newUser, result);
		
		// Due to pass by reference, we also get the errors from the register method
		if(result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		}
		
		// No errors, so store session id to log them in
		session.setAttribute("userId", newUser.getId());
		
		// Goes to welcome page if all works well
		return "redirect:/books";
	}
	
	@PostMapping("/login")
	public String login(Model model, @Valid @ModelAttribute("newLogin") LoginUser newLogin,
			BindingResult result, HttpSession session) {
		// Attempt to login with the given information
		User loggedUser = userServ.login(newLogin, result);
		
		// Due to pass by reference, we also get the errors from the login method
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		}
		
		// No errors, so store session id to log them in
		session.setAttribute("userId", loggedUser.getId());
		
		// Go to welcome page if all goes well
		return "redirect:/books";
	}
	
	@GetMapping("/books")
	public String dashboard(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId == null) {
			return "redirect:/";
		}
		
		User user = userServ.findById(userId);
		List<Book> books = bookServ.allBooks();
		
		model.addAttribute("username", user.getUsername());
		model.addAttribute("books", books);
		
		return "welcome.jsp";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		// remove session information to force the user to login again
		session.invalidate();
		
		return "redirect:/";
	}
	
	@GetMapping("/books/new")
	public String bookForm(HttpSession session, Model model) {
		model.addAttribute("newBook", new Book());
		
		return "bookform.jsp";
	}
	
	@GetMapping("/books/{id}")
	public String bookDetails(HttpSession session, Model model, @PathVariable Long id) {
		if(session.getAttribute("userId") == null)
			return "redirect:/";
		
		Book book = bookServ.findBookById(id);
		model.addAttribute("book", book);
		
		boolean isUser = session.getAttribute("userId").equals(book.getUser().getId());
		model.addAttribute("isUser", isUser);
		
		if(isUser) {
			model.addAttribute("reader", "You");
			model.addAttribute("thinker", "your");
		} else {
			model.addAttribute("reader", book.getUser().getUsername());
			model.addAttribute("thinker", book.getUser().getUsername() + "'s");
		}
		
		return "bookdetails.jsp";
	}
	
	@DeleteMapping("/books/{id}/delete")
	public String deleteBook(HttpSession session, @PathVariable Long id) {
		Book book = bookServ.findBookById(id);
		if(session.getAttribute("userId").equals(book.getUser().getId())) {
			bookServ.deleteBookById(id);
		}
		
		return "redirect:/books";
	}
	
	@GetMapping("/books/{id}/edit")
	public String editBook(HttpSession session, Model model, @PathVariable Long id) {
		Book book = bookServ.findBookById(id);
		model.addAttribute("book", book);
		
		return "bookedit.jsp";
	}
	
	@PutMapping("/books/{id}")
	public String update(@Valid @ModelAttribute("book") Book book, BindingResult result, Model model) {
		if(result.hasErrors()) {
			model.addAttribute("book", book);
			return "bookedit.jsp";
		}
		
		bookServ.updateBook(book);
		return "redirect:/books";
	}
	
	@PostMapping("/books/add")
	public String addBook(HttpSession session, Model model, 
			@Valid @ModelAttribute("newBook") Book newBook, BindingResult result) {
		Long userId = (Long)session.getAttribute("userId");
		// check for log in, so that a book isn't attributed to no one
		if(userId == null) {
			return "redirect:/";
		}
		if(result.hasErrors()) {
			return "bookform.jsp";
		}
		
		bookServ.createBook(newBook);
		
		return "redirect:/books";
	}
}
