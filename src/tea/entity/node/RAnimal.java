package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class RAnimal
{
    protected static Cache c = new Cache(50);
    public int node;
    public int reserve; //保护区
    public String rcode;
    public String rname;
    public String code; //物种代码
    public String genus; //属名
    public String[] species = new String[2]; //种名
    public String[] family = new String[2]; //科名
    public String[] order = new String[2]; //目名
    public String alevel; //国家重点保护野生动物等级
    public String cites; //中国动物CITES公约名录等级
    public String rlevel; //红色名录等级
    public String picture;

    public RAnimal(int node)
    {
        this.node = node;
    }

    public static RAnimal find(int node) throws SQLException
    {
        RAnimal t = (RAnimal) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new RAnimal(node) : (RAnimal) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,reserve,rcode,rname,code,genus,species0,species1,family0,family1,order0,order1,alevel,cites,rlevel,picture FROM ranimal WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                RAnimal t = new RAnimal(rs.getInt(i++));
                t.reserve = rs.getInt(i++);
                t.rcode = rs.getString(i++);
                t.rname = rs.getString(i++);
                t.code = rs.getString(i++);
                t.genus = rs.getString(i++);
                t.species[0] = rs.getString(i++);
                t.species[1] = rs.getString(i++);
                t.family[0] = rs.getString(i++);
                t.family[1] = rs.getString(i++);
                t.order[0] = rs.getString(i++);
                t.order[1] = rs.getString(i++);
                t.alevel = rs.getString(i++);
                t.cites = rs.getString(i++);
                t.rlevel = rs.getString(i++);
                t.picture = rs.getString(i++);
                c.put(t.node,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM ranimal WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO ranimal(node,reserve,rcode,rname,code,genus,species0,species1,family0,family1,order0,order1,alevel,cites,rlevel,picture)VALUES(" + node + "," + reserve + "," + DbAdapter.cite(rcode) + "," + DbAdapter.cite(rname) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(genus) + "," + DbAdapter.cite(species[0]) + "," + DbAdapter.cite(species[1]) + "," + DbAdapter.cite(family[0]) + "," + DbAdapter.cite(family[1]) + "," + DbAdapter.cite(order[0]) + "," + DbAdapter.cite(order[1]) + "," + DbAdapter.cite(alevel) + "," + DbAdapter.cite(cites) + "," + DbAdapter.cite(rlevel) + "," + DbAdapter.cite(picture) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE ranimal SET reserve=" + reserve + ",rcode=" + DbAdapter.cite(rcode) + ",rname=" + DbAdapter.cite(rname) + ",code=" + DbAdapter.cite(code) + ",genus=" + DbAdapter.cite(genus) + ",species0=" + DbAdapter.cite(species[0]) + ",species1=" + DbAdapter.cite(species[1]) + ",family0=" + DbAdapter.cite(family[0]) + ",family1=" + DbAdapter.cite(family[1]) + ",order0=" + DbAdapter.cite(order[0]) + ",order1=" + DbAdapter.cite(order[1]) + ",alevel=" + DbAdapter.cite(alevel) + ",cites=" + DbAdapter.cite(cites) + ",rlevel=" + DbAdapter.cite(rlevel) + ",picture=" + DbAdapter.cite(picture) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM ranimal WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE ranimal SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }



}
