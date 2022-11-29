package tea.entity.node;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.util.*;

public class Brand extends Entity
{
    public class Layer
    {
        public Layer()
        {
        }

        public String name;
        public String content;
        public String spell;
    }


    private static Cache _cache = new Cache(1000);
    private int brand;
    private boolean exists;
    private String community;
    private String logo;
    private boolean _blLoaded;
    private Hashtable _htLayer;
    private int sequence;
    private int company;
    private int node; // 品牌对应的节点

    // private float discounts; //折扣
    // private Date starttime; //折扣的开始日期
    // private Date stoptime; //折扣的结束日期

    public static Brand find(int brand)
    {
        Brand obj = (Brand) _cache.get(new Integer(brand));
        if(obj == null)
        {
            obj = new Brand(brand);
            _cache.put(new Integer(brand),obj);
        }
        return obj;
    }

    public Brand(int brand)
    {
        this.brand = brand;
        _blLoaded = false;
        _htLayer = new Hashtable();
    }

    public void set(String logo,String community,int company,int node,int sequence,int language,String name,String content) throws SQLException
    {
        if(this.isExists())
        {
            String spell = Spell.find(name.charAt(0)).getSpell();
            if(spell != null)
            {
                spell = String.valueOf(spell.charAt(0));
            }
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Brand SET logo=" + DbAdapter.cite(logo) + ",company=" + company + ",node=" + node + ",sequence=" + sequence + " WHERE brand=" + brand);
                int j = db.executeUpdate("UPDATE BrandLayer SET name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content) + ",spell=" + DbAdapter.cite(spell) + " WHERE brand=" + brand + " AND language=" + language);
                if(j < 1)
                {
                    db.executeUpdate("INSERT INTO BrandLayer(brand,language,name,content,spell)VALUES(" + brand + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(spell) + ")");
                }
            } finally
            {
                db.close();
            }
        } else
        {
            create(logo,community,company,node,sequence,language,name,content);
        }
        this.logo = logo;
        this.company = company;
        this.node = node;
        this.sequence = sequence;
        this.exists = true;
        _htLayer.clear();
    }

    // 根据node,查找对应的brand
    public static int findByNode(int node) throws SQLException
    {
        int brand = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT b.brand FROM Brand b INNER JOIN Node n ON b.node=n.node WHERE n.father=" + node);
            if(db.next())
            {
                brand = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return brand;
    }

    public static Enumeration findByMember(String member,String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT b.brand,b.sequence FROM Brand b,AdminUsrRole aur WHERE aur.member=" + DbAdapter.cite(member) + " AND aur.community=" + DbAdapter.cite(community) + " AND aur.brand LIKE '%/'+CAST(b.brand AS VARCHAR(10))+'/%' ORDER BY b.sequence");
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

    public static int countByCommunity(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(b.brand) FROM Brand b INNER JOIN BrandLayer bl ON b.brand=bl.brand WHERE b.community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT b.brand FROM Brand b INNER JOIN BrandLayer bl ON b.brand=bl.brand WHERE b.community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public static Enumeration findByCompany(int company) throws SQLException
    {
        Vector v = new Vector();
        String sql = ("SELECT DISTINCT b.brand FROM Brand b WHERE b.company=" + company);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql);
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

    public static Enumeration findByGoods(int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            String sql = ("SELECT DISTINCT b.brand FROM Brand b,Goods g,Node n WHERE g.brand LIKE '%/'+CAST(b.brand AS VARCHAR(50))+'/%' AND g.node=n.node AND n.father=" + node);
            db.executeQuery(sql);
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

    // 列出所有品牌,并品牌必须有商品
    public static Enumeration findByCommunity(String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        //String sql = ("SELECT DISTINCT b.brand FROM Brand b,Goods g WHERE g.brand LIKE " + db.concat("'%/'", db.cast("b.brand", "VARCHAR(50)"), "'/%'") + " AND g.node IN(SELECT node FROM Node WHERE community=" + DbAdapter.cite(community) + ")");
        String sql = ("select DISTINCT b.brand from Brand b,Goods g where b.brand=g.brand  and g.node in (select node from Node where community = " + db.cite(community) + ")");
        try
        {
            db.executeQuery(sql);
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
//如果没品牌添加
	public static int getBranid (String community,String sname)throws SQLException
	{
		   DbAdapter db = new DbAdapter();
		   int s = 0;
		   try
		   {
			   db.executeQuery("select brand   FROM Brand WHERE community="+db.cite(community)+" and brand in (select brand from BrandLayer where name = "+db.cite(sname)+") ");
			   if(db.next())
			   {
				   s= db.getInt(1);
			   }
		   }finally
		   {
			   db.close();
		   }
		   return s;
	}

    public static int create(String logo,String community,int company,int node,int sequence,int language,String name,String content) throws SQLException
    {
        int brand = 0;
        String spell = Spell.find(name.charAt(0)).getSpell();
        if(spell != null)
        {
            spell = String.valueOf(spell.charAt(0));
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Brand(logo,community,company,node,sequence)VALUES(" + DbAdapter.cite(logo) + "," + DbAdapter.cite(community) + "," + company + "," + node + "," + sequence + ")");
            brand = db.getInt("SELECT @@IDENTITY");
            // ////// 如果“设置品牌”权限呢,设置的用户为“全选”////////start////
            db.executeQuery("SELECT community,member FROM AdminUsrRole WHERE brand LIKE '/0/%'");
            while(db.next())
            {
                AdminUsrRole aur = AdminUsrRole.find(db.getString(1),db.getString(2));
                aur.setBrand(aur.getBrand() + brand + "/");
            } // ///end/////
            db.executeUpdate("INSERT INTO BrandLayer(brand,language,name,content,spell)VALUES(" + brand + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(spell) + ")");
        } finally
        {
            db.close();
        }
        return brand;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,content,spell FROM BrandLayer WHERE brand=" + brand + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,i,1);
                    layer.content = db.getVarchar(j,i,2);
                    layer.spell = db.getString(3);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM BrandLayer WHERE brand=" + brand);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Brand WHERE brand=" + brand);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(brand));
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT logo,community,company,node,sequence FROM Brand WHERE brand=" + brand);
                if(db.next())
                {
                    logo = db.getString(1);
                    community = db.getString(2);
                    company = db.getInt(3);
                    node = db.getInt(4);
                    sequence = db.getInt(5);
                    exists = true;
                } else
                {
                    exists = false;
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public int getBrand()
    {
        return brand;
    }

    public String getName() throws SQLException
    {
        return getName(1);
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public String getSpell(int language) throws SQLException
    {
        return getLayer(language).spell;
    }

    public String getContent(int language) throws SQLException
    {
        return getLayer(language).content;
    }

    public boolean isExists() throws SQLException
    {
        load();
        return exists;
    }

    public String getCommunity() throws SQLException
    {
        load();
        return community;
    }

    public String getLogo() throws SQLException
    {
        load();
        return logo;
    }

    public int getSequence() throws SQLException
    {
        load();
        return sequence;
    }

    public int getCompany() throws SQLException
    {
        load();
        return company;
    }

    public int getNode() throws SQLException
    {
        load();
        return node;
    }

}
