<%@ include file="../upper.jsp" %> <!-- Upper part of the website -->
<div class="container">
  <div class="row justify-content-start">
    <%
      if(session.getAttribute("mostBoughtNames")!=null){
        String[] mostBoughtNames = session.getAttribute("mostBoughtNames").toString().split(",");
        String[] lines = session.getAttribute("lines").toString().split(",");
        String[] totals = session.getAttribute("totals").toString().split(",");
        int length = mostBoughtNames.length;
    %>
    <div class="card mt-1" style="padding: 5px; margin: 5px;">
      <p>Most Bought Products By Customers</p>
    <table class="table table-bordered table-hover" border="1" cellpadding="3" id="bought">
      <thead>
        <tr>
          <th>Product</th>
          <th>Line</th>
          <th>Totals</th>
        </tr>
      </thead>
      <tbody>
        <%
          for(int i=0; i<length; i++){
        %>
        <tr>
          <td><%=mostBoughtNames[i]%></td>
          <td><%=lines[i]%></td>
          <td><%=totals[i]%></td>
        </tr>
        <% } %>
      </tbody>
    </table>
      <button type="button" class="btn btn-secondary" onclick="printDiv('bought')">Print</button>
    </div>
    <% }
      if(session.getAttribute("mostLikedNames")!=null){
        String[] mostLikedNames = session.getAttribute("mostLikedNames").toString().split(",");
        String[] likes = session.getAttribute("likes").toString().split(",");
        int length = mostLikedNames.length;
    %>
    <div class="card mt-1" style="padding: 5px; margin: 5px;">
      <p>Most Liked Products By Customers</p>
      <table class="table table-bordered table-hover" border="1" cellpadding="3" id="liked">
        <thead>
        <tr>
          <th>Product</th>
          <th>Likes</th>
        </tr>
        </thead>
        <tbody>
        <%
          for(int i=0; i<length; i++){
        %>
        <tr>
          <td><%=mostLikedNames[i]%></td>
          <td><%=likes[i]%></td>
        </tr>
        <% } %>
        </tbody>
      </table>
      <button type="button" class="btn btn-secondary" onclick="printDiv('liked')">Print</button>
    </div>
    <% }

      if(session.getAttribute("userType").equals("manager")){
    %>
    <div class="card mt-1" style="padding: 5px; margin: 5px;">
      <table class="table table-bordered table-hover" border="1" cellpadding="3" id="num">
        <tbody>
        <tr>
          <td>Number of Products</td>
          <td><%=session.getAttribute("products_no")%></td>
        </tr>
        <tr>
          <td>Number of Guests</td>
          <td><%=session.getAttribute("guests_no")%></td>
        </tr>
        <tr>
          <td>Number of Customers</td>
          <td><%=session.getAttribute("customers_no")%></td>
        </tr>
        <tr>
          <td>Number of Staff</td>
          <td><%=session.getAttribute("staff_no")%></td>
        </tr>
        </tbody>
      </table>
      <button type="button" class="btn btn-secondary" onclick="printDiv('num')">Print</button>
    </div>
    <% } %>

  </div>
</div>
<%@ include file="../lower.jsp" %> <!-- Lower part of the website -->
