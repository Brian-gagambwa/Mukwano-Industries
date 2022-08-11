<%@ include file="../upper.jsp" %> <!-- Upper part of the website -->
<div class="container">
  <div class="row justify-content-start">
    <%
      String[] ids = session.getAttribute("ids").toString().split(",");
      String[] names = session.getAttribute("names").toString().split(",");
      String[] prices = session.getAttribute("prices").toString().split(",");

      String[] like_ids = session.getAttribute("like_ids").toString().split(",");
      String[] product_ids = session.getAttribute("product_ids").toString().split(",");
      int length = ids.length;

      for(int i=0; i<length; i++){
          int price = Integer.parseInt(prices[i]);
          String params = "likes?reqType=perform&id="+ids[i];
          String className = "btn btn-outline-primary";
          String innerHtml = "Like";

          for (int y=0; y<like_ids.length; y++){
              if(ids[i].equals(product_ids[y])){
                  className = "btn btn-outline-danger";
                  innerHtml = "Unlike";
                  params+="&like_id="+like_ids[y];
                  break;
              }
          }
    %>
    <div class="col" style="padding: 10px; border: 1px solid gray; border-radius: 5px; margin: 5px;">
        <%=names[i]%><br>
        long-term: <%=price%>/=<br>
        medium-term: <%=price/2%>/=<br>
        short-term: <%=price/4%>/=<br>
      <button type="button" class="<%=className%>" onclick="window.location.href='<%=params%>'"><%=innerHtml%></button>
    </div>
    <% } %>
  </div>
</div>
<%@ include file="../lower.jsp" %> <!-- Lower part of the website -->

