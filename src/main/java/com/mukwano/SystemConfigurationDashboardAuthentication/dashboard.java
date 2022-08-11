package com.mukwano.SystemConfigurationDashboardAuthentication;

import com.mukwano.DBOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

public class dashboard extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html");
        HttpSession session = request.getSession();

        List<HashMap<String, String>> mostBought = DBOperations.select("select name, line, sum(total) as total   from cart inner join product_line pl on pl.id = cart.product_id inner join main.product p on p.id = pl.product_id where cart.bought_at is not null group by name, line order by total desc limit 2;");
        List<HashMap<String, String>> mostLiked = DBOperations.select("select p.name, count(*) as likes from likes inner join main.product p on p.id = likes.product_id group by p.name order by likes desc;");

        String mostBoughtNames = "";
        String lines = "";
        String totals = "";

        String mostLikedNames = "";
        String likes = "";

        if(!mostBought.isEmpty()) {
            for (HashMap<String, String> mostB : mostBought) {
                mostBoughtNames += mostB.get("name") + ",";
                lines += mostB.get("line") + ",";
                totals += mostB.get("total") + ",";
            }
            session.setAttribute("mostBoughtNames", mostBoughtNames.substring(0, mostBoughtNames.length() - 1));
            session.setAttribute("lines", lines.substring(0, lines.length() - 1));
            session.setAttribute("totals", totals.substring(0, totals.length() - 1));
        }

        if(!mostLiked.isEmpty()) {
            for (HashMap<String, String> mostL : mostLiked) {
                mostLikedNames += mostL.get("name") + ",";
                likes += mostL.get("likes") + ",";
            }
            session.setAttribute("mostLikedNames", mostLikedNames.substring(0, mostLikedNames.length() - 1));
            session.setAttribute("likes", likes.substring(0, likes.length() - 1));
        }

        if (session.getAttribute("userType").equals("manager")) {
            session.setAttribute("products_no",DBOperations.select("select count(*) as num from product;").get(0).get("num"));
            session.setAttribute("guests_no",DBOperations.select("select count(*) as num from guests;").get(0).get("num"));
            session.setAttribute("customers_no",DBOperations.select("select count(*) as num from user where userType='customer';").get(0).get("num"));
            session.setAttribute("staff_no",DBOperations.select("select count(*) as num from staff;").get(0).get("num"));
        }

        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
    }
}
