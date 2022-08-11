package com.mukwano.SystemConfigurationDashboardAuthentication;

import com.mukwano.DBOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.util.UUID;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class administration extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String auth = request.getParameter("auth");
        HttpSession session = request.getSession();
        switch (auth) {
            case "guest": {
                handleGuest(request, response);
                break;
            }
            case "register": {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String confirm = request.getParameter("confirm_password");
                String location = request.getParameter("location");
                String gender = request.getParameter("gender");

                if (!password.equals(confirm)) {
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("location", location);
                    request.setAttribute("error", "passwords do not match!");

                    request.getRequestDispatcher("registration_form.jsp").forward(request, response);
                    return;
                }

                HashMap<String, String> dbMsg0 = DBOperations.insert("insert into user (name, email, password, userType, location, gender) values ('"+name+"', '"+email+"', '"+password+"', 'customer', '"+location+"', '"+gender+"');");
                if (dbMsg0.containsKey("error")){
                    request.setAttribute("name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("location", location);
                    request.setAttribute("error", dbMsg0.get("error"));
                    request.getRequestDispatcher("registration_form.jsp").forward(request, response);
                    return;
                }

                List<HashMap<String, String>> dbMsg = DBOperations.select("select * from user where email = '"+email+"';");
                session.setAttribute("user_id",dbMsg.get(0).get("id"));
                session.setAttribute("username", dbMsg.get(0).get("name"));
                session.setAttribute("email", email);
                session.setAttribute("password", password);
                session.setAttribute("auth", auth);
                session.setAttribute("userType", dbMsg.get(0).get("userType"));
                response.sendRedirect(request.getContextPath() + "/home.jsp");
                break;
            }

            case "login": {
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                List<HashMap<String, String>> dbMsg = DBOperations.select("select * from user where email = '"+email+"';");
                if (dbMsg.isEmpty()) {
                    request.setAttribute("email", email);
                    request.setAttribute("error", "User does not exist!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    break;
                }
                else if(!password.equals(dbMsg.get(0).get("password"))){
                    request.setAttribute("email", email);
                    request.setAttribute("error", "Invalid password or email!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    break;
                }

                session.setAttribute("user_id",dbMsg.get(0).get("id"));
                session.setAttribute("username", dbMsg.get(0).get("name"));
                session.setAttribute("email", email);
                session.setAttribute("password", password);
                session.setAttribute("auth", auth);
                session.setAttribute("userType", dbMsg.get(0).get("userType"));
                response.sendRedirect(request.getContextPath() + "/home.jsp");
                break;
            }
            case "logout": {
                session.setAttribute("clearPrev","clear");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                break;
            }
        }

    }

    protected void handleGuest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String guestId = "";
        boolean exists = false;
        Cookie[] cookies = request.getCookies();

        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("guest")) {
                guestId = cookie.getValue();
                exists = true;
                break;
            }
        }

        if(!exists){
            UUID uuid=UUID.randomUUID();
            guestId = uuid.toString();
            Cookie mycookie = new Cookie("guest",guestId);
            mycookie.setComment("Our guest!");
            mycookie.setMaxAge(86400);
            response.addCookie(mycookie);
            DBOperations.insert("insert into guests (guestIdentifier) values ('"+guestId+"');");
        }
        guestId = DBOperations.select("select * from guests where guestIdentifier='"+guestId+"';").get(0).get("id");
        session.setAttribute("guestId",guestId);
        session.setAttribute("userType", "guest");
        response.sendRedirect(request.getContextPath() + "/home.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html");
        handleGuest(request, response);
    }
}
