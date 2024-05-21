package Quinto;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import org.json.JSONArray;
import org.json.JSONObject;

public class ApiConsumer {

    private final HttpClient httpClient;
    private static String url = "http://localhost/SOAcopia/controller/apiRest.php";

    public ApiConsumer() {
        this.httpClient = HttpClient.newHttpClient();
    }

    public JSONArray getEstudiantes() throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
       HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());
        return new JSONArray(response.body());
    }

    public HttpResponse<String> postEstudiante(String cedula, String nombre, String apellido, String direccion, String telefono) {
        try {
            JSONObject estudiante = new JSONObject();
            estudiante.put("cedula", cedula);
            estudiante.put("nombre", nombre);
            estudiante.put("apellido", apellido);
            estudiante.put("direccion", direccion);
            estudiante.put("telefono", telefono);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(estudiante.toString()))
                    .build();

            HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());
            return response;
        } catch (Exception ex) {
            System.out.println("Excepcion enviar estudiante: " + ex);
            return null;
        }
    }

    public HttpResponse<String> deleteEstudiante(String cedula) {
        try {
            URI uri = URI.create(url + "?cedula=" + cedula);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(uri)
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response;
        } catch (Exception ex) {
            System.out.println("Error al eliminar: " + ex);
            return null;
        }
    }
    
    
        public int getResponceStatus(HttpResponse<String> response){
            return response.statusCode();
        }
    
         public HttpResponse<String> updateUser(String cedula, String nombre, String apellido, String direccion, String telefono) throws Exception {
        // Crea el objeto JSON con los datos a actualizar
        JSONObject data = new JSONObject();
        data.put("cedula", cedula);
        data.put("nombre", nombre);
        data.put("apellido", apellido);
        data.put("direccion", direccion);
        data.put("telefono", telefono);

        // Construye la URI
        URI uri = URI.create(url);

        // Crea una solicitud PUT para actualizar el usuario
        HttpRequest request = HttpRequest.newBuilder()
                .uri(uri)
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.ofString(data.toString()))
                .build();

        // Envía la solicitud y devuelve la respuesta
        return httpClient.send(request, BodyHandlers.ofString());
    }
         
             public JSONObject getUserById(String cedula) throws Exception {
        // Realiza una solicitud GET para obtener todos los usuarios
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        // Obtiene la respuesta del servidor
        HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());

        // Convierte la respuesta en un JSONArray
        JSONArray jsonArray = new JSONArray(response.body());

        // Itera a través del JSONArray y encuentra el usuario con la cedula especificada
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            if (jsonObject.getString("cedula").equals(cedula)) {
                // Retorna el objeto JSON del usuario encontrado
                return jsonObject;
            }
        }

        // Si no se encuentra el usuario, retorna null
        return null;
    }
}
