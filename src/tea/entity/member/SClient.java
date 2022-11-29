package tea.entity.member;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
public class SClient
{
    private String member;
    private BigDecimal price;
    private boolean exists;
    private static Cache _cache = new Cache(100);
    private static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm");
    private int area;
    private String community;
    private int point;
    public SClient(String community, String member) throws SQLException
    {
        this.community = community;
        this.member = member;
        loadBasic();
    }


    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT price,area,point FROM SClient  WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
            if (db.next())
            {
                price = db.getBigDecimal(1, 2);
                area = db.getInt(2);
                point = db.getInt(3);
                exists = true;
            } else
            {
                price = new java.math.BigDecimal("0");
                point = 0;
                exists = false;
            }} finally
        {
            db.close();
        }
    }

    public void set(int area) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            //db.executeUpdate("SClientEdit " + DbAdapter.cite(member) + "," +
            //		DbAdapter.cite(community) + "," + area);
        	db.executeQuery("SELECT price FROM SClient WHERE member="+ DbAdapter.cite(member) +" AND community="+DbAdapter.cite(community));
        	if(db.next())
        	{
        		db.executeUpdate("UPDATE SClient  SET  area="+area+" WHERE member="+DbAdapter.cite(member)+" AND community="+DbAdapter.cite(community) );
        	}else
        	{
        		db.executeUpdate("INSERT INTO SClient (member,community,price,area)VALUES ("+DbAdapter.cite(member)+","+DbAdapter.cite(community)+", 0,"+area+")");
        	}} finally
        {
            db.close();
        }
        _cache.remove(community + ":" + member);
    }

    public static SClient find(String community, String member) throws SQLException
    {
        SClient objSClient = (SClient) _cache.get(community + ":" + member);
        if (objSClient == null)
        {
            objSClient = new SClient(community, member);
            _cache.put(community + ":" + member, objSClient);
        }
        return objSClient;
    }

    public static java.util.Enumeration find(String community) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM SClient WHERE community=" + DbAdapter.cite(community) + " ORDER BY member");
            while (db.next())
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration find(String member, int address, java.util.Date from, java.util.Date to) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            StringBuilder from_sql = new StringBuilder(" FROM SClient,Profile");
            StringBuilder where_sql = new StringBuilder(" WHERE Profile.member=SClient.member");
            if (member != null && member.length() > 0)
            {
                where_sql.append(" AND SClient.member like '%" + member + "%' ");
            }
            if (address != 0)
            {
                from_sql.append(",Area");
                where_sql.append(" AND SClient.area=Area.id AND Area.father=" + address);
            }
            if (from != null || to != null)
            {
                if (from != null)
                {
                    where_sql.append(" AND Profile.time>=" + DbAdapter.cite(from));
                }
                if (to != null)
                {
                    where_sql.append(" AND Profile.time<" + DbAdapter.cite(to));
                }
            }
            db.executeQuery("SELECT DISTINCT SClient.member " + from_sql.toString() + where_sql.toString() + " ORDER BY SClient.member");
            while (db.next())
            {
                vector.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public int getArea()
    {
        return area;
    }

    public String getCommunity()
    {
        return community;
    }

    public void setPoint(int point) throws SQLException
    {
        this.point += point;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SClient SET point=" + this.point + " WHERE member=" + DbAdapter.cite(this.member) + " AND community=" + DbAdapter.cite(community));} finally
        {
            db.close();
        }
    }

    public int getPoint()
    {
        return point;
    }

    public java.util.Date getLastTime() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(signtime) FROM SOrder,Node WHERE Node.node=SOrder.node AND status=3 AND Node.rcreator=" + DbAdapter.cite(this.member));
            if (db.next())
            {
                return db.getDate(1);
            } else
            {
                return null;
            }} finally
        {
            db.close();
        }
    }

    public String getLastTimeToString() throws SQLException
    {
        java.util.Date time = getLastTime();
        if (time == null)
        {
            return "无";
        } else
        {
            return sdf.format(time);
        }
    }

    public void setPrice(BigDecimal price) throws SQLException
    {
        this.price = this.price.add(price);
//        System.out.println("UPDATE SClient SET price=" + this.price + " WHERE member=" + DbAdapter.cite(this.member) + " AND community=" + DbAdapter.cite(community));
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SClient SET price=" + this.price + " WHERE member=" + DbAdapter.cite(this.member) + " AND community=" + DbAdapter.cite(community));} finally
        {
            db.close();
        }
    }
}
