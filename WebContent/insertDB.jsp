<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean" />
<jsp:setProperty name="QueryBean" property="*" />
<%

   //캐쉬 제거?
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires", 0); 
    
    request.setCharacterEncoding("utf-8");
    
    String id = request.getParameter("id") ==null?"":request.getParameter("id").trim();
    String name = request.getParameter("name") ==null?"":request.getParameter("name").trim();
    String phone = request.getParameter("phone") ==null?"":request.getParameter("phone").trim();
    String grade = request.getParameter("grade") ==null?"":request.getParameter("grade").trim();

    QueryBean.getConnection();
    
    int res = 0;
    
    try{
    res =  QueryBean.setUserInfo(id,name,phone,grade);
  }catch(Exception e){
     out.print(e.toString());
  }finally{
     QueryBean.closeConnection();
  }
    
    out.print("[");
    out.print("{");
    out.print("\"RESULT_OK\": \"" + res + "\" ");
    out.print("}");
    out.print("]");
    
	System.out.println("res: "+res);
%>
    