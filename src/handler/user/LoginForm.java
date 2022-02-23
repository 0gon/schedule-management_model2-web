package handler.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;

public class LoginForm implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		StringBuilder LocalURLBuilder = new StringBuilder(req.getScheme());
		StringBuffer requestURLBuffer = req.getRequestURL();
		String localURL = "";
		String requestURL = "";
		String localAddr = req.getLocalAddr().equals("0:0:0:0:0:0:0:1") ? "localhost" : req.getLocalAddr(); //localhost 처리 
		LocalURLBuilder.append("://").append(localAddr).append(":").append(req.getLocalPort()).append(req.getRequestURI());
		
		
		localURL = LocalURLBuilder.toString(); // http://(EC2 내부IP):8080/posPro/page/user/login
		requestURL = requestURLBuffer.toString(); // http://(EC2 외부IP):8080/posPro/page/user/login
		System.out.println("localURL: "+localURL);
		System.out.println("requestURL: "+requestURL);
		
		if(localURL.equals(requestURL)) { // 내부망으로 들어온 경우
			return "/WEB-INF/views/user/login.jsp";
		}else { // 외부망으로 들어온 경우
			return "/WEB-INF/views/user/login_mobile.jsp";
		}
	}
}
