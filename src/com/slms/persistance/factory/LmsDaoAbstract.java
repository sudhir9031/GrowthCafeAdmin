/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.slms.persistance.factory;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;


/**
 *
 * @author dell
 */
public abstract class LmsDaoAbstract extends JDBCDAOAbstract{
    
 public static String dataSource = "";
 
 /**
  * This method use to close JDBC resources.
  * @param Connection
  * @param Statement
  * @param ResultSet 
  */    
 public void closeResources(Connection conn,Statement stmt,ResultSet res)
  {
 	try{
 	if(res!=null) {
                 res.close();
             }
 	if(stmt!=null) {
                 stmt.close();
             }
 	if(conn!=null) {
                 conn.close();
             }
 	}catch(Exception e){
             System.out.println(e.getMessage());
         }

  }

 public void closeResources(Connection conn)
  {
 	try{
             
 	if(conn!=null) {
                 conn.close();
             }
 	}catch(Exception e){
             System.out.println(e.getMessage());
         }

  }    

 
 public int getCountQueryResult(String query) {

		int result =0;

		Connection conn = null;
		PreparedStatement cstmt = null;
		ResultSet resultSet = null;

		try {
			// String
			// query="SELECT count(*) from table where...
			
			System.out.println("Query : " + query);

			conn = this.getConnection(dataSource);
			cstmt = conn.prepareStatement(query);
			resultSet = cstmt.executeQuery();
			if (resultSet.next()) {
				result = resultSet.getInt(1);
			}

		} catch (Exception e) {
			System.out.println("Error > getCountQueryResult - "
					+ e.getMessage());
		} finally {
			closeResources(conn, cstmt, resultSet);
		}

		return result;
	}


 }
