<%@page import="Quinto.ApiConsumer"%>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.IOException" %>

<!DOCTYPE html>
<html lang="es">
    <jsp:include page="head.jsp" />

    <body style="width: 80%; margin: auto;">
        <div>
            <jsp:include page="navbar.jsp" />
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">CEDULA</th>
                    <th scope="col">NOMBRE</th>
                    <th scope="col">APELLIDO</th>
                    <th scope="col">DIRECCION</th>
                    <th scope="col">TELEFONO</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
            </thead>

            <tbody>
                <%
                    ApiConsumer apiConsumer = new ApiConsumer();
                    
                    try {
                        JSONArray estudiante = apiConsumer.getEstudiantes();

                        for (int i = 0; i < estudiante.length(); i++) {
                            JSONObject jsonObject = estudiante.getJSONObject(i);
                            String cedula = jsonObject.getString("cedula");
                            String nombre = jsonObject.getString("nombre");
                            String apellido = jsonObject.getString("apellido");
                            String direccion = jsonObject.getString("direccion");
                            String telefono = jsonObject.getString("telefono");
                %>
                <tr>
                    <td><%= cedula%></td>
                    <td><%= nombre%></td>
                    <td><%= apellido%></td>
                    <td><%= direccion%></td>
                    <td><%= telefono%></td>
                    <td><button class="btn btn-primary" onclick="openPopup('<%= cedula%>', '<%= nombre%>', '<%= apellido%>', '<%= direccion%>', '<%= telefono%>')">EDITAR</button></td>
                    <td><a href="eliminar.jsp?cedula=<%= cedula%>" class="btn btn-danger">ELIMINAR</a></td>
                </tr>
                <%
                        }
                    } catch (IOException | InterruptedException e) {
                        // Manejo de errores
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>

<!-- Popup de actualización -->
<div id="updatePopup" class="modal" style="display: none;">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Actualizar Estudiante</h5>
                <button type="button" class="btn-close" aria-label="Close" onclick="closePopup()"></button>
            </div>
            <div class="modal-body">
                <form id="updateForm" method="POST" autocomplete="off">
                    <input type="hidden" id="cedula" name="cedula">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="apellido" class="form-label">Apellido</label>
                        <input type="text" class="form-control" id="apellido" name="apellido" required>
                    </div>
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion" required>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="telefono" name="telefono" required>
                        <div class="invalid-feedback">El teléfono debe contener solo números y tener exactamente 10 dígitos.</div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="updateUser()">Actualizar</button>
                <button type="button" class="btn btn-secondary" onclick="closePopup()">Cancelar</button>
            </div>
        </div>
    </div>
</div>

<script>
    function openPopup(cedula, nombre, apellido, direccion, telefono) {
        document.getElementById("cedula").value = cedula;
        document.getElementById("nombre").value = nombre;
        document.getElementById("apellido").value = apellido;
        document.getElementById("direccion").value = direccion;
        document.getElementById("telefono").value = telefono;
        document.getElementById("updatePopup").style.display = "block";
    }

    function closePopup() {
        document.getElementById("updatePopup").style.display = "none";
    }

    function updateUser() {
        var cedula = document.getElementById("cedula").value;
        var nombre = document.getElementById("nombre").value;
        var apellido = document.getElementById("apellido").value;
        var direccion = document.getElementById("direccion").value;
        var telefono = document.getElementById("telefono").value;
        
         if (nombre === '' || apellido === '' || direccion === '' || telefono === '') {
            alert('NO INGRESE DATOS EN BLANCO');
            return;
        }

        var telefonoRegex = /^\d{10}$/;
        if (!telefonoRegex.test(telefono)) {
            var telefonoField = document.getElementById("telefono");
            telefonoField.classList.add("is-invalid");
            return;
        }

        var data = {
            cedula: cedula,
            nombre: nombre,
            apellido: apellido,
            direccion: direccion,
            telefono: telefono
        };

        // Realiza la solicitud AJAX para actualizar el estudiante
        fetch("http://localhost/SOAcopia/controller/apiRest.php", {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (response.ok) {
                console.log("Actualización exitosa");
                closePopup(); 
                window.location.href = "index.jsp"; 
            } else {
                throw new Error("Error al actualizar");
            }
        })
        .catch(error => {
            console.error("Error al actualizar: " + error.message);
        });
    }
</script>


    </body>
</html>
