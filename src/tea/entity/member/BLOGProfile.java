package tea.entity.member;

import tea.entity.*;
import tea.db.DbAdapter;
import java.util.Hashtable;
import java.sql.SQLException;

public class BLOGProfile extends Entity
{
    class Layer
    {
        public Layer()
        {
        }

        public String nickname;
    }


    private static Cache _cache = new Cache(100);
    public Hashtable _htLayer;
    private String member;
    private String picture;
    private int width;
    private int height;

    public static BLOGProfile find(String member) throws SQLException
    {
        BLOGProfile profile = (BLOGProfile) _cache.get(member);
        if(profile == null)
        {
            profile = new BLOGProfile(member);
            _cache.put(member,profile);
        }
        return profile;
    }

    public BLOGProfile(String member) throws SQLException
    {
        this.member = member;
        _htLayer = new Hashtable();
        load();
    }

    public void set(String nickname,String picture,int width,int height) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("BLOGProfileEdit " + DbAdapter.cite(member) + "," + DbAdapter.cite(nickname) + "," + DbAdapter.cite(picture) + "," + width + "," + height);

            db.executeQuery("SELECT member FROM BLOGProfile WHERE member=" + DbAdapter.cite(member));
            if(db.next())
            {
                db.executeUpdate("UPDATE BLOGProfile SET nickname=" + DbAdapter.cite(nickname) + ",picture =" + DbAdapter.cite(picture) + " , width   =" + width + "   ,height  =" + height + "   WHERE member=" + DbAdapter.cite(member) + "");
            } else
            {
                db.executeUpdate("INSERT INTO BLOGProfile (member  ,nickname,picture ,width   ,height  )VALUES (" + DbAdapter.cite(member) + "  ," + DbAdapter.cite(nickname) + "," + DbAdapter.cite(picture) + " ," + width + "   ," + height + "  )");
            }
            _cache.remove(member);
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT picture,width,height FROM BLOGProfile WHERE member=" + DbAdapter.cite(member));
            if(db.next())
            {
                picture = db.getString(1);
                width = db.getInt(2);
                height = db.getInt(3);
            } else
            {
                width = 180;
                height = 120;
            }
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT nickname FROM BLOGProfile WHERE member=" + DbAdapter.cite(member));
                if(db.next())
                {
                    layer.nickname = db.getVarchar(1,i,1);
                } else
                {
                    layer.nickname = member;
                }
            } catch(Exception exception1)
            {
                throw new SQLException(exception1.toString());
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    public String getMember()
    {
        return member;
    }

    public String getNickname(int laguage) throws SQLException
    {
        return getLayer(laguage).nickname;
    }

    public String getPicture()
    {
        return picture;
    }

    public int getWidth()
    {
        return width;
    }

    public int getHeight()
    {
        return height;
    }
}
