package tea.entity.eon;

import java.math.*;
import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;

public class EonNode extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    private boolean side; //false:服务方收费_主叫,true:被服务方收费_被叫
    private BigDecimal price;
    private String member;
    private boolean extend;
    private boolean reg;
    private String introduce;
    private boolean father; //是否存在父节点的设置
    private boolean exists;
    public EonNode(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    public static EonNode find(int node) throws SQLException
    {
        EonNode obj = (EonNode) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new EonNode(node);
            _cache.put(new Integer(node),obj);
        }
        if(obj.extend)
        {
            int i = Node.find(node).getFather();
            if(i > 0)
            {
                EonNode en = find(i);
                boolean tmp = en.isExists();
                if(tmp)
                {
                    obj.father = true;
                    if(!obj.extend)
                    {
                        obj.side = en.side;
                        obj.price = en.price;
                        //member=en.member;
                        obj.introduce = en.introduce;
                        obj.exists = true;
                    }
                }
            }
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT side,price,member,extend,reg,introduce FROM EonNode WHERE node=" + node);
            if(db.next())
            {
                side = db.getInt(1) != 0;
                price = db.getBigDecimal(2,2);
                member = db.getString(3);
                extend = db.getInt(4) != 0;
                reg = db.getInt(5) != 0;
                introduce = db.getString(6);
                exists = true;
            } else
            {
                price = new BigDecimal("0.10");
                member = "/" + Node.find(node).getCreator()._strV + "/";
                extend = true;
                reg = false;
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM EonNode WHERE node=" + node);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
    }

    public void set(boolean side,BigDecimal price,boolean extend,boolean reg,String introduce) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE EonNode SET side=" + DbAdapter.cite(side) + ",price=" + price + ",extend=" + DbAdapter.cite(extend) + ",reg=" + DbAdapter.cite(reg) + ",introduce=" + DbAdapter.cite(introduce) + " WHERE node=" + node);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO EonNode(node,side,price,member,extend,reg,introduce) VALUES (" + node + "," + DbAdapter.cite(side) + ", " + price + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(extend) + "," + DbAdapter.cite(reg) + "," + DbAdapter.cite(introduce) + ")");
            }
        } finally
        {
            db.close();
        }
        this.side = side;
        this.price = price;
        this.extend = extend;
        this.reg = reg;
        this.introduce = introduce;
        this.exists = true;
    }

    public void setMember(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE EonNode SET member=" + DbAdapter.cite(member) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.member = member;
    }


    public static int count(String member,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(node) FROM EonNode WHERE member=" + DbAdapter.cite(member) + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration find(String member,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM EonNode WHERE member=" + DbAdapter.cite(member) + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public boolean isFather()
    {
        return father;
    }

    public boolean isSide()
    {
        return side;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public String getPriceToString()
    {
        return df.format(price);
    }

    public int getNode()
    {
        return node;
    }

    public String getIntroduce()
    {
        return introduce;
    }

    public boolean isExtend()
    {
        return extend;
    }

    public boolean isReg()
    {
        return reg;
    }
}
