package tea.db;

import java.util.*;
import java.sql.SQLException;
import java.sql.ResultSetMetaData;
import java.io.*;
import java.net.*;

public class MySQL
{
	
	
	/*
	 * 
	 *  FileWriter writer;
			try { 

			    //打开一个写文件器，构造函数中的第二个参数true表示以追加形式写文件
			    writer = new FileWriter("c:\\Result.txt", true);
			    writer.write(sql+"\r\n");
			    writer.close();
			 
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	 */ 

    /*public static void main(String[] args) throws IOException,SQLException
    {
    	try {

				ArrayList list = tables(1);
				for(int i=0;i<list.size();i++)
				{
					String tname = (String)list.get(i);
				//	if(!"destine".equals(tname) && !"leave".equals(tname)&& !"out".equals(tname)){
					if("NodeLayer".equals(tname)){
						exp(tname);
					}    
					//System.out.println(tname);
				} 
				
			} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		
		}
    } 
    */
    
   
    


    //导表的数据
    public static void exp(String tab) throws SQLException
    {
        DbAdapter db = new DbAdapter();//原始库
        DbAdapter d1 = new DbAdapter(1);//mysql--
        try 
        {
            d1.executeUpdate("TRUNCATE TABLE " + tab);
            //d1.executeUpdate("ALTER TABLE `"+tab+"` ENGINE=MyISAM");

            java.sql.ResultSet rs = db.executeQuery("SELECT * FROM " + tab,0,10000);
            ResultSetMetaData md = rs.getMetaData();
            int len = md.getColumnCount();
            while (rs.next())
            {
                StringBuffer c = new StringBuffer(), sb = new StringBuffer();
                c.append("INSERT INTO " + tab + "(");
                for (int i = 1; i <= len; i++)
                {
                    if (i > 1)
                    {
                        c.append(",");
                        sb.append(",");
                    }
                    c.append(md.getColumnName(i));
                    String v = rs.getString(i);
                //    System.out.println(rs.getMetaData().getColumnTypeName(i));
                    if("bit".equals(rs.getMetaData().getColumnTypeName(i)) || "tinyint".equals(rs.getMetaData().getColumnTypeName(i)))
                    {
                    
                    	sb.append(v);
                    	
                    }else
                    {
                    	sb.append("".equals(v) ? "''" : DbAdapter.cite(v));
                    }
                    
                    
                }
                c.append(")VALUES(").append(sb).append(")");
                try
                {
                	//System.out.println(c.toString());
                	
                    int j = d1.executeUpdate(c.toString());
                    if (j == 0)
                    {
                        System.out.println(c.toString());
                    }
                } catch (Exception ex)
                {

                }
            }
        } finally
        {
            db.close();
            d1.close();
        }

    }


    //列出所有的表
    public static ArrayList tables(int i) throws SQLException
    {
        ArrayList al = new ArrayList(); 
        DbAdapter db = new DbAdapter(i);
        try
        { 
            java.sql.ResultSet rs = db.executeQuery(" SHOW TABLES ",0,Integer.MAX_VALUE);//SELECT table_name FROM information_schema.tables WHERE " + (i == 1 ? "table_schema" : "table_catalog") + "=" + db.cite(db.conn.getCatalog()) + " AND table_type='BASE TABLE' AND table_name NOT IN('sysdiagrams','dtproperties') AND table_name NOT LIKE 'LeagueShop%' ORDER BY table_name",0,10000);
            while (rs.next())
            {
                al.add(rs.getString(1));
            }
            rs.close(); 
        } finally
        {
            db.close();
        }
        return al;
    }
    
    
    
}