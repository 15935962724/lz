package tea.entity.node;

import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;


public class TypePicture extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int id;
    private String picture; //小图
    private String picname;
    private String picture2; //大图
    private boolean _bLoadBase;
    private int width;
    private int height;
    private boolean exists;
    private TypePicture()
    {
    }

    public TypePicture(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static void create(int node,int width,int height,String picture,String picname,String picture2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO TypePicture(node,width,height,picture,picname,picture2)VALUES(" +
                             node + "," + width + "," + height + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(picname) + "," + DbAdapter.cite(picture2) + ")");
        } finally
        {
            db.close();
        }
    }

    public int getNode()
    {
        return node;
    }

    public int getId()
    {
        return id;
    }

    public String getPicture()
    {
        return picture;
    }

    public String getPicname()
    {
        return picname;
    }

    public void set(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE TypePicture SET node =" + node + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.node = node;
    }

    public int getWidth()
    {
        return width;
    }

    public int getHeight()
    {
        return height;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getPicture2()
    {
        return picture2;
    }

    public static TypePicture findByPrimaryKey(int id) throws SQLException
    {
        TypePicture obj = (TypePicture) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new TypePicture(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public static Enumeration findByNode(int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM TypePicture WHERE node=" + node);
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

    public static ArrayList findByNode(int node,int p,int s) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,node,width,height,picture,picname,picture2 FROM TypePicture WHERE node=" + node,p,s);
            while(db.next())
            {
                TypePicture tp = new TypePicture();
                tp.id = db.getInt(1);
                tp.node = db.getInt(2);
                tp.width = db.getInt(3);
                tp.height = db.getInt(4);
                tp.picture = db.getString(5);
                tp.picname = db.getVarchar(1,1,6);
                tp.picture2 = db.getString(7);
                tp.exists = true;
                al.add(tp);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM TypePicture WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.exists = false;
        _cache.remove(new Integer(id));
    }

    public void set(int width,int height,String picture,String picname,String picture2) throws SQLException
    {
        StringBuffer sql = new StringBuffer();
        sql.append("UPDATE TypePicture SET width=" + width + ",height=" + height + ",picname=" + DbAdapter.cite(picname));
        if(picture != null)
        {
            sql.append(",picture=" + DbAdapter.cite(picture));
            this.picture = picture;
        }
        if(picture2 != null)
        {
            sql.append(",picture2=" + DbAdapter.cite(picture2));
            this.picture2 = picture2;
        }
        sql.append(" WHERE id=" + id);
        DbAdapter.execute(sql.toString());
        this.width = width;
        this.height = height;
        this.picname = picname;
    }

    private void load() throws SQLException
    {
        if(!_bLoadBase)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT node,width,height,picture,picname,picture2 FROM TypePicture WHERE id=" + id);
                if(db.next())
                {
                    node = db.getInt(1);
                    width = db.getInt(2);
                    height = db.getInt(3);
                    picture = db.getString(4);
                    picname = db.getVarchar(1,1,5);
                    picture2 = db.getString(6);
                    exists = true;
                } else
                {
                    exists = false;
                }
            } finally
            {
                db.close();
            }
            _bLoadBase = true;
        }
    }
}
