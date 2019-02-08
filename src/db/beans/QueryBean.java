package db.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class QueryBean {
   Connection conn;
   Statement stmt;
   ResultSet rs;
   
   public QueryBean() {
      conn = null;
      stmt = null;
      rs = null;
   }

   public void getConnection() {
      try {
         conn = DBConnection.getConnection();
      }catch(Exception e1){
         e1.printStackTrace();
      }
      try {
         stmt = conn.createStatement();
      }catch(SQLException e) {
         e.printStackTrace();
      }
   }

   public void closeConnection() {
      if(stmt != null) {
         try {
            stmt.close();
         }catch(SQLException e) {
            e.printStackTrace();
         }
      }
      if(conn != null) {
         try {
            conn.close();
         }catch(SQLException e) {
            e.printStackTrace();
         }
      }
   }
   public void insertUser(String insert)throws Exception {
	   StringBuffer sb = new StringBuffer();
	      
	      sb.append("INSERT INTO USER_INFO_SAMPLE VALUES ");
	      sb.append("("+insert+",SYSDATE)");
	      //System.out.println(reqparam1);
	      System.out.println(insert);
	      System.out.print(sb.toString());
	      stmt.executeUpdate(sb.toString());
	  
	     

	   }
	   
   public ArrayList getUserInfo() throws Exception{
      StringBuffer sb = new StringBuffer();
      
      sb.append("SELECT ");
      sb.append("U_ID, U_NAME, U_PHONE, U_GRADE, WRITE_TIME");
      sb.append(" FROM ");
      sb.append("USER_INFO_SAMPLE");
      
      
      rs = stmt.executeQuery(sb.toString());
      
      ArrayList res = new ArrayList<>();
      while(rs.next()) {
         res.add(rs.getString(1));
         res.add(rs.getString(2));
         res.add(rs.getString(3));
         res.add(rs.getString(4));
         res.add(rs.getString(5));
      }
      System.out.print(sb.toString());
      return res;
   }
   
   public int deleteUserInfo(String id) throws Exception{
	   int result = 0;
	   PreparedStatement pstmt = null;
	   StringBuffer sb = new StringBuffer();
	   
	   sb.append(" delete  ");
	   sb.append(" from ");
	   sb.append(" user_info_sample ");
	   sb.append(" where ");
	   sb.append(" u_id = ? ");
	   
	   try {
		   pstmt = conn.prepareStatement(sb.toString());
		   pstmt.clearParameters();
		   pstmt.setString(1, id);
		   
		   result = pstmt.executeUpdate();
	   }
	   catch(SQLException e) {
		   e.printStackTrace();
	   }
	   finally {
		   try {
			   if(pstmt != null) {
				   pstmt.close();
			   }
		   }
		   catch(Exception e) {
			   e.printStackTrace();
		   }
	   }
	   
	   return result;
   }
   
   public int setUserInfo(String id, String name, String phone,String grade) {
	   int result = 0;
	   
	   StringBuffer sb = new StringBuffer();
	   PreparedStatement pstmt = null;
	   sb.append(" INSERT INTO ");
	   sb.append(" USER_INFO_SAMPLE(U_ID,U_NAME,U_PHONE,U_GRADE,WRITE_TIME) ");
	   sb.append(" VALUES ");
	   sb.append(" ('"+id+"', '"+name+"', '"+phone+"', '"+grade+"', SYSDATE)");
	   System.out.println(sb.toString());
	   try {
		   pstmt = conn.prepareStatement(sb.toString());
		   result = pstmt.executeUpdate();
	   }
	   catch(SQLException e) {
		   e.printStackTrace();
	   }
	   finally {
		   try {
			   if(pstmt != null) {
				   pstmt.close();
			   }
		   }
		   catch(Exception e) {
			   e.printStackTrace();
		   }
	   }
	   return result;
   }
   
   public int updateUserInfo(String id, String name, String phone,String grade) {
	   int result = 0;
	   StringBuffer sb = new StringBuffer();
	   PreparedStatement pstmt = null;
	   sb.append(" UPDATE ");
	   sb.append(" USER_INFO_SAMPLE ");
	   sb.append(" SET ");
	   sb.append(" U_NAME=?, U_PHONE=?, U_GRADE=? ");
	   sb.append(" WHERE U_ID=?");
	   System.out.println(sb.toString());
	   try {
		   pstmt = conn.prepareStatement(sb.toString());
		   pstmt.setString(1, name);
		   pstmt.setString(2, phone);
		   pstmt.setString(3, grade);
		   pstmt.setString(4, id);
		   result = pstmt.executeUpdate();
	   }
	   catch(SQLException e) {
		   e.printStackTrace();
	   }
	   finally {
		   try {
			   if(pstmt != null) {
				   pstmt.close();
			   }
		   }
		   catch(Exception e) {
			   e.printStackTrace();
		   }
	   }
	   return result;
   }
}