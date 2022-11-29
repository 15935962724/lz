package tea.ui.util;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import tea.db.DbAdapter;

public class PictureClean extends HttpServlet
{
    DbAdapter dbadapter = new DbAdapter();
    DbAdapter dbadapter2 = new DbAdapter();
    DbAdapter dbadapter3 = new DbAdapter();

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public synchronized void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            File file = new File(getServletContext().getRealPath("/tea/image/section"));
            File[] files = file.listFiles();
            for (int index = 0; index < files.length; index++)
                if (files[index].isFile() && !searchDB(files[index].getName()))
                    files[index].delete();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
            dbadapter3.close();
            dbadapter2.close();
        }
        //clean("/tea/image/section", tableName.toString(), vector);
        response.sendRedirect("/jsp/optimize/Optimize.jsp");
    }

    private synchronized boolean searchDB(String fileName)
    {
        try
        {
            dbadapter.executeQuery("select name from sysobjects where xtype='U' order by name");
            while (dbadapter.next())
            {
                String table = dbadapter.getString(1);
                StringBuilder whereSql = new StringBuilder();
                dbadapter2.executeQuery("sp_columns " + table);
                while (dbadapter2.next())
                {
                    String dataType = dbadapter2.getString(6);
                    if (dbadapter2.getInt(8) > 30 && (dataType.equals("text") || dataType.equals("varchar") || dataType.equals("varchar")))
                    {
                        whereSql.append(table + ".[" + dbadapter2.getString(4) + "] like '%/tea/image/section/" + fileName + "%' OR ");
                    }
                }
                if (whereSql.length() > 3)
                {
                    dbadapter3.executeQuery("SELECT COUNT(*) FROM " + table + " where " + whereSql.substring(0, whereSql.length() - 3));
                    dbadapter3.next();
                    if (dbadapter3.getInt(1) > 0)
                        return true;
                }
            }
            return false;
        } catch (Exception ex)
        {
            ex.printStackTrace();
            return true;
        }

    }

    private void clean(String path, String selectsql, java.util.Vector vector)
    {
        try
        {
            DbAdapter dbadapter = new DbAdapter();
            File file = new File(getServletContext().getRealPath(path));
            File[] files = file.listFiles();
            for (int index = 0; index < files.length; index++)
            {
                if (files[index].isFile())
                {
                    java.util.Enumeration wheresql = vector.elements();
                    StringBuilder where = new StringBuilder();
                    while (wheresql.hasMoreElements())
                    {
                        where.append(wheresql.nextElement().toString() + "'%" + path + "/" + files[index].getName() + "%' OR ");
                    }
                    dbadapter.executeQuery(selectsql + " " + where.substring(0, where.length() - 3));
                    if (dbadapter.next())
                    {
                        int sum = dbadapter.getInt(1);
                        if (sum == 0)
                            System.out.println(files[index].getName() + "\t" + files[index].getPath());
                    }
                }
            }
            dbadapter.close();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
