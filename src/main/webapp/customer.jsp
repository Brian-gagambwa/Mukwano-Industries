<%@ include file="upper.jsp" %> <!-- Upper part of the website -->
<%if (session.getAttribute("userType").equals("customer")) { %> <!-- if user is a manager -->
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card mt-5">
          <% if (docSection.equals("addCart")){%>
          <div class="card-header"><h2>Add To Cart</h2></div>
          <div class="card-body">
            <!-- form starts here -->
            <form action="customer" method="post"> <!-- form submits to health module using post method -->
              <input type="hidden" name="reqType" value="addCart"> <!-- request type is regCenters -->
              <div class="form-group row mb-0">
                <div class="col-md-6">
                  <button type="button" class="btn btn-outline-success" onclick="addRow('addCart')">+ Add Row</button> <!-- submission button -->
                </div>
              </div><br>
              <table class="table table-bordered table-hover" id="addCart">
                <thead>
                  <tr>
                    <th>Product Name</th>
                    <th>Product Line</th>
                    <th>Quantity</th>
                  </tr>
                </thead>
                <tbody>
                <tr>
                  <td>
                    <select name="product" required>
                      <%
                        String[] ids = session.getAttribute("ids").toString().split(",");
                        String[] names = session.getAttribute("names").toString().split(",");
                        int length = ids.length;

                        for(int i=0; i<length; i++){
                      %>
                      <option value="<%=ids[i]%>"><%=names[i]%></option>
                      <% } %>
                    </select>
                  </td>
                  <td>
                    <select name="product_line" required>
                      <option value="long-term">Long-term</option>
                      <option value="medium-term">Medium-term</option>
                      <option value="short-term">Short-term</option>
                    </select>
                  </td>
                  <td><input type="number" name="total" class="form-control form-control-custom" required/></td>
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

          <% if (docSection.equals("getCart")){%>
          <div class="card-header"><h2>Cart</h2></div>
          <div class="card-body">
            <!-- form starts here -->
            <p class="bg-success text-danger">
              <%if (session.getAttribute("reqType").equals("addCart")) {%>
                Records added successfully!
              <% session.setAttribute("reqType","getCart");} %>

              <% if (session.getAttribute("reqType").equals("updateCart")) {%>
                Records updated successfully!
              <% session.setAttribute("reqType","getCart");} %>
            </p>
            <form action="customer" method="post"> <!-- form submits to health module using post method -->
              <input type="hidden" name="reqType" value="updateCart"> <!-- request type is regCenters -->
              <table class="table table-bordered table-hover">
                <thead>
                <tr>
                  <th>Product</th>
                  <th>Line</th>
                  <th>Date</th>
                  <th>Quantity</th>
                  <th>Price</th>
                  <th>Amount</th>
                </tr>
                </thead>
                <tbody>
                <%
                  String[] ids = session.getAttribute("ids").toString().split(",");
                  String[] names = session.getAttribute("names").toString().split(",");
                  String[] lines = session.getAttribute("lines").toString().split(",");
                  String[] totals = session.getAttribute("totals").toString().split(",");
                  String[] prices = session.getAttribute("prices").toString().split(",");
                  String[] dates = session.getAttribute("dates").toString().split(",");
                  int length = ids.length;
                  int sum = 0;

                  if(ids[0].length()>0){
                  for(int i=0; i<length; i++){
                      int sum1 = Integer.parseInt(prices[i])*Integer.parseInt(totals[i]);
                      sum+=sum1;
                %>
                  <tr>
                    <td><input type="hidden" name="id" value="<%=ids[i]%>"><%=names[i]%></td>
                    <td><%=lines[i]%></td>
                    <td><%=dates[i]%></td>
                    <td><input type="number" name="total" value="<%=totals[i]%>" class="form-control form-control-custom" required/></td>
                    <td><%=prices[i]%></td>
                    <td><%=sum1%></td>
                  </tr>
                <% } } else { %>
                  <tr>
                    <td>No data</td>
                    <td>No data</td>
                    <td>No data</td>
                    <td>No data</td>
                    <td>No data</td>
                    <td>No data</td>
                  </tr>
                <% } %>
                </tbody>
                <tfoot><tr><th colspan="5">Total</th><th><%=sum%></th></tr></tfoot>
              </table>
              <div class="form-group row mb-0">
                <div class="col-md-6">
                  <button type="submit" class="btn btn-primary">Update</button> <!-- submission button -->
                  <button type="button" class="btn btn-outline-primary"><a href="customer?reqType=checkout">Check out</a></button>
                </div>
              </div>
            </form>
          </div>
          <%}%>

          <% if (docSection.equals("getBought")){%>
          <div class="card-header"><h2>Products Bought</h2></div>
          <div class="card-body">
            <!-- form starts here -->
            <table class="table table-bordered table-hover">
              <thead>
              <tr>
                <th>Product</th>
                <th>Line</th>
                <th>Date</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Amount</th>
              </tr>
              </thead>
              <tbody>
              <%
                String[] names = session.getAttribute("names").toString().split(",");
                String[] lines = session.getAttribute("lines").toString().split(",");
                String[] totals = session.getAttribute("totals").toString().split(",");
                String[] prices = session.getAttribute("prices").toString().split(",");
                String[] dates = session.getAttribute("dates").toString().split(",");
                int length = names.length;
                int sum = 0;

                if(names[0].length()>0){
                  for(int i=0; i<length; i++){
                      int sum1 = Integer.parseInt(totals[i])*Integer.parseInt(prices[i]);
                      sum+=sum1;
              %>
              <tr>
                <td><%=names[i]%></td>
                <td><%=lines[i]%></td>
                <td><%=dates[i]%></td>
                <td><%=totals[i]%></td>
                <td><%=prices[i]%></td>
                <td><%=sum1%></td>
              </tr>
              <% } } else { %>
              <tr>
                <td>No data</td>
                <td>No data</td>
                <td>No data</td>
                <td>No data</td>
                <td>No data</td>
                <td>No data</td>
              </tr>
              <% } %>
              </tbody>
              <tfoot><tr><th colspan="5">Total</th><th><%=sum%></th></tr></tfoot>
            </table>
          </div>
          <%}%>

        </div>
      </div>
    </div>
  </div>
<%}%> <!-- end of if statement -->
<%@ include file="lower.jsp" %> <!-- Lower part of the website -->
