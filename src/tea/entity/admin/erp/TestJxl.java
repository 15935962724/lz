package tea.entity.admin.erp;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import jxl.*;
import jxl.write.*;

public class TestJxl
{
    /*public static void main(String[] args)
    {
        try
        {
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy/MM/dd   HH:mm:ss");
            java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
            List l = new ArrayList();
            List o = new ArrayList();
            Workbook info = Workbook.getWorkbook(new File("f:/2006FootBall.xls"));
            Sheet sheet = info.getSheet(0);
            int size = sheet.getRows();
            //size   =   1;
            for(int i = 0;i < size;i++)
            {
                Cell c = sheet.getCell(0,i);
                String c1 = c.getContents();
                c = sheet.getCell(1,i);
                String c2 = c.getContents();
                c = sheet.getCell(2,i);
                String c3 = c.getContents();
                c = sheet.getCell(3,i);
                String c4 = c.getContents();
                c = sheet.getCell(4,i);
                String c5 = c.getContents();
                c = sheet.getCell(5,i);
                String c6 = c.getContents();

                if(c3.equals("090000"))
                {
                    c3 = "210000";
                } else if(c3.equals("100000"))
                {
                    c3 = "220000";
                } else if(c3.equals("110000"))
                {
                    c3 = "220000";
                } else if(c3.equals("120000"))
                {
                    c3 = "000000";
                }
                System.out.print(c1);
                System.out.print("\t" + c2);
                System.out.print("\t" + c3);
                System.out.print("\t" + c4);
                System.out.print("\t" + c5);
                System.out.println("\t" + c6);
                l.add(c1 + "," + c2 + "," + c3 + "," + c4 + "," + c5 + "," + c6);
            }
            info.close();

            size = l.size();
            //size   =   1;
            System.out.println(size);
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            String submit = "null";
            try
            {
                conn = getMysqlConnection("jdbc:mysql://localhost:3306/ddsms?useUnicode=true&characterEncoding=GBK","test","test");
                stmt = conn.createStatement();
                for(int i = 0;i < size;i++)
                {
                    //System.out.println(l.get(i));
                    String[] m = l.get(i).toString().split(",");

                    String sql = "insert   into   ddsms.match_info(match_name,match_id,match_date,match_time,match_addr,match_group,match_info,match_result,match_status,submit_time,update_time)"
                                 + "   values('2006年足球世界杯','" + m[0] + "','" + m[1] + "','" + m[2] + "','" + m[3] + "','" + m[5] + "','" + m[4] + "','',1,now(),now())";
                    //System.out.println(sql);
                    stmt.executeUpdate(sql);
                }
            } catch(Exception exx)
            {
                exx.printStackTrace();
            } finally
            {
                try
                {
                    if(rs != null)
                    {
                        rs.close();
                    }
                    if(stmt != null)
                    {
                        stmt.close();
                    }
                    rs = null;
                    stmt = null;
                } catch(Exception exxx)
                {
                }
            }
            closeConnection(conn);
            conn = null;

            //createXLS(o,"f:","1_ok.xls");
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }*/

    public static boolean createXLS(List l,String path,String filename)
    {
        boolean flag = true;
        WritableWorkbook info = null;
        WritableSheet sheet = null;
        Label c = null;
        try
        {
            String file = path + "/" + filename;
            File f = new File(file);
            info = Workbook.createWorkbook(f);
            sheet = info.createSheet("ok",0);

            int size = l.size();
            for(int i = 0;i < size;i++)
            {
                String[] msg = l.get(i).toString().split("/");
                c = new Label(0,i,msg[0]);
                sheet.addCell(c);
                c = new Label(1,i,msg[1]);
                sheet.addCell(c);
                c = new Label(2,i,msg[2]);
                sheet.addCell(c);
                c = new Label(3,i,msg[3]);
                sheet.addCell(c);
            }
            info.write();
        } catch(Exception ex)
        {
            flag = false;
            ex.printStackTrace();
        } finally
        {
            try
            {
                if(info != null)
                {
                    info.close();
                }
            } catch(Exception exx)
            {
            }
        }
        return flag;
    }

    private static Connection getOracleConnection(String dburl,String dbuser,String dbpass)
    {
        Connection conn = null;
        try
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(dburl,dbuser,dbpass);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return conn;
    }

    private static Connection getMysqlConnection(String dburl,String dbuser,String dbpass)
    {
        Connection conn = null;
        try
        {
            Class.forName("org.gjt.mm.mysql.Driver").newInstance();
            conn = DriverManager.getConnection(dburl,dbuser,dbpass);
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return conn;
    }

    private static void closeConnection(Connection conn)
    {
        try
        {
            if(conn != null)
            {
                conn.close();
            }
            conn = null;
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}


