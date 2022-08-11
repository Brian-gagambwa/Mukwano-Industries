package com.mukwano.ProductAndSalesManagement;

import com.mukwano.DBOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class likes extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String reqType = request.getParameter("reqType");
        HttpSession session = request.getSession();
        if (reqType!=null){
            if (reqType.equals("perform")){
                String like_id = request.getParameter("like_id");
                if (like_id==null){
                    if (session.getAttribute("guestId")!=null){
                        DBOperations.insert("insert into likes (product_id, guest_id) values ("+request.getParameter("id")+","+session.getAttribute("user_id")+");");
                    }
                    else {
                        DBOperations.insert("insert into likes (product_id, customer_id) values ("+request.getParameter("id")+","+session.getAttribute("user_id")+");");
                    }
                }
                else {
                    DBOperations.update("delete from likes where id="+like_id+";");
                }
            }
        }

        getProducts(session);
        String like_ids = "";
        String product_ids = "";

        List<HashMap<String, String>> rows;
        if (session.getAttribute("guestId")!=null){
            rows = DBOperations.select("select id, product_id from likes where guest_id = "+session.getAttribute("guestId")+";");
        }
        else {
            rows = DBOperations.select("select id, product_id from likes where customer_id = "+session.getAttribute("user_id")+";");
        }
        if(!rows.isEmpty()){
            for (HashMap<String, String> row : rows ){
                like_ids+=row.get("id")+",";
                product_ids+=row.get("product_id")+",";
            }
            like_ids = like_ids.substring(0, like_ids.length()-1);
            product_ids = product_ids.substring(0, product_ids.length()-1);
        }
        session.setAttribute("like_ids", like_ids);
        session.setAttribute("product_ids", product_ids);
        response.sendRedirect(request.getContextPath() + "/viewProducts.jsp");
    }

    protected void getProducts(HttpSession session){
        List<HashMap<String, String>> rows = DBOperations.select("select * from product;");
        String ids = "";
        String names = "";
        String longTerm = "";
        String prices = "";
        if (!rows.isEmpty()) {
            for (HashMap<String, String> row : rows) {
                ids+=row.get("id")+",";
                names+=row.get("name")+",";
                longTerm+=row.get("long_term")+",";
                prices+=row.get("price")+",";
            }
            session.setAttribute("ids", ids.substring(0, ids.length()-1));
            session.setAttribute("names", names.substring(0, names.length()-1));
            session.setAttribute("longTerm", longTerm.substring(0, longTerm.length()-1));
            session.setAttribute("prices", prices.substring(0, prices.length()-1));
        }
        else{
            session.setAttribute("ids", "");
            session.setAttribute("names", "");
            session.setAttribute("longTerm", "");
            session.setAttribute("prices", "");
        }
    }
}
