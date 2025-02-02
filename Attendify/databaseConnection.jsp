<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException" %>
<% 
String jdbcURL = "jdbc:sqlite:C:/apache-tomcat-10.1.34/webapps/Attendify/attendify.db"; // Update this path if needed
Connection connection = null;
try {
    Class.forName("org.sqlite.JDBC"); // Load the SQLite JDBC driver
    connection = DriverManager.getConnection(jdbcURL);
    out.println("Connection to SQLite has been established.");
} catch (Exception e) {
    e.printStackTrace();
    out.println("Connection failed: " + e.getMessage());
} finally {
    if (connection != null) {
        try {
            connection.close(); // Close the connection if it was opened
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>