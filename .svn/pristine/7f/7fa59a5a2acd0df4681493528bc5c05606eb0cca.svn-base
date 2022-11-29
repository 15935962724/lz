package tea.entity.node;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Forum
{
    private static Cache _cache = new Cache(100);
    private boolean exists;
    private String community;
    private String auditing; //已审核会员可发贴
    private String sleep;
    private int wait;
    private int hot = 1000;
    private int sending = 1000; //专家赠送积分
    private String valid; //已邮件验证会员可发贴
    private String regview; //只有注册会员可看
    private String vertify; //发贴是否要验证码
    private boolean sort; //贴子排序,false:desc, true:asc
    private float sizes; //附件大小
    private String ext; //附件格式
    public Forum()
    {

    }

    public static Forum find(String community) throws SQLException
    {
        Forum obj = (Forum) _cache.get(community);
        if(obj == null)
        {
            obj = new Forum(community);
            _cache.put(community,obj);
        }
        return obj;
    }

    public static Enumeration findByCommunity(String community) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n,Category c WHERE n.node=c.node AND n.type=1 AND c.category=57 AND n.community=" + DbAdapter.cite(community));
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void set(String auditing,String sleep,int wait,int hot,int sending,String valid,String vertify,String regview,boolean sort,float sizes,String ext) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community FROM Forum WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                db.executeUpdate("UPDATE Forum SET auditing=" + DbAdapter.cite(auditing) + ",sleep=" + DbAdapter.cite(sleep) + ",wait=" + wait + ",hot=" + hot + ",sending=" + sending + ",valid=" + DbAdapter.cite(valid) + ",vertify=" + DbAdapter.cite(vertify) + ",regview=" + DbAdapter.cite(regview) + ",sort=" + DbAdapter.cite(sort) + ",sizes=" + sizes + ",ext=" + DbAdapter.cite(ext) + " WHERE community=" + DbAdapter.cite(community));
            } else
            {
                db.executeUpdate("INSERT INTO Forum (community, auditing, sleep, wait,hot,sending,valid,vertify,regview,sort,sizes,ext) VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(auditing) + ", " + DbAdapter.cite(sleep) + ", " + wait + "," + hot + "," + sending + "," + DbAdapter.cite(valid) + "," + DbAdapter.cite(vertify) + "," + DbAdapter.cite(regview) + "," + DbAdapter.cite(sort) + "," + sizes + "," + DbAdapter.cite(ext) + ")");
            }
        } finally
        {
            db.close();
        }
        this.auditing = auditing;
        this.sleep = sleep;
        this.wait = wait;
        this.hot = hot;
        this.sending = sending;
        this.valid = valid;
        this.vertify = vertify;
        this.regview = regview;
        this.sort = sort;
        this.sizes = sizes;
        this.ext = ext;
    }

    public Forum(String community) throws SQLException
    {
        this.community = community;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT auditing,sleep,wait,hot,sending,valid,vertify,regview,sort,sizes,ext FROM Forum WHERE community= " + DbAdapter.cite(community));
            if(db.next())
            {
                auditing = db.getString(1);
                sleep = db.getString(2);
                wait = db.getInt(3);
                hot = db.getInt(4);
                sending = db.getInt(5);
                valid = db.getString(6);
                vertify = db.getString(7);
                regview = db.getString(8);
                sort = db.getInt(9) != 0;
                sizes = db.getFloat(10);
                ext = db.getString(11);
                exists = true;
            } else
            {
                sizes = 5;
                ext = "chm,pdf,zip,rar,gif,jpg,jpeg,png";
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public String getCommunity()
    {
        return community;
    }

    public String getAuditing()
    {
        return auditing;
    }

    public String getSleep()
    {
        return sleep;
    }

    public int getWait()
    {
        return wait;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getValidate()
    {
        return valid;
    }

    public String getRegview()
    {
        return regview;
    }

    public boolean isSort()
    {
        return sort;
    }

    public String getVertify()
    {
        return vertify;
    }

    public int getHot()
    {
        return hot;
    }

    public int getSending()
    {
        return sending;
    }

    public float getSize()
    {
        return sizes;
    }

    public String getExt()
    {
        return ext;
    }

}
