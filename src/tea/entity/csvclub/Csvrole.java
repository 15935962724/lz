package tea.entity.csvclub;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;


public class Csvrole extends Entity
{
    private String yonghuid; //姓名的拼音作为用户的ID
    private String xingming; //姓名
    private String dianhua; //办公室电话
    private String shouji; //手机
    private String youxiang; //电子邮箱
    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvrole(String yonghuid) throws SQLException
    {
        this.yonghuid = yonghuid;
        load();
    }

    public static Csvrole find(String yonghuid) throws SQLException
    {
        return new Csvrole(yonghuid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select F2,姓名,办公室电话,手机,电子邮箱 FROM 会员角色 where F2 =" + DbAdapter.cite(yonghuid));
            if (db.next())
            {

                yonghuid = db.getVarchar(1, 1, 1);
                xingming = db.getVarchar(1, 1, 2);
                dianhua = db.getVarchar(1, 1, 3);
                shouji = db.getVarchar(1, 1, 4);
                youxiang = db.getVarchar(1, 1, 5);

                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery(" select F2 from 会员角色 " + sql);

            while (dbadapter.next())
            {

                String yonghuid = dbadapter.getVarchar(1, 1, 1);
                vector.addElement(String.valueOf(yonghuid));
            }

        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public String getDianhua()
    {
        return dianhua;
    }

    public String getShouji()
    {
        return shouji;
    }

    public String getXingming()
    {
        return xingming;
    }

    public String getYonghuid()
    {
        return yonghuid;
    }

    public String getYouxiang()
    {
        return youxiang;
    }


}

