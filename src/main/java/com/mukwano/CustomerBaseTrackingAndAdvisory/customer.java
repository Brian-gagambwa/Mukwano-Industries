package com.mukwano.CustomerBaseTrackingAndAdvisory;

import com.mukwano.DBOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class customer extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String reqType = request.getParameter("reqType");

        request.getSession().setAttribute("reqType",reqType);
        if (reqType.equals("addCart")){
            String[] products = request.getParameterValues("product");
            String[] product_lines = request.getParameterValues("product_line");
            String[] totals = request.getParameterValues("total");

            for (int i = 0; i < products.length; i++) {
                if (products[i].length()>0&&product_lines[i].length()>0&&totals[i].length()>0) {
                    HashMap<String, String> dbMsg = DBOperations.select("select pl.id, case when line='medium-term' then price/2 when line='short-term' then price/4 else price end as price from product_line pl inner join product p on p.id = pl.product_id where product_id="+products[i]+" and line='"+product_lines[i]+"';").get(0);
                    HashMap<String, String> op = DBOperations.insert("insert into cart(product_id, user_id, total, price) VALUES ("+dbMsg.get("id")+","+ request.getSession().getAttribute("user_id")+","+totals[i]+", "+dbMsg.get("price")+");");
                    response.getOutputStream().print(op.get("error"));
                }
            }

            request.getSession().setAttribute("reqType","addCart");
            getCart(request.getSession());
            response.sendRedirect(request.getContextPath() + "/customer.jsp?docSection=getCart");
        }
        else if (reqType.equals("updateCart")){
            String[] ids = request.getParameterValues("id");
            String[] totals = request.getParameterValues("total");

            for (int i = 0; i < totals.length; i++) {
                if (totals[i].length()>0) {
                    DBOperations.update("update cart set total="+totals[i]+" where id="+ids[i]+";");
                }
            }

            request.getSession().setAttribute("reqType","updateCart");
            getCart(request.getSession());
            response.sendRedirect(request.getContextPath() + "/customer.jsp?docSection=getCart");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String reqType = request.getParameter("reqType");
        HttpSession session = request.getSession();
        if (reqType.equals("getProducts")) {
            List<HashMap<String, String>> rows = DBOperations.select("select id, name from product;");
            String ids = "";
            String names = "";

            if (!rows.isEmpty()) {
                for (HashMap<String, String> row : rows) {
                    ids += row.get("id") + ",";
                    names += row.get("name") + ",";
                }
                session.setAttribute("ids", ids.substring(0, ids.length() - 1));
                session.setAttribute("names", names.substring(0, names.length() - 1));
            }
            request.getSession().setAttribute("reqType","getProducts");
            response.sendRedirect(request.getContextPath() + "/customer.jsp?docSection=addCart");
        }
        else if (reqType.equals("getCart")){
            getCart(request.getSession());
            request.getSession().setAttribute("reqType","getCart");
            response.sendRedirect(request.getContextPath() + "/customer.jsp?docSection=getCart");
        }
        else if(reqType.equals("checkout")){
            DBOperations.update("update cart set bought_at=current_timestamp where user_id="+session.getAttribute("user_id")+" and bought_at IS NULL;");
            getCart(request.getSession());
            request.getSession().setAttribute("reqType","getCart");
            response.sendRedirect(request.getContextPath() + "/customer.jsp?docSection=getCart");
        }
        else if(reqType.equals("getBought")){
            List<HashMap<String, String>> rows = DBOperations.select("select cart.id, name, line, total, datetime(bought_at, 'localtime') as bought_at, cart.price from cart inner join product_line pl on pl.id = cart.product_id inner join main.product p on p.id = pl.product_id where user_id="+session.getAttribute("user_id")+" and cart.bought_at is not null;");
            String names = "";
            String lines = "";
            String totals = "";
            String prices = "";
            String dates = "";

            if (!rows.isEmpty()) {
                for (HashMap<String, String> row : rows) {
                    names+=row.get("name")+",";
                    lines+=row.get("line")+",";
                    totals+=row.get("total")+",";
                    dates+=row.get("bought_at")+",";
                    prices+=row.get("price")+",";
                }
                session.setAttribute("names", names.substring(0, names.length()-1));
                session.setAttribute("lines", lines.substring(0, lines.length()-1));
                session.setAttribute("totals", totals.substring(0, totals.length()-1));
                session.setAttribute("dates", dates.substring(0, dates.length()-1));
                session.setAttribute("prices", prices.substring(0, prices.length()-1));

            }
            else{
                session.setAttribute("names", "");
                session.setAttribute("lines", "");
                session.setAttribute("totals", "");
                session.setAttribute("dates", "");
                session.setAttribute("prices", "");
            }
            request.getSession().setAttribute("reqType","getBought");
            response.sendRedirect(request.getContextPath() + "/customer.jsp?docSection=getBought");
        }
        else if (reqType.equals("neededProducts")){
            List<HashMap<String, String>> rows = DBOperations.select("select u.name as customer, p.name as product, line, location, created_at as order_date from cart inner join product_line pl on pl.id = cart.product_id inner join main.product p on p.id = pl.product_id inner join main.user u on u.id = cart.user_id where bought_at is null;");
            if(!rows.isEmpty()){
                String customers = "";
                String products = "";
                String lines = "";
                String locations = "";
                String order_dates = "";

                for(HashMap<String, String> row : rows){
                    customers+=row.get("customer")+",";
                    products+=row.get("product")+",";
                    lines+=row.get("line")+",";
                    locations+=row.get("location")+",";
                    order_dates+=row.get("order_date")+",";
                }
                session.setAttribute("customers",customers.substring(0, customers.length()-1));
                session.setAttribute("products",products.substring(0, products.length()-1));
                session.setAttribute("lines",lines.substring(0, lines.length()-1));
                session.setAttribute("locations",locations.substring(0, locations.length()-1));
                session.setAttribute("order_dates",order_dates.substring(0, order_dates.length()-1));
            }
            else{
                session.setAttribute("customers","");
                session.setAttribute("products","");
                session.setAttribute("lines","");
                session.setAttribute("locations","");
                session.setAttribute("order_dates","");
            }
            request.getSession().setAttribute("reqType","neededProducts");
            response.sendRedirect(request.getContextPath() + "/products.jsp?docSection=neededProducts");
        }

    }

    protected void getCart(HttpSession session){
        List<HashMap<String, String>> rows = DBOperations.select("select cart.id, name, line, total, cart.price, datetime(created_at, 'localtime') as created_at from cart inner join product_line pl on pl.id = cart.product_id inner join main.product p on p.id = pl.product_id where user_id="+session.getAttribute("user_id")+" and bought_at IS NULL;");
        String ids = "";
        String names = "";
        String lines = "";
        String totals = "";
        String prices = "";
        String dates = "";

        if (!rows.isEmpty()) {
            for (HashMap<String, String> row : rows) {
                ids+=row.get("id")+",";
                names+=row.get("name")+",";
                lines+=row.get("line")+",";
                totals+=row.get("total")+",";
                dates+=row.get("created_at")+",";
                prices+=row.get("price")+",";
            }
            session.setAttribute("ids", ids.substring(0, ids.length()-1));
            session.setAttribute("names", names.substring(0, names.length()-1));
            session.setAttribute("lines", lines.substring(0, lines.length()-1));
            session.setAttribute("totals", totals.substring(0, totals.length()-1));
            session.setAttribute("prices", prices.substring(0, prices.length()-1));
            session.setAttribute("dates", dates.substring(0, dates.length()-1));

        }
        else{
            session.setAttribute("ids", "");
            session.setAttribute("names", "");
            session.setAttribute("lines", "");
            session.setAttribute("totals", "");
            session.setAttribute("prices", "");
            session.setAttribute("dates", "");
        }
    }
}
