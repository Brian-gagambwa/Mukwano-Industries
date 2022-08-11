package com.mukwano.ProductAndSalesManagement;

import com.mukwano.DBOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class productSalesManagement extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String reqType = request.getParameter("reqType");
        request.getSession().setAttribute("reqType",reqType);
        if (reqType.equals("regProducts")){
            String[] names = request.getParameterValues("name");
            String[] longTerm = request.getParameterValues("longTerm");
            String[] prices = request.getParameterValues("price");

            String query = "";
            for (int i = 0; i < names.length; i++) {
                if (names[i].length()>0&&longTerm[i].length()>0&&prices[i].length()>0) {
                    query+="('"+names[i]+"',"+longTerm[i]+","+prices[i]+"),";
                }
            }

            if (!query.equals("")){
                query = "insert into product (name, long_term, price) values "+query.substring(0, query.length()-1)+";";
                DBOperations.insert(query);

                String max_id = DBOperations.select("select case when max(product_id) is null then 0 else max(product_id) end as max_id from product_line;").get(0).get("max_id");
                List<HashMap<String, String>> rows = DBOperations.select("select id from product where id>"+max_id+";");

                for (HashMap<String, String> row : rows) {
                    String id=row.get("id");
                    DBOperations.insert("insert into product_line (line, product_id) VALUES ('long-term',"+id+"), ('medium-term',"+id+"), ('short-term',"+id+");");
                }
            }
            getProducts(request.getSession());
            response.sendRedirect(request.getContextPath() + "/products.jsp?docSection=showProducts");
        }
        else if (reqType.equals("updateProducts")){
            String[] ids = request.getParameterValues("id");
            String[] names = request.getParameterValues("name");
            String[] longTerm = request.getParameterValues("longTerm");
            String[] prices = request.getParameterValues("price");

            for (int i = 0; i < names.length; i++) {
                if (names[i].length()>0&&longTerm[i].length()>0&&prices[i].length()>0) {
                    DBOperations.update("update product set name='"+names[i]+"', long_term="+longTerm[i]+", price="+prices[i]+" where id="+ids[i]+";");
                }
            }

            getProducts(request.getSession());
            response.sendRedirect(request.getContextPath() + "/products.jsp?docSection=showProducts");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String reqType = request.getParameter("reqType");
        if (reqType==null){
            reqType = "getProducts";
        }

        if (reqType.equals("getSales")){
            HttpSession session = request.getSession();
            List<HashMap<String, String>> mostBought = DBOperations.select("select name, line, sum(total) as total   from cart inner join product_line pl on pl.id = cart.product_id inner join main.product p on p.id = pl.product_id where cart.bought_at is not null group by name, line order by total desc;");

            String mostBoughtNames = "";
            String lines = "";
            String totals = "";


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
            else {
                session.setAttribute("mostBoughtNames", "");
                session.setAttribute("lines", "");
                session.setAttribute("totals", "");
            }
            response.sendRedirect(request.getContextPath() + "/products.jsp?docSection=showSales");
        }
        else if (reqType.equals("getLikings")){
            HttpSession session = request.getSession();
            List<HashMap<String, String>> mostLiked = DBOperations.select("select p.name, count(*) as likes from likes inner join main.product p on p.id = likes.product_id group by p.name order by likes desc;");


            String mostLikedNames = "";
            String likes = "";

            if(!mostLiked.isEmpty()) {
                for (HashMap<String, String> mostL : mostLiked) {
                    mostLikedNames += mostL.get("name") + ",";
                    likes += mostL.get("likes") + ",";
                }
                session.setAttribute("mostLikedNames", mostLikedNames.substring(0, mostLikedNames.length() - 1));
                session.setAttribute("likes", likes.substring(0, likes.length() - 1));
            }
            else {
                session.setAttribute("mostLikedNames", "");
                session.setAttribute("likes", "");
            }
            response.sendRedirect(request.getContextPath() + "/products.jsp?docSection=showLikes");
        }
        else {
            getProducts(request.getSession());
            request.getSession().setAttribute("reqType", "getProducts");
            response.sendRedirect(request.getContextPath() + "/products.jsp?docSection=showProducts");
        }
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
