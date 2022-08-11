<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
  <!-- Brand Logo -->
  <a href="#" class="brand-link">
    <img src="public/dist/img/fav.png" alt="Covid" class="brand-image img-circle elevation-3"
         style="opacity: .8">
    <span class="brand-text font-weight-light">Mukwano</span>
  </a>

  <!-- Sidebar -->
  <div class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
      <div class="image">
        <img src="public/dist/img/user.png" class="img-circle elevation-2" alt="User Image">
      </div>
      <div class="info">
        <% if (!session.getAttribute("userType").equals("guest")) { %>
          <span class="d-block" style="color: white">${sessionScope.username}</span>
          <form method="POST" action="administration" class="d-block">
            <input type="hidden" name="auth" value="logout"/>
            <a href="administration" onclick="event.preventDefault(); this.closest('form').submit();">
              <i class="fa fa-sign-out"></i>Log out
            </a>
          </form>
        <% } else { %>
          <span class="d-block" style="color: white">Guest</span>
        <% } %>
      </div>
    </div>

    <!-- Sidebar Menu -->
    <nav class="mt-2">
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <li class="nav-item">
          <a href="./dashboard" class="nav-link">
            <i class="nav-icon fas fa-edit"></i>
            <p>Dashboard</p>
          </a>
        </li>
        <%if (session.getAttribute("userType").equals("manager")) { %>
          <li class="nav-item">
            <a href="products.jsp?docSection=regProducts" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>Register Products</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="productSalesManagement" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>View Products</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="./customer?reqType=neededProducts" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>Needed Products</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="./productSalesManagement?reqType=getSales" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>Sales</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="./productSalesManagement?reqType=getLikings" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>Likings</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="staff.jsp?docSection=regStaff" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>Register Staff</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="staffManagement" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>View Staff</p>
            </a>
          </li>

          <li class="nav-item">
            <a href="report" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>Reports</p>
            </a>
          </li>
        <%} else if (session.getAttribute("userType").equals("customer")) { %>
        <li class="nav-item">
          <a href="customer?reqType=getProducts" class="nav-link">
            <i class="nav-icon fas fa-edit"></i>
            <p>Add Cart</p>
          </a>
        </li>

        <li class="nav-item">
          <a href="customer?reqType=getCart" class="nav-link">
            <i class="nav-icon fas fa-edit"></i>
            <p>View Cart</p>
          </a>
        </li>

        <li class="nav-item">
          <a href="customer?reqType=getBought" class="nav-link">
            <i class="nav-icon fas fa-edit"></i>
            <p>View Bought</p>
          </a>
        </li>

        <li class="nav-item">
          <a href="likes" class="nav-link">
            <i class="nav-icon fas fa-edit"></i>
            <p>View Products</p>
          </a>
        </li>
        <%} else {%>
        <li class="nav-item">
          <a href="likes" class="nav-link">
            <i class="nav-icon fas fa-edit"></i>
            <p>View Products</p>
          </a>
        </li>
        <% } %>
      </ul>
    </nav>
    <!-- /.sidebar-menu -->
  </div>
  <!-- /.sidebar -->
</aside>
<!-- /.Main Sidebar Container -->