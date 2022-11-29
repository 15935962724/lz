package tea.entity.admin;

import java.math.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class SubsidyMenu
{
    class Layer
    {
        Layer()
        {
        }

        private String name;
    }


    private Hashtable _htLayer;
    private static Cache _cache = new Cache(100);
    private int id;
    private boolean type;
    private int sequence;
    private int father;
    private boolean exists;
    private String community;
    private BigDecimal subsidy;
    private BigDecimal balance;
    private int useper;
    private String month;
    private BigDecimal earning;
    private BigDecimal totalearning;
    private BigDecimal payout;
    private BigDecimal totalpayout;
    private BigDecimal reality;

    public SubsidyMenu()
    {
    }

    public SubsidyMenu(int id) throws SQLException
    {
        _htLayer = new Hashtable();
        this.id = id;
        load();
    }

    public static SubsidyMenu find(int id) throws SQLException
    {
        SubsidyMenu obj = (SubsidyMenu) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new SubsidyMenu(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from SubsidyMenu where id=" + id);
            _cache.remove(new Integer(id));
        } finally
        {
            db.close();
        }
    }

    public void set(String name,boolean type,int sequence,int father,String community,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SubsidyMenu SET type =" + DbAdapter.cite(type) + ",sequence=" + (sequence) + " WHERE id=" + id);
            int j = db.executeUpdate("UPDATE SubsidyMenuLayer SET name=" + DbAdapter.cite(name) + "	WHERE id=" + id + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO SubsidyMenuLayer (id, language, name)VALUES (" + id + "," + language + "," + DbAdapter.cite(name) + ")");
            }
        } finally
        {
            db.close();
        }
        this.type = type;
        this.sequence = sequence;
        _htLayer.clear();
    }

    public void set(java.math.BigDecimal balance,java.math.BigDecimal subsidy) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SubsidyMenu SET balance=" + balance + ",subsidy=" + subsidy + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.subsidy = subsidy;
        this.balance = balance;
    }

    public void set(int useper,String month,java.math.BigDecimal earning,java.math.BigDecimal totalearning,java.math.BigDecimal payout,java.math.BigDecimal totalpayout,java.math.BigDecimal reality) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SubsidyMenuEdit3 " + id + "," + useper + "," + DbAdapter.cite(month) + "," + earning + "," + totalearning + "," + payout + "," + totalpayout + "," + reality);
        } finally
        {
            db.close();
        }
        this.useper = useper;
        this.month = month;
        this.earning = earning;
        this.totalearning = totalearning;
        this.payout = payout;
        this.totalpayout = totalpayout;
        this.reality = reality;
        _cache.remove(new Integer(id));
    }

    public static int create(String name,boolean type,int sequence,int father,String community,int language) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SubsidyMenu (type,sequence,father,community)VALUES(" + (type ? "1" : "0") + "," + sequence + "," + father + "," + DbAdapter.cite(community) + ")");
            id = db.getInt("SELECT MAX(id) FROM SubsidyMenu");
            db.executeUpdate("INSERT INTO SubsidyMenuLayer (id, language, name)VALUES(" + id + ", " + language + "," + DbAdapter.cite(name) + ")");
        } finally
        {
            db.close();
        }
        return id;
    }

    public BigDecimal getSubsidy()
    {
        return subsidy;
    }

    public BigDecimal getBalance()
    {
        return balance;
    }

    public static int getRootId(String community) throws SQLException
    {
        int j = 0;
        String sql = "SELECT id FROM SubsidyMenu WHERE community=" + DbAdapter.cite(community) + " AND father=0";
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt(sql);
        } finally
        {
            db.close();
        }
        if(j == 0)
        {
            j = create("ROOT",false,0,0,community,1);
        }
        return j;
    }

    public static void clone(int aimId,int sourceId,String community,boolean son) throws SQLException
    {
        SubsidyMenu obj = SubsidyMenu.find(sourceId);
        DbAdapter db = new DbAdapter();
        int newId = 0;
        try
        {
            db.executeUpdate("INSERT INTO SubsidyMenu(community, father, sequence,  type)VALUES(" + DbAdapter.cite(obj.getCommunity()) + "," + obj.getFather() + "," + obj.getSequence() + "," + DbAdapter.cite(obj.isType()) + ")");
            newId = db.getInt("SELECT MAX(id) FROM SubsidyMenu");
            db.executeUpdate("INSERT INTO SubsidyMenuLayer(id,language,name)VALUES(" + newId + "," + 1 + "," + obj.getName(1) + ")");
        } finally
        {
            db.close();
        }
        if(son)
        {
            java.util.Enumeration enumer = tea.entity.admin.SubsidyMenu.findByFather(sourceId);
            while(enumer.hasMoreElements())
            {
                clone(newId,((Integer) enumer.nextElement()).intValue(),community,true);
            }
        }
    }

    public static java.util.Enumeration findByFather(int father) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT id FROM SubsidyMenu WHERE father=" + (father) + " ORDER BY sequence");
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

    public static java.util.Enumeration findSon(int father) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Vector vector = new java.util.Vector();
        try
        {
            db.executeQuery("SELECT id FROM SubsidyMenu WHERE father=" + (father) + " ORDER BY sequence");
            while(db.next())
            {
                int id = db.getInt(1);
                vector.addElement(new Integer(id));
                java.util.Enumeration enumer = findSon(id);
                while(enumer.hasMoreElements())
                {
                    vector.addElement(enumer.nextElement());
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type,sequence,father,community,balance,subsidy,useper,month,earning,totalearning,payout,totalpayout,reality FROM SubsidyMenu WHERE id=" + id + " ORDER BY sequence");
            if(db.next())
            {
                type = db.getInt(1) != 0;
                sequence = db.getInt(2);
                father = db.getInt(3);
                community = db.getString(4);
                balance = db.getBigDecimal(5,2);
                subsidy = db.getBigDecimal(6,2);
                useper = db.getInt(7);
                month = db.getVarchar(1,1,8);
                earning = db.getBigDecimal(9,2);
                totalearning = db.getBigDecimal(10,2);
                payout = db.getBigDecimal(11,2);
                totalpayout = db.getBigDecimal(12,2);
                reality = db.getBigDecimal(13,2);
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

    public int getId()
    {
        return id;
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    private Layer getLayer(int language) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(language));
        if(layer == null)
        {
            layer = new Layer();
            int j = getLanguage(language);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name FROM SubsidyMenuLayer  WHERE id=" + id + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,language,1);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(language),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM SubsidyMenuLayer WHERE id=" + id);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public boolean isType()
    {
        return type;
    }

    public int getSequence()
    {
        return sequence;
    }

    public int getFather()
    {
        return father;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getUseper()
    {
        return useper;
    }

    public String getMonth()
    {
        return month;
    }

    public BigDecimal getEarning()
    {
        return earning;
    }

    public BigDecimal getTotalearning()
    {
        return totalearning;
    }

    public BigDecimal getPayout()
    {
        return payout;
    }

    public BigDecimal getTotalpayout()
    {
        return totalpayout;
    }

    public BigDecimal getReality()
    {
        return reality;
    }

    public BigDecimal getTotal() throws SQLException
    {
        return totalRecursion(id);
    }

    private java.math.BigDecimal totalRecursion(int id) throws SQLException
    {
        java.math.BigDecimal total = new java.math.BigDecimal(0D);
        java.util.Enumeration enumer = findByFather(id);
        while(enumer.hasMoreElements())
        {
            int son_id = ((Integer) enumer.nextElement()).intValue();
            tea.entity.admin.SubsidyMenu sm_obj = tea.entity.admin.SubsidyMenu.find(son_id);
            total = total.add(sm_obj.getBalance().add(sm_obj.getSubsidy()));
            if(!sm_obj.isType())
            {
                total = total.add(totalRecursion(son_id));
            }
        }
        return total;
    }

    public void setUseper(int useper) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SubsidyMenu SET useper=" + useper + " WHERE id=" + id);
            this.useper = useper;
        } finally
        {
            db.close();
        }
    }
}
