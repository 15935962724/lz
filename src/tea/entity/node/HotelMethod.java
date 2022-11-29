package tea.entity.node;

import java.sql.*;
import tea.db.*;
import tea.entity.*;
import java.util.Vector;
import java.util.Enumeration;

public class HotelMethod
{

    public static String findRcMobile(String rcreator) throws SQLException
    {
        //创建DbAdapter实例
        String mobile = "无";
        DbAdapter db = new DbAdapter();
        try
        {

            //返回一条SQL语句：根据催办人姓名查询出催办人联系电话的结果集
            db.executeQuery("SELECT mobile FROM Profile WHERE member = " + db.cite(rcreator));
            if(db.next())
            {
                mobile = db.getString(1);
            }

        } finally
        {
            //关闭数据库连接
            db.close();
        }
        //返回结果管理员的数据
        return mobile;
    }

    public static String findRcEmail(String rcreator) throws SQLException
    {
        //创建DbAdapter实例
        String email = "无";
        DbAdapter db = new DbAdapter();
        try
        {

            //返回一条SQL语句：根据催办人姓名查询出催办人Email的结果集
            db.executeQuery("SELECT email FROM Profile WHERE member = " + db.cite(rcreator));
            if(db.next())
            {
                email = db.getString(1);
            }

        } finally
        {
            //关闭数据库连接
            db.close();
        }
        //返回结果管理员的数据
        return email;
    }


    public static int create(int destine,int node,String hotelName,String rcreator,String doMethod,String remark) throws SQLException
    {
        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入催办信息的结果集
            return db.executeUpdate("INSERT INTO DestineorderInfo VALUES(" + destine + ", " + node + ", " + db.cite(hotelName) + ", " + db.cite(rcreator) + ", " + db.cite(doMethod) + ", " + db.cite(remark) + ", getDate())");
        } finally
        {
            //关闭数据库连接
            db.close();
        }
    }

    public static Enumeration findCbInfo(int pos,int size) throws SQLException
    {
        //创建相关集合类的对象
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            //查询出订单编号
            db.executeQuery("SELECT destine FROM DestineorderInfo",pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        //返回此集合
        return v.elements();
    }

}
