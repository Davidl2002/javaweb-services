<%@page import="java.net.http.HttpResponse"%>
<%@page import="Quinto.ApiConsumer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <body>
        <div>
            <jsp:include page="navbar.jsp"/>
        </div>

        <form method="POST" onsubmit="return validateForm()">
            <div class="mb-3">
                <label for="cedula" class="form-label">Cedula</label>
                <input type="text" class="form-control" id="cedula" name="cedula" required>
                <div id="cedulaError" class="text-danger"></div>
            </div>
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>
            <div class="mb-3">
                <label for="apellido" class="form-label">Apellido</label>
                <input type="text" class="form-control" id="apellido" name="apellido" required>
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Direccion</label>
                <input type="text" class="form-control" id="direccion" name="direccion" required>
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Telefono</label>
                <input type="text" class="form-control" id="telefono" name="telefono" required>
                <div id="telefonoError" class="text-danger"></div>
            </div>
            <button type="submit" class="btn btn-primary">GUARDAR</button>
        </form>

        <%
            if (request.getMethod().equals("POST")) {
            ApiConsumer api = new ApiConsumer();
            HttpResponse<String> respuesta = api.postEstudiante(request.getParameter("cedula"), request.getParameter("nombre"),
            request.getParameter("apellido"), request.getParameter("direccion"), request.getParameter("telefono"));
            
            if (api.getResponceStatus(respuesta)==200) {
                    response.sendRedirect("index.jsp");
                }else{
                out.print("<div> No se pudo crear el nuevo estudiante </div>");
            }
            }
        %>

        <script>
            function validateForm() {
                var cedula = document.getElementById("cedula").value;
                var telefono = document.getElementById("telefono").value;

                var cedulaRegex = /^[0-9]{10}$/;
                var telefonoRegex = /^[0-9]{10}$/;

                var cedulaValid = cedulaRegex.test(cedula);
                var telefonoValid = telefonoRegex.test(telefono);

                if (!cedulaValid) {
                    document.getElementById("cedulaError").innerHTML = "La cédula debe contener solo números y tener 10 dígitos.";
                } else {
                    document.getElementById("cedulaError").innerHTML = "";
                }

                if (!telefonoValid) {
                    document.getElementById("telefonoError").innerHTML = "El teléfono debe contener solo números y tener 10 dígitos.";
                } else {
                    document.getElementById("telefonoError").innerHTML = "";
                }

                return cedulaValid && telefonoValid;
            }
        </script>
    </body>
</html>
