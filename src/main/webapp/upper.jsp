<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="public/plugins/fontawesome-free/css/all.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="public/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="public/dist/css/adminlte.min.css">
    <link rel="icon" href="public/dist/img/fav.png" type="image/x-icon" style="border-radius: 15px">
    <style>
        .form-control-custom{
            display: inline;
            width: auto;
            margin-right: 5px;
        }
        thead{
            border-top: 1px solid #dee2e6;
        }
    </style>
    <title>Mukwano Industries</title>
  </head>
  <body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
    <script type="text/javascript">
        function addRow(id){
            let tbody = document.getElementById(id).getElementsByTagName("tbody")[0];
            let row = document.createElement("tr");
            row.innerHTML = tbody.getElementsByTagName("tr")[0].innerHTML;
            tbody.appendChild(row);
        }
        function printDiv(divName)
        {
            let divToPrint=document.getElementById(divName);
            newWin= window.open("");
            newWin.document.write(divToPrint.outerHTML);
            newWin.print();
            newWin.close();
        }

    </script>
    <div class="wrapper">
      <%
      String docSection = "";
        if (session.getAttribute("userType")!=null){
      %>
      <%@ include file="navbar.jsp" %>
      <%@ include file="sidebar.jsp" %>
      <%
        docSection = request.getParameter("docSection");
        }
      %>
      <div class="content-wrapper">