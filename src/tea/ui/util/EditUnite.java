package tea.ui.util;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
//import tea.db.*;
import java.sql.*;

public class EditUnite extends HttpServlet
{
    //Process the HTTP Get request
    String SEPARATOR = System.getProperty("file.separator");
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        int add = Integer.parseInt(request.getParameter("add"));
        java.sql.Connection conn = null;
        java.sql.Statement statement = null, statement2 = null;
        java.sql.ResultSet resultset = null, resultset2 = null;

        String home = request.getParameter("home");
        try
        {
            Class.forName("com.inet.tds.TdsDriver");
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        try
        {
            String url = "jdbc:inetdae:" + request.getParameter("name") + ":" + request.getParameter("port") + "?database=\"" + request.getParameter("database") + "\"";
            conn = DriverManager.getConnection(url, request.getParameter("user"), request.getParameter("password"));
        } catch (Exception ex)
        {
            ex.printStackTrace();
            response.sendRedirect("/jsp/error/Exception.jsp");
            return;
        }
        try
        {
            statement = conn.createStatement();
            ///statement2 = conn.createStatement();
            resultset = statement.executeQuery("select name from sysobjects where xtype='U' order by name");
            while (resultset.next())
            {
                try
                {
                    statement = conn.createStatement();
                    resultset2 = statement.executeQuery("SELECT * FROM " + resultset.getString(1));
                    for (int i = 1; i < resultset2.getMetaData().getColumnCount(); i++)
                    {
                        String str = resultset2.getMetaData().getColumnName(i);
                        if (str.equals("node"))
                        {
                            System.out.println("Node:" + resultset.getString(1));
                            //statement.executeUpdate("update " + resultset.getString(1) + " set node=node+" + add);
                        } else if (str.equals("listing"))
                        {
                            System.out.println("listing:" + resultset.getString(1));
                            //statement.executeUpdate("update " + resultset.getString(1) + " set listing=listing+" + add);
                        } else if (str.equals("section"))
                        {
                            System.out.println("section:" + resultset.getString(1));
                            //statement.executeUpdate("update " + resultset.getString(1) + " set section=section+" + add);
                        }
                    }
                    resultset2.close();
                    statement.close();
                    statement = null;
                    resultset2 = null;
                    System.gc();
                    //System.out.println(resultset.getString(1));
                } catch (Exception ex2)
                {
                    ex2.printStackTrace();
                }
            }
            statement.executeUpdate("updata Node set father=father+" + add + " where father<>0");

            resultset = statement.executeQuery("SELECT node, path FROM Node");
            while (resultset.next())
            {
                String path = resultset.getString(2);
                java.util.StringTokenizer tokenizer = new StringTokenizer(path, "/");
                StringBuilder sb = new StringBuilder();
                while (tokenizer.hasMoreTokens())
                {
                    sb.append("/" + (Integer.parseInt(tokenizer.nextToken()) + add));
                }
                statement.executeUpdate("update Node set path='" + sb.toString() + "' where node=" + resultset.getString(1));
            }

            java.io.File[] files = new File(home + SEPARATOR + "tea" + SEPARATOR + "image" + SEPARATOR + "node").listFiles();
            for (int i = 0; i < files.length; i++)
            {
                String name = files[i].getName();
                int index = name.lastIndexOf(".");
                if (index != -1)
                {
                    String str = name.substring(0, index);
                    int iName = Integer.parseInt(str) + add;
                    files[i].renameTo(new File(files[i].getAbsolutePath() + files[i].separator + iName + name.substring(index + 1)));
                }
            }

            files = new File(home + SEPARATOR + "tea" + SEPARATOR + "image" + SEPARATOR + "section").listFiles();
            for (int i = 0; i < files.length; i++)
            {
                String name = files[i].getName();
                int index = name.lastIndexOf(".");
                if (index != -1)
                {
                    String str = name.substring(0, index);
                    int iName = Integer.parseInt(str) + add;
                    files[i].renameTo(new File(files[i].getAbsolutePath() + files[i].separator + iName + name.substring(index + 1)));

                    resultset = statement.executeQuery("SELECT text,section,language FROM SectionLayer");
                    while (resultset.next())
                    {
                        String value = new String(resultset.getString(1).getBytes("ISO-8859-1"));
                        statement.executeUpdate("UPDATE SectionLayer SET text='" + value.replaceAll(name, files[i].getName()) + "' WHERE section=" + resultset.getInt(2) + " AND language=" + resultset.getInt(3));
                    }

                    resultset = statement.executeQuery("SELECT beforeitem ,listing,language FROM ListingLayer");
                    while (resultset.next())
                    {
                        String value = new String(resultset.getString(1).getBytes("ISO-8859-1"));
                        statement.executeUpdate("UPDATE ListingLayer SET beforeitem='" + value.replaceAll(name, files[i].getName()) + "' WHERE listing=" + resultset.getInt(2) + " AND language=" + resultset.getInt(3));
                    }
                }
            }
        } catch (Exception ex1)
        {
            ex1.printStackTrace();
        } finally
        {
            try
            {
                if (conn != null)
                {
                    conn.close();
                }
                if (statement != null)
                {
                    statement.close();
                }
                if (resultset != null)
                {
                    resultset.close();
                }
            } catch (Exception e)
            {}
        }
        /*
                try
                {
          dbadapter.executeQuery("SELECT name FROM sysobjects sysobjects WHERE (status > 1024)");
          while (dbadapter.next())
          {
              dbadapter.executeQuery("select * from " + dbadapter.getString(1));
              dbadapter.executeUpdate("update Node set node=node+1000");
          }
                } catch (SQLException ex)
                {
          ex.printStackTrace();
                } finally
                {
          dbadapter.close();
                }*/
    }

