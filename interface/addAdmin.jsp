<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page  import="java.sql.*"%>
<%@ page  import="java.util.logging.*"%>
<%@ page  import="com.mysql.jdbc.Driver"%>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page  trimDirectiveWhitespaces="true" %>

<% 
    try{
         Class.forName("com.mysql.jdbc.Driver");
         String url="jdbc:mysql://localhost:3306/test";
         Connection conn=DriverManager.getConnection(url,"root","");
         if(conn!=null){
                Statement statement = conn.createStatement();
                Statement statement2 = conn.createStatement();
                String name = request.getParameter("name") ; 
                String phone = request.getParameter("phone") ; 
                String teacherId = request.getParameter("teacherId") ; 
                ResultSet rs=statement.executeQuery("select  * from admin where teacherId='"+teacherId+"'");
                rs.last(); 
                int rowCount=rs.getRow();

                JSONObject jsonObj = new JSONObject(); 
                if(rowCount>0){
                	jsonObj.put("code","0001");
                	out.println(jsonObj);
                	return;
                }
                String sql="insert into admin(name,phone,teacherId) values('"+name+"','"+phone+"','"+teacherId+"')";
                int count=statement2.executeUpdate(sql);
                if(count>=1){
                    jsonObj.put("code","0000");
                   
                }else{
                	jsonObj.put("code","0002");
                }
                out.println(jsonObj);
                
         }else{
             out.println("数据库连接失败！！！");
         }
     }catch(ClassNotFoundException e){
        JSONObject result= new JSONObject();
        e.printStackTrace();
        result.put("code","9999");
        result.put("msg","接口错误");
        out.println(result.toString());

     } 
 
 
 %>
