package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class RPlant
{
    protected static Cache c = new Cache(50);
    public int node;
    public int reserve; //保护区
    public String rname;
    public String rcode;
    public String[] species = new String[2]; //拉丁名,中文名
    public String[] family = new String[2]; //科名
    public String genus; //属名
    public String speciesauthor; //种名作者
    public String mutation; //种下名称
    public String mutationauthor; //种下名称作者
    public String areas; //分布
    public int id;
    public RPlant(int node)
    {
        this.node = node;
    }

    public static RPlant find(int node) throws SQLException
    {
        RPlant t = (RPlant) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new RPlant(node) : (RPlant) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,reserve,rname,rcode,species0,species1,family0,family1,genus,speciesauthor,mutation,mutationauthor,areas,id FROM plant WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                RPlant t = new RPlant(rs.getInt(i++));
                t.reserve = rs.getInt(i++);
                t.rname = rs.getString(i++);
                t.rcode = rs.getString(i++);
                t.species[0] = rs.getString(i++);
                t.species[1] = rs.getString(i++);
                t.family[0] = rs.getString(i++);
                t.family[1] = rs.getString(i++);
                t.genus = rs.getString(i++);
                t.speciesauthor = rs.getString(i++);
                t.mutation = rs.getString(i++);
                t.mutationauthor = rs.getString(i++);
                t.areas = rs.getString(i++);
                t.id = rs.getInt(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM plant WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO plant(node,reserve,rname,rcode,species0,species1,family0,family1,genus,speciesauthor,mutation,mutationauthor,areas)VALUES(" + node + "," + reserve + "," + DbAdapter.cite(rname) + "," + DbAdapter.cite(rcode) + "," + DbAdapter.cite(species[0]) + "," + DbAdapter.cite(species[1]) + "," + DbAdapter.cite(family[0]) + "," + DbAdapter.cite(family[1]) + "," + DbAdapter.cite(genus) + "," + DbAdapter.cite(speciesauthor) + "," + DbAdapter.cite(mutation) + "," + DbAdapter.cite(mutationauthor) + "," + DbAdapter.cite(areas) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE plant SET reserve=" + reserve + ",rname=" + DbAdapter.cite(rname) + ",rcode=" + DbAdapter.cite(rcode) + ",species0=" + DbAdapter.cite(species[0]) + ",species1=" + DbAdapter.cite(species[1]) + ",family0=" + DbAdapter.cite(family[0]) + ",family1=" + DbAdapter.cite(family[1]) + ",genus=" + DbAdapter.cite(genus) + ",speciesauthor=" + DbAdapter.cite(speciesauthor) + ",mutation=" + DbAdapter.cite(mutation) + ",mutationauthor=" + DbAdapter.cite(mutationauthor) + ",areas=" + DbAdapter.cite(areas) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM plant WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE plant SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        c.remove(node);
    }



}
