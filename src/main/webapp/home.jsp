<%@ include file="upper.jsp" %>
<%
if (session.getAttribute("userType")==null) {
    response.sendRedirect(request.getContextPath() + "/administration");
}
else {
    response.sendRedirect(request.getContextPath() + "/dashboard");
}
%>
<%@ include file="lower.jsp" %>