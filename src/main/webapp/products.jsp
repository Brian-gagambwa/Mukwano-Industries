<%@ include file="../upper.jsp" %> <!-- Upper part of the website -->
<%if (session.getAttribute("userType").equals("manager")) { %> <!-- if user is a manager -->
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-12">
        <div class="card mt-5">
          <% if (docSection.equals("regProducts")){%>
          <div class="card-header"><h2>Register Products</h2></div>
          <div class="card-body">
            <!-- form starts here -->
            <form action="productSalesManagement" method="post"> <!-- form submits to health module using post method -->
              <input type="hidden" name="reqType" value="regProducts"> <!-- request type is regCenters -->
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th>Product Name</th>
                    <th>Number of Long Term</th>
                    <th>Price for Long Term</th>
                  </tr>
                </thead>
                <tbody>
                <tr>
                  <td><input type="text" name="name" class="form-control form-control-custom" required/></td>
                  <td><input type="number" name="longTerm" class="form-control form-control-custom" required/></td>
                  <td><input type="number" name="price" class="form-control form-control-custom" required/></td>
                </tr>
                <tr>
                  <td><input type="text" name="name" class="form-control form-control-custom" required/></td>
                  <td><input type="number" name="longTerm" class="form-control form-control-custom" required/></td>
                  <td><input type="number" name="price" class="form-control form-control-custom" required/></td>
                </tr>
                <tr>
                  <td><input type="text" name="name" class="form-control form-control-custom" required/></td>
                  <td><input type="number" name="longTerm" class="form-control form-control-custom" required/></td>
                  <td><input type="number" name="price" class="form-control form-control-custom" required/></td>
                </tr>
                <tr>
                  <td><input type="text" name="name" class="form-control form-control-custom" required/></td>
                  <td><input type="number" name="longTerm" class="form-control form-control-custom" required/></td>
                  <td><input type="number" name="price" class="form-control form-control-custom" required/></td>
                </tr>
                </tbody>
              </table>
              <div class="form-group row mb-0">
                <div class="col-md-6">
                  <button type="submit" class="btn btn-primary">Add</button> <!-- submission button -->
                </div>
              </div>
            </form>
          </div>
          <%}%>

          <% if (docSection.equals("showProducts")){%>
          <div class="card-header"><h2>Products</h2></div>
          <div class="card-body">
            <!-- form starts here -->
            <p class="bg-success text-danger">
              <%if (session.getAttribute("reqType").equals("regProducts")) {%>
                Records added successfully!
              <% session.setAttribute("reqType","getProducts");} %>

              <% if (session.getAttribute("reqType").equals("updateProducts")) {%>
                Records updated successfully!
              <% session.setAttribute("reqType","getProducts");} %>
            </p>
            <form action="productSalesManagement" method="post"> <!-- form submits to health module using post method -->
              <input type="hidden" name="reqType" value="updateProducts"> <!-- request type is regCenters -->
              <table class="table table-bordered table-hover">
                <thead>
                <tr>
                  <th>Name</th>
                  <th>Price</th>
                  <th>Long-Term</th>
                  <th>Medium-Term</th>
                  <th>Short-Term</th>
                </tr>
                </thead>
                <tbody>
                <%
                  String[] ids = session.getAttribute("ids").toString().split(",");
                  String[] names = session.getAttribute("names").toString().split(",");
                  String[] longTerm = session.getAttribute("longTerm").toString().split(",");
                  String[] prices = session.getAttribute("prices").toString().split(",");
                  int length = ids.length;

                  for(int i=0; i<length; i++){
                %>
                  <tr>
                    <td><input type="hidden" name="id" value="<%=ids[i]%>"> <input type="text" name="name" class="form-control form-control-custom" value="<%=names[i]%>" required/></td>
                    <td><input type="number" name="price" class="form-control form-control-custom" value="<%=prices[i]%>" required/></td>
                    <td><input type="number" name="longTerm" class="form-control form-control-custom" value="<%=longTerm[i]%>" required/></td>
                    <td><%=Integer.parseInt(longTerm[i])*2%></td>
                    <td><%=(Integer.parseInt(longTerm[i])*2)*5%></td>
                  </tr>
                <% } %>
                </tbody>
              </table>
              <div class="form-group row mb-0">
                <div class="col-md-6">
                  <button type="submit" class="btn btn-primary">Update</button> <!-- submission button -->
                </div>
              </div>
            </form>
          </div>

          <%}
            if (docSection.equals("neededProducts")){%>
              <div class="card-header"><h2>Needed Products</h2></div>
              <div class="card-body">
                <table class="table table-bordered table-hover">
                  <thead>
                  <tr>
                    <th>Customer</th>
                    <th>Product</th>
                    <th>Line</th>
                    <th>Location</th>
                    <th>Order Date</th>
                  </tr>
                  </thead>
                  <tbody>
                  <%
                    String[] customers = session.getAttribute("customers").toString().split(",");
                    String[] products = session.getAttribute("products").toString().split(",");
                    String[] lines = session.getAttribute("lines").toString().split(",");
                    String[] locations = session.getAttribute("locations").toString().split(",");
                    String[] order_dates = session.getAttribute("order_dates").toString().split(",");

                    int length = customers.length;

                    for(int i=0; i<length; i++){
                  %>
                  <tr>
                    <td><%=customers[i]%></td>
                    <td><%=products[i]%></td>
                    <td><%=lines[i]%></td>
                    <td><%=locations[i]%></td>
                    <td><%=order_dates[i]%></td>
                  </tr>
                  <% } %>
                  </tbody>
                </table>
              </div>
          <% } if (docSection.equals("showSales")){ %>
          <div class="card-header"><h2>Sales</h2></div>
          <div class="card-body">
            <table class="table table-bordered table-hover">
              <thead>
              <tr>
                <th>Product</th>
                <th>Line</th>
                <th>Quantity</th>
              </tr>
              </thead>
              <tbody>
              <%
                String[] products = session.getAttribute("mostBoughtNames").toString().split(",");
                String[] lines = session.getAttribute("lines").toString().split(",");
                String[] totals = session.getAttribute("totals").toString().split(",");

                int length = products.length;

                for(int i=0; i<length; i++){
              %>
              <tr>
                <td><%=products[i]%></td>
                <td><%=lines[i]%></td>
                <td><%=totals[i]%></td>
              </tr>
              <% }%>
              </tbody>
            </table>
          </div>
          <%} if (docSection.equals("showLikes")){ %>
          <div class="card-header"><h2>Likings</h2></div>
          <div class="card-body">
            <table class="table table-bordered table-hover">
              <thead>
              <tr>
                <th>Product</th>
                <th>Likes</th>
              </tr>
              </thead>
              <tbody>
              <%
                String[] products = session.getAttribute("mostLikedNames").toString().split(",");
                String[] likes = session.getAttribute("likes").toString().split(",");

                int length = products.length;

                for(int i=0; i<length; i++){
              %>
              <tr>
                <td><%=products[i]%></td>
                <td><%=likes[i]%></td>
              </tr>
              <% }%>
              </tbody>
            </table>
          </div>
          <%}%>
        </div>
      </div>
    </div>
  </div>
<%}%> <!-- end of if statement -->
<%@ include file="../lower.jsp" %> <!-- Lower part of the website -->
