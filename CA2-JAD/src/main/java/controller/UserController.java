package controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import model.User;
import model.UserDAO;

@RestController


public class UserController {
	public String loginUser(@RequestParam("loginid") String username,
	                        @RequestParam("password") String password,
	                        HttpServletRequest request) {
	    try {
	        UserDAO userDAO = new UserDAO();
	        User user = userDAO.loginUser(username, password);
	        if (user != null) {
	            // User login successful, redirect to the appropriate page
	            HttpSession session = request.getSession();
	            session.setAttribute("user", user);
	            return "redirect:/pages/landing.jsp?loginid=" + username;
	        } else {
	            // Invalid credentials, redirect to the login page
	            return "redirect:/login.jsp";
	        }
	    } catch (SQLException e) {
	        // Handle the exception
	        return "redirect:/error.jsp";
	    }
	}

	
	@RequestMapping(method=RequestMethod.GET, path="/getAllUsers")
	public ArrayList<User> getAllUsers() {
		ArrayList<User> myList = new ArrayList<>();
		try {
			UserDAO db = new UserDAO();
			myList = db.listAllUsers();
		}catch(Exception e) {
			System.out.println("error"+e);
		}
		
		return myList;
	}
	
	
//	@RequestMapping(method = RequestMethod.POST, path = "/createUser", consumes="application/json")
//	public int createUser(@RequestBody User user ) {
//		int rec=0;
//		try {
//			UserDAO db = new UserDAO();
//			String uid =user.getUserid();
//			System.out.println("usercontroller(uid)= "+uid);
////			String uAge = user();
////			String uGender= user.getGender();
////			rec = db.insertUser(uid, uAge, uGender);
//			System.out.println("created user.. "+rec);
//			
//		}catch(Exception e) {
//			System.out.println(e.toString());
//		}
//		return rec; 
//	}
//	
//	@RequestMapping(method = RequestMethod.PUT, path = "/updateUser/{uid}", consumes="application/json")
//	public int updateUser(@PathVariable String uid, @RequestBody User user ) {
//		int rec=0;
//		try {
//			UserDAO db = new UserDAO();
//			rec = db.updateUser(uid,user);
//			System.out.println("updated user.. "+rec);
//			
//		}catch(Exception e) {
//			System.out.println(e.toString());
//		}
//		return rec; 
//	}
//	
//	@RequestMapping(method = RequestMethod.DELETE, path = "/deleteUser/{uid}")
//	public int deleteUser(@PathVariable String uid ) {
//		int rec=0;
//		try {
//			UserDAO db = new UserDAO();
//			rec = db.deleteUser(uid);
//			System.out.println("deleted user.. "+rec);
//			
//		}catch(Exception e) {
//			System.out.println(e.toString());
//		}
//		return rec; 
//	}

	
//	@PutMapping
//	public String updateUser() {
//		return "updateUser is being called";	
//	}
//	
//	@DeleteMapping
//	public String deleteUser() {
//		return "deleteUser is being called";	
//	}
	
}
