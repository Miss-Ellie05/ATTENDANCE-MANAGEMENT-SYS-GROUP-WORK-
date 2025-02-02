<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
   // Retrieve form data
   String fullName = request.getParameter("fullName");
   String email = request.getParameter("email");
   String faculty = request.getParameter("faculty");
   String department = request.getParameter("department");
   String userType = request.getParameter("userType"); // 'student' or 'lecturer'
   String userId = request.getParameter("idField"); // Student ID or Employee ID
   String password = request.getParameter("password");

   // Debugging output to check all parameters
   java.util.Enumeration<String> parameterNames = request.getParameterNames();
   while (parameterNames.hasMoreElements()) {
       String paramName = parameterNames.nextElement();
       String paramValue = request.getParameter(paramName);
       out.println(paramName + ": " + paramValue + "<br>");
   }

   // Validate input
   if (fullName == null || fullName.trim().isEmpty()) {
       out.println("Full Name cannot be empty.");
   } else {
       // Proceed with the insertion logic
       String jdbcURL = "jdbc:sqlite:C:/apache-tomcat-10.1.34/webapps/Attendify/attendify.db"; 
       Connection connection = null;

       try {
           Class.forName("org.sqlite.JDBC"); 
           connection = DriverManager.getConnection(jdbcURL);
           out.println("Connection to SQLite has been established.");

           String insertSQL = "INSERT INTO users (full_name, email, faculty, department, user_type, user_id, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
           PreparedStatement pstmt = connection.prepareStatement(insertSQL);
           pstmt.setString(1, fullName);
           // Set other parameters...
           pstmt.executeUpdate();
           out.println("Registration successful!");

       } catch (Exception e) {
           e.printStackTrace();
           out.println("Registration failed: " + e.getMessage());
       } finally {
           if (connection != null) {
               try {
                   connection.close(); 
               } catch (SQLException e) {
                   e.printStackTrace();
               }
           }
       }
   }
%>