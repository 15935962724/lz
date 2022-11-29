package tea.entity.volunteer;

import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;

public class Volunteer extends Entity
{
    private int id;
    private String member;
    private String community;
    private String answer;
    private String xuanyan;
    private String zhiye;
    private String way;
    private Date times;
    private int type; //
    private String months; //导入时添加月份
    private int membertype;// 0 新注册会员 ，1 老志愿者已经登记 ， 2 没有登记过的职业者   ,3 导入的用户  ,4 快速注册用户
   
    

    public static String WAY[] =
            {"一月进医院","二月进影院","三月进车站","四月进学校","五月进社区","六月进公园","七月进工地","八月进宾馆","九月进商场","十月进单位"};

    public static String CITYS[] =
           // {"东城","西城","崇文","宣武","朝阳","海淀","丰台","石景山","门头沟","房山","昌平","大兴","顺义","通州","怀柔","密云","平谷","延庆"};
    {"东城","西城","朝阳","海淀","丰台","石景山","门头沟","房山","通州","顺义","大兴","昌平","平谷","怀柔","密云","延庆"};

    public static Volunteer find(String member) throws SQLException
    {
        return new Volunteer(member);
    }

    public Volunteer(String member) throws SQLException
    {
        this.member = member;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,member,community,answer,xuanyan,zhiye,type,way,times,months,membertype from Volunteer where member=" + db.cite(member));
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                member = db.getString(j++);
                community = db.getString(j++);
                answer = db.getString(j++);
                xuanyan = db.getString(j++);
                zhiye = db.getString(j++);
                type = db.getInt(j++);
                way = db.getString(j++);
                times = db.getDate(j++);
                months = db.getString(j++);
                membertype=db.getInt(j++);
            }
        } finally //
        {
            db.close();
        }
    }

    public static void set(String member,String community,String answer,String xuanyan,String zhiye,String way,int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select member from Volunteer where member=" + db.cite(member));
            if(db.next())
            {
                db.executeUpdate("Update Volunteer set  membertype ="+membertype+", answer =" + db.cite(answer) + ",xuanyan=" + db.cite(xuanyan) + ",zhiye= " + db.cite(zhiye) + ",way=" + db.cite(way) + " where member=" + db.cite(member));
            } else
            {
                db.executeUpdate("Insert into Volunteer(member,community,answer,xuanyan,zhiye,way,membertype) values(" + db.cite(member) + "," + db.cite(community) + "," + db.cite(answer) + "," + db.cite(xuanyan) + "," + db.cite(zhiye) + "," + db.cite(way) + ","+membertype+")");
            }
        } finally
        {
            db.close();
        }

    }


    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);

        try
        {
            db.executeQuery("SELECT member FROM Volunteer WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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


    public static Enumeration findByCommunityprofile(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);

        try
        {
            db.executeQuery("select member from profilelayer where  1=1  " + sql,pos,size);
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

    public static String getCITYS(String cityname)
    {
    	String c = null ;
    	for(int i=0;i<CITYS.length;i++)
    	{
    		if(CITYS[i].equals(cityname))
    		{
    			c =String.valueOf(i);
    		} 
    	} 
    	return c;
    }
    public static void typeIf(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date date = new Date();
        try
        {
            db.executeUpdate("update Volunteer set type=1,times=" + db.cite(date) + " where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }

    //导入时修改月份
    public static void typeMonth(String member,String month) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date date = new Date();
        try
        {
            db.executeUpdate("update Volunteer set months=" + db.cite(month) + " where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }

    public static void delete(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete Volunteer  where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }


    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(member) from  Volunteer  where  1=1 " + sql);
            if(db.next())
            {
                return db.getInt(1);
            } else
            {
                return 0;
            }
        } finally
        {
            db.close();
        }
    }


    public String getAnswer()
    {
        return answer;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public String getXuanyan()
    {
        return xuanyan;
    }

    public String getZhiye()
    {
        return zhiye;
    }

    public int getType()
    {
        return type;
    }

    public String getWay()
    {
        return way;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getMonths()
    {
        return months;
    }

    public String getTimesToString()
    {
        if(times == null)
        {
            return "";
        } else
        {
            return Volunteer.sdf.format(times);
        }
    }
    public int getMembertype()
    {
    	return membertype;
    }
}