    private void TransNode(int add)
    {
        //DbAdapter dbadapter=new DbAdapter();
        //dbadapter.executeUpdate("");
    }

}
/**
  EDN 多服务器 社区合并方案

 创建时间：2004-12-4
 创建人： 张良

 目的：将多服务器的社区合并到一台服务器上。

 实现步骤：
 一、备份各个系统数据库。
 二、 将要复制到其他机器上的数据库中 的Node，Listing, Section 的原标识列 是否标识设为“否” 这步会提示触发器问题 ，略过。
 三、.建立程序：
   将要合并到其他社区的数据库Node，Listing，Section的node，listing,section列 加一个数值，为避免与其他社区对应表重复。
 主要实现函数：
 (1) 节点转换函数
 TransNode（参数1： 节点号增加数）
  步骤：
 1. 将 Node表 node号加参数1；参考:update Node set node=node+1000
 2. 将 Section 表中的node列加参数1；
 3. 将 Listing  表中的node列加参数1；
 4. 将 Report、Book等各个类别对应的表中的node列加参数1；
 5. 将 sectionhide  表中的node列加参数1；
 6. 将Node表的father列不为零的行father值加参数1；
 7. 遍历Node表 取其中的Path值， 用“/”分出各个数字，分别加参数1然后再合并。更新原表该列。参考函数StringTokenizer（）
 8. 使用文件函数，遍历tea\image\node 下的文件，取得文件名列表（参考函数list（）），若文件名“.”前面的部分是数字，取出将数字加参数1，将该文件重命名。
 9.以上是主要改动 ，可以查看数据库中的所有表将其中含有node列的值都加参数1.
 (2) 段落转换函数
 TransSection（参数1：section增加数）
  步骤：
 1. 将 Section表 section号加参数1；
 2. 将 SectionLayer 表中的section列加参数1；
 3. 将 sectionhide  表中的node列加参数1；
 4. 由于该文件夹下的图片路径在源程序中被 大量使用。故需要查找NodeLayer表、
 SectionLayer表中的text列及ListingLayer表中用到图片路径的列，对其进行更新。
 使用文件函数，遍历tea\image\section 下的文件，取得文件名列表（参考函数list（）），
 作循环对每一个文件若文件名“.”前面的部分是数字，取出将数字加参数1，然后遍历NodeLayer表、SectionLayer表中的text列及ListingLayer表中用到图片路径的列，取出text列值，用replaceall函数将其中的 tea\image\section\旧数字.扩展名  替换成tea\image\section\旧数字+参数一.扩展名。 然后将该文件改名。
   这步是整个系统移植的关键步骤，用两重循环较耗时。如果这步成功，则移植工作就差不多了。
 将该文件重命名。
 (3) 列举转换函数
 TransListing（参数1：listing增加数）
  步骤：
 1. 将 Listing表 listing号加参数1；
 2. 将 LisingLayer 表中的listing列加参数1；
 4. 使用文件函数，遍历tea\image\section 下的文件，取得文件名列表（参考函数list（）），若文件名“.”前面的部分是数字，取出将数字加参数1，将该文件重命名。
 四、使用Sql server数据移植工具将数据移到 另一台服务器上。
 五、复制tea\image\下的文件到 另一台服务器。

 */
