package tea.entity.member;

import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;


public class ProfileCondition extends Entity
{
    public ProfileCondition()
    {}

    public static Enumeration findByCondition(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            //查询出无角色权限的剩余用户人员的member
            db.executeQuery("SELECT t1.member FROM profile t1 LEFT JOIN adminusrrole t2 ON (t1.member = t2.member) WHERE t1.member NOT IN (SELECT member FROM adminusrrole WHERE PATINDEX('%[0-9]%', t2.role) > 0)" + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static String findValid(String member) throws SQLException
    {
        //创建DbAdapter实例
        String valid = "无";
        DbAdapter db = new DbAdapter();
        try
        {

            //返回一条SQL语句：查询valid的值
            db.executeQuery("SELECT valid FROM Profile WHERE member = " + db.cite(member));
            if(db.next())
            {
                valid = db.getString(1);
            }

        } finally
        {
            //关闭数据库连接
            db.close();
        }
        //返回结果valid的值
        return valid;
    }

    public static void updateValid(String member,int valid) throws SQLException
    {

        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //更新valid的值
            db.executeUpdate("UPDATE profile SET valid = " + valid + "WHERE member = '" + member + "'");
        } finally
        {
            //关闭数据库连接
            db.close();
        }

    }

    public static int count1(String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            i = db.getInt("select count(t1.member) from (SELECT t1.member FROM profile t1 LEFT JOIN adminusrrole t2 ON (t1.member = t2.member) WHERE t1.member NOT IN (SELECT member FROM adminusrrole WHERE PATINDEX('%[0-9]%', t2.role) > 0)) t1 where 1=1" + sql);
        } finally
        {
            db.close();
        }
        return i;
    }

}
