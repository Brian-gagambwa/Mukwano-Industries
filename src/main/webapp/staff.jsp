<%@ include file="../upper.jsp" %> <!-- Upper part of the website -->
<%if (session.getAttribute("userType").equals("manager")) { %> <!-- if user is a manager -->
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-8">
      <div class="card mt-5">
        <% if (docSection.equals("regStaff")){%>
        <div class="card-header"><h2>Register Staff</h2></div>
        <div class="card-body">
          <!-- form starts here -->
          <form action="staffManagement" method="post"> <!-- form submits to health module using post method -->
            <input type="hidden" name="reqType" value="regStaff"> <!-- request type is regCenters -->
            <div class="form-group row mb-0">
              <div class="col-md-6">
                <button type="button" class="btn btn-outline-success" onclick="addRow('regStaffTable')">+ Add Row</button> <!-- submission button -->
              </div>
            </div><br>
            <table class="table table-bordered table-hover" id="regStaffTable">
              <thead>
              <tr>
                <th>First Name</th>
                <th>Last Name</th>
              </tr>
              </thead>
              <tbody>
                <tr>
                  <td><input type="text" name="firstname" class="form-control form-control-custom" required/></td>
                  <td><input type="text" name="lastname" class="form-control form-control-custom" required/></td>
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

        <% if (docSection.equals("showStaff")){%>
        <div class="card-header"><h2>Staff</h2></div>
        <div class="card-body">
          <!-- form starts here -->
          <p class="bg-success text-danger">
            <% if (session.getAttribute("reqType").equals("regStaff")) {%>
            Records added successfully!
            <% session.setAttribute("reqType","getStaff");} %>

            <% if (session.getAttribute("reqType").equals("updateStaff")) {%>
            Records updated successfully!
            <% session.setAttribute("reqType","getStaff");} %>
          </p>
          <form action="staffManagement" method="post">
            <div class="form-group row mb-0">
              <div class="col-md-6">
                <button type="button" class="btn btn-outline-primary"><a href="staffManagement?reqType=reallocate">Reallocate</a></button> <!-- submission button -->
              </div>
            </div><br>
            <input type="hidden" name="reqType" value="updateStaff"> <!-- request type is regCenters -->
            <table class="table table-bordered table-hover">
              <thead>
              <tr>
                <th>Firstname</th>
                <th>Lastname</th>
                <th>Product</th>
                <th>Product-line</th>
              </tr>
              </thead>
              <tbody>
              <%
                String[] ids = session.getAttribute("ids").toString().split(",");
                String[] firstnames = session.getAttribute("firstnames").toString().split(",");
                String[] lastnames = session.getAttribute("lastnames").toString().split(",");
                String[] products = session.getAttribute("products").toString().split(",");
                String[] product_lines = session.getAttribute("product_lines").toString().split(",");

                int length = ids.length;

                if (ids[0].length()>0){
                for(int i=0; i<length; i++){
              %>
              <tr>
                <td><input type="hidden" name="id" value="<%=ids[i]%>"> <input type="text" name="firstname" class="form-control form-control-custom" value="<%=firstnames[i]%>" required/></td>
                <td><input type="text" name="lastname" class="form-control form-control-custom" value="<%=lastnames[i]%>" required/></td>
                <td><%=products[i]%></td>
                <td><%=product_lines[i]%></td>
              </tr>
              <% } } else { %>
              <tr>
                <td>No data</td>
                <td>No data</td>
                <td>No data</td>
                <td>No data</td>
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
        <%}%>

      </div>
    </div>
  </div>
</div>
<%}%> <!-- end of if statement -->
<%@ include file="../lower.jsp" %> <!-- Lower part of the website -->
