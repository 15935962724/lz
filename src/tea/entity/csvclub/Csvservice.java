package tea.entity.csvclub;

import java.math.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Csvservice extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final String SERVICE_TYPE[] =
                                                {"犬舍服务", "赛事服务", "繁殖服务", "其他服务"};
    public static final String SORT_TYPE[] =
        {"A", "B", "C", "D"};
    private static final java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyyMMdd");
    private int node;
    private int sequence;
    private Date time;
    private String content;
    private String community;
    private int name;
    private boolean exists;
    private BigDecimal outlay;
    private BigDecimal registeroutlay;
    private String sort;
    private int type;
    private int servicefrist; //服务前提的DI
    public static final String FRIST_NAME[] =
                                              {"-----", "同时申请犬舍，需要杂志", "同时申请犬舍，无需杂志", "不进行犬舍申请，需要杂志", "不进行犬舍申请，无需杂志"};
    public static final String FU_NAME[] =
                                           {"-----", "会员申请", "犬舍申请", "会员及犬舍申请"};


    public Csvservice(int node) throws SQLException
    {
        this.node = node;
        loadBasic();
    }
    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT community,sequence,time,outlay,name,content,type,registeroutlay,sort,servicefrist FROM Csvservice WHERE node=" + node);
            if (dbadapter.next())
            {
                community = dbadapter.getString(1);
                sequence = dbadapter.getInt(2);
                time = dbadapter.getDate(3);
                outlay = dbadapter.getBigDecimal(4, 2);
                name = dbadapter.getInt(5);
                content = dbadapter.getVarchar(1, 1, 6);
                type = dbadapter.getInt(7);
                registeroutlay = dbadapter.getBigDecimal(8, 2);
                sort = dbadapter.getString(9);
                servicefrist = dbadapter.getInt(10);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE Csvservice WHERE node=" + node);
        } finally
        {
            dbadapter.close();
        }
        exists = false;
        _cache.remove(new Integer(node));
    }

    public static void create(int node, String community, int sequence, Date time, BigDecimal outlay, int name, String content, BigDecimal registeroutlay, String sort, int type, int servicefrist) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvservice(node,community,sequence,time,outlay,name,content,registeroutlay,sort,type,servicefrist) VALUES(" + node + "," + dbadapter.cite(community) + "," + (sequence) + "," +
                                    dbadapter.cite(time) + "," + outlay + "," + name + "," + dbadapter.cite(content) + "," + registeroutlay + "," + dbadapter.cite(sort) + "," + type + "," + servicefrist + ")");

        } finally
        {
            dbadapter.close();
        }
    }

    public void set(int sequence, Date time, BigDecimal outlay, int name, String content, BigDecimal registeroutlay, String sort, int type, int servicefrist) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvservice SET sequence=" + sequence + ",time =" + dbadapter.cite(time) + ",outlay =" + outlay + ",name =" + (name) + ",content =" +
                                    dbadapter.cite(content) + ",registeroutlay =" + registeroutlay + ",sort =" + dbadapter.cite(sort) + ",type =" + type + " ,servicefrist=" + servicefrist + " WHERE node=" + node);
        } finally
        {
            dbadapter.close();
        }
        this.sequence = sequence;
        this.time = time;
        this.outlay = outlay;
        this.name = name;
        this.content = content;
        this.registeroutlay = registeroutlay;
        this.sort = sort;

        this.type = type;
        this.servicefrist = servicefrist;
    }

    public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT TOP " + (pos + pageSize) + " cs.node FROM Csvservice cs WHERE cs.community=" + dbadapter.cite(community) + sql);
            for (int l = 0; dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int node = dbadapter.getInt(1);
                    vector.addElement(new Integer(node));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(cs.node) FROM Csvservice cs WHERE cs.community=" + dbadapter.cite(community) + sql);
            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    public static Csvservice find(int node) throws SQLException
    {
        Csvservice obj = (Csvservice) _cache.get(new Integer(node));
        if (obj == null)
        {
            obj = new Csvservice(node);
            _cache.put(new Integer(node), obj);
        }
        return obj;
    }

    public int getNode()
    {
        return node;
    }

    public int getSequence()
    {
        return sequence;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    public String getTimeToString2()
    {

        return ymd.format(time);
    }

    public String getContent()
    {
        return content;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getName()
    {
        return name;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getOutlay()
    {
        return outlay;
    }

    public BigDecimal getRegisteroutlay()
    {
        return registeroutlay;
    }

    public String getSort()
    {
        return sort;
    }

    public int getType()
    {
        return type;
    }

    public int getServicefrist()
    {
        return servicefrist;
    }
}
