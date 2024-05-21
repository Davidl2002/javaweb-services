<%@page import="java.net.http.HttpResponse"%>
<%@page import="Quinto.ApiConsumer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

String cedula = request.getParameter("cedula");
ApiConsumer api = new ApiConsumer();
HttpResponse<String> respuesta = api.deleteEstudiante(cedula);

if (api.getResponceStatus(respuesta)==200) {
        response.sendRedirect("index.jsp");
    }else{
    out.print("Error al eliminar");
    out.print(respuesta.body());
    }
%>
