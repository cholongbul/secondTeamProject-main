package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/user/userUpdate")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = new UserDTO();
		userDTO = userDAO.getUser(userID);
		String profile = userDAO.getProfile(userID);
		request.setAttribute("userDTO",userDTO);
		request.setAttribute("profile",profile);
		request
		.getRequestDispatcher("../update/update.jsp")
		.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String userID = request.getParameter("userID");
		HttpSession session = request.getSession();
		String userPassword1 = request.getParameter("userPassword1");
		String userPassword2 = request.getParameter("userPassword2");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		if(userID == null || userID.equals("") || userPassword1 == null||userPassword1.equals("")||
				userPassword2 == null || userPassword2.equals("") || userName == null||userName.equals("")||
						userAge == null || userAge.equals("") || userGender == null||userGender.equals("")||
								userEmail == null || userEmail.equals("")) {
			request.getSession().setAttribute("messageType","???????????????");
			request.getSession().setAttribute("messageContent","?????? ????????? ???????????????");
			response.sendRedirect("../update/userUpdate");
			return;
	}//??????????????? ??????if
		if(!userID.equals((String) session.getAttribute("userID"))) {
			request.getSession().setAttribute("messageType","???????????????");
			request.getSession().setAttribute("messageContent","????????? ??? ????????????");
			response.sendRedirect("../main/main.jsp");
		}
	if(!userPassword1.equals(userPassword2)) {
		request.getSession().setAttribute("messageType","???????????????");
		request.getSession().setAttribute("messageContent","??????????????? ???????????? ????????????");
		response.sendRedirect("../user/userUpdate");
		return;
	}//???????????? ?????????if
	
	//?????? ??????
	int result = new UserDAO().update(userID, userPassword1, userName, userAge, userGender, userEmail);
	if(result == 1) {
		request.getSession().setAttribute("userID", userID);
		request.getSession().setAttribute("messageType","???????????????");
		request.getSession().setAttribute("messageContent","??????????????? ??????????????????");
		response.sendRedirect("../main/main.jsp");
	}else {
		request.getSession().setAttribute("messageType","???????????????");
		request.getSession().setAttribute("messageContent","??????????????? ??????????????????//DB?????? ");
		response.sendRedirect("../user/userUpdate");
	}
 }//post
}//class
