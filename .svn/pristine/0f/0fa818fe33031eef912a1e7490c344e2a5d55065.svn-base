package tea.entity.csvclub.testing;


import tea.entity.Entity;
import java.sql.*;
import java.io.*;
import java.util.*;
import java.io.*;
import tea.htmlx.*;
import javax.servlet.*;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Enumeration;
import java.util.Set;

public class Searchpic extends Entity
{
    private String path; //路径
    private String name; //文件名
    private String namebf; //  文件名的某一部分


    public Searchpic()
    {
    }

    ///判断文件名称是否存在
    public static boolean isCSvpic(String path, String name) throws SQLException
    {
        ///public static  boolean isCSvpic(ServletContext app,String path,String name)throws SQLException
        ///File f1 = new File(app.getRealPath(path));
        ///File[] fa = f1.listFiles();
        boolean falg = false;
        File f1 = new File(tea.resource.Common.REAL_PATH + path);
        File[] fa = f1.listFiles();
        int len = 0;
        String strs = "";
        String csvdogname =null ;
        if (f1.exists())
        {
            if (fa.length > 0)
            {
                for (int index = 0; index < fa.length; index++)
                {
                    strs = fa[index].toString();
                    len = (tea.resource.Common.REAL_PATH + "/").length();
                    strs = strs.substring(len - 1);
                    csvdogname = fa[index].getName();
                    csvdogname.lastIndexOf(".");
                    if (csvdogname.lastIndexOf(".") != -1)
                    {
                        csvdogname = csvdogname.substring(0, csvdogname.lastIndexOf("."));
                    }

                    if (csvdogname.lastIndexOf("_") != -1)
                    {
                        String strall[] = csvdogname.split("_");
                        if (strall.length > 1)
                        {
                            if (strall[1].equals(name))
                            {
                                return true;
                            } else
                            {
                                falg= false;
                            }
                        } else
                        {
                            falg= false;
                        }
                    } else
                    {
                        falg= false;
                    }
                }
            }
        }
        return falg;
    }

    public static String  getHandpic(String path, String name) throws SQLException
   {
       ///public static  boolean isCSvpic(ServletContext app,String path,String name)throws SQLException
       ///File f1 = new File(app.getRealPath(path));
       ///File[] fa = f1.listFiles();
       boolean falg = false;
       File f1 = new File(tea.resource.Common.REAL_PATH + path);
       File[] fa = f1.listFiles();
       int len = 0;
       String strs = "";
       String  str_info= "/res/csvclub/u/0802/no_photo.jpg";
       String csvdogname =null ;
       if (f1.exists())
       {
           if (fa.length > 0)
           {
               for (int index = 0; index < fa.length; index++)
               {
                   strs = fa[index].toString();
                   len = (tea.resource.Common.REAL_PATH + "/").length();
                   strs = strs.substring(len - 1);
                   csvdogname = fa[index].getName();
                   csvdogname.lastIndexOf(".");
                   if (csvdogname.lastIndexOf(".") != -1)
                   {
                       csvdogname = csvdogname.substring(0, csvdogname.lastIndexOf("."));
                   }

                   if (csvdogname.lastIndexOf("_") != -1)
                   {
                       String strall[] = csvdogname.split("_");
                       if (strall.length > 1)
                       {
                           if (strall[1].equals(name))
                           {
                               return strs;
                           } else
                           {
                               str_info= "/res/csvclub/u/0802/no_photo.jpg";
                           }
                       } else
                       {
                           str_info= "/res/csvclub/u/0802/no_photo.jpg";
                       }
                   } else
                   {
                     str_info= "/res/csvclub/u/0802/no_photo.jpg";
                   }
               }
           }
       }
       return str_info;
   }

}
