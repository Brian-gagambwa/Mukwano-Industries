package com.mukwano.HRManagement;

import com.mukwano.DBOperations;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class staffManagement extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String reqType = request.getParameter("reqType");

        request.getSession().setAttribute("reqType",reqType);
        if (reqType.equals("regStaff")){
            String[] firstnames = request.getParameterValues("firstname");
            String[] lastnames = request.getParameterValues("lastname");

            for (int i = 0; i < firstnames.length; i++) {
                if (firstnames[i].length()>0&&lastnames[i].length()>0) {
                    String prod_id = DBOperations.select("select id, product_id, case when sum_table.sum is null then 0 else sum_table.sum end as sum_ from product_line left join (select count(*) as sum, product_line_id from staff group by product_line_id) sum_table on product_line.id=sum_table.product_line_id order by sum_ limit 1;").get(0).get("id");
                    DBOperations.insert("insert into staff(firstname, lastname, product_line_id) values ('"+firstnames[i]+"','"+lastnames[i]+"', "+prod_id+");");
                }
            }
            getStaff(request.getSession());
            response.sendRedirect(request.getContextPath() + "/staff.jsp?docSection=showStaff");
        }

        else if (reqType.equals("updateStaff")){
            String[] ids = request.getParameterValues("id");
            String[] firstnames = request.getParameterValues("firstname");
            String[] lastnames = request.getParameterValues("lastname");

            for (int i = 0; i < firstnames.length; i++) {
                if (firstnames[i].length()>0&&lastnames[i].length()>0) {
                    DBOperations.update("update staff set firstname='"+firstnames[i]+"', lastname='"+lastnames[i]+"' where id="+ids[i]+";");
                }
            }

            getStaff(request.getSession());
            response.sendRedirect(request.getContextPath() + "/staff.jsp?docSection=showStaff");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String reqType = request.getParameter("reqType");
        if (reqType != null){
            int x =0;
        }
        request.getSession().setAttribute("reqType","getStaff");
        getStaff(request.getSession());
        response.sendRedirect(request.getContextPath() + "/staff.jsp?docSection=showStaff");
    }

    protected void getStaff(HttpSession session){
        List<HashMap<String, String>> rows = DBOperations.select("select staff.id, firstname, lastname, name as product, line as product_line from staff inner join product_line pl on pl.id = staff.product_line_id inner join main.product p on p.id = pl.product_id;");
        String ids = "";
        String firstnames = "";
        String lastnames = "";
        String products = "";
        String product_lines = "";

        if (!rows.isEmpty()) {
            for (HashMap<String, String> row : rows) {
                ids+=row.get("id")+",";
                firstnames+=row.get("firstname")+",";
                lastnames+=row.get("lastname")+",";
                products+=row.get("product")+",";
                product_lines+=row.get("product_line")+",";
            }
            session.setAttribute("ids", ids.substring(0, ids.length()-1));
            session.setAttribute("firstnames", firstnames.substring(0, firstnames.length()-1));
            session.setAttribute("lastnames", lastnames.substring(0, lastnames.length()-1));
            session.setAttribute("products", products.substring(0, products.length()-1));
            session.setAttribute("product_lines", product_lines.substring(0, product_lines.length()-1));
        }
        else{
            session.setAttribute("ids", "");
            session.setAttribute("firstnames", "");
            session.setAttribute("lastnames", "");
            session.setAttribute("products", "");
            session.setAttribute("product_lines", "");
        }
    }
}
,