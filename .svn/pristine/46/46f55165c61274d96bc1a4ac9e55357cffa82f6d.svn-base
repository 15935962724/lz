package tea.entity.member;

import java.io.*;
import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class ProfileBBS implements Serializable
{
    private static Cache _cache = new Cache(100);
    public static final String CALL_SOUND[] =
            {"-----------","语音1","语音2","激光","水滴","手机","电话","鸡叫","OICQ"}; // 提示音
    private Hashtable _htLayer;
    private String member;
    private String community;
    private boolean valid;
    private boolean message; // 提醒窗口弹出方式
    private int callsound = 1; // 提示音
    private String serialnum; //Key序列号
    public int post; //发贴数量
    public int reply; //回贴数量
    private boolean exists;
    class Layer
    {
        private String title;
        private String portrait; //头像
        private String signature;
        private String isign; //会员上传的签字图片
    }


    public ProfileBBS(String community,String member) throws SQLException
    {
        this.community = community;
        this.member = member;
        _htLayer = new Hashtable();
        load();
    }

    public static ProfileBBS find(String community,String member) throws SQLException
    {
        ProfileBBS obj = (ProfileBBS) _cache.get(community + ":" + member);
        if(obj == null)
        {
            obj = new ProfileBBS(community,member);
            _cache.put(community + ":" + member,obj);
        }
        return obj;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT title,portrait,signature,isign FROM ProfileBBSLayer WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND language=" + j);
                if(db.next())
                {
                    layer.title = db.getVarchar(j,i,1);
                    layer.portrait = db.getVarchar(j,i,2);
                    layer.signature = db.getVarchar(j,i,3);
                    layer.isign = db.getString(4);
                } else
                {
                    layer.title = "游客";
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
            db.executeQuery("SELECT language FROM ProfileBBSLayer WHERE member=" + DbAdapter.cite(member));
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

    public String getMember()
    {
        return member;
    }

    public boolean isValidate()
    {
        return valid;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getCallSound()
    {
        return callsound;
    }

    public boolean isMessage()
    {
        return message;
    }

    public String getSerialNum()
    {
        return serialnum;
    }

    public String getTitle(int language) throws SQLException
    {
        return getLayer(language).title;
    }

    public String getPortrait(int language) throws SQLException
    {
        String str = getLayer(language).portrait;
        if(str == null || str.length() < 1)
        {
            str = "/res/" + community + "/bbsphoto/index.jpg";
        }
        return str;
    }

    public String getSignature(int language) throws SQLException
    {
        return getLayer(language).signature;
    }

    public String getISign(int language) throws SQLException
    {
        return getLayer(language).isign;
    }

    public void set(int language,String title,String portrait,String signature) throws SQLException
    {
        if(!exists)
        {
            create(community,member);
            exists = true;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE ProfileBBSLayer SET title=" + DbAdapter.cite(title) + ",portrait =" + DbAdapter.cite(portrait) + ",signature=" + DbAdapter.cite(signature) + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO ProfileBBSLayer (member,community, language, title, portrait, signature,"
                                 + " isign)VALUES (" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ", " + language + ", " + DbAdapter.cite(title) + ", " + DbAdapter.cite(portrait) + ","
                                 + DbAdapter.cite(signature) + " ," + db.cite(community) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public static void create(String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO ProfileBBS (member,community, valid,message,callsound,post,reply)VALUES (" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ", 0,1,1,0,0)");
        } finally
        {
            db.close();
        }
    }

    public void set(String f,String v) throws SQLException
    {
        if(!exists)
        {
            create(community,member);
            exists = true;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ProfileBBS SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + member);
    }

    private void setLayer_(int language,String f,String v) throws SQLException
    {
        if(!exists)
        {
            create(community,member);
            exists = true;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE ProfileBBSLayer SET " + f + "=" + DbAdapter.cite(v) + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO ProfileBBSLayer (member,community, language," + f + ")VALUES (" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ", " + language + ", " + DbAdapter.cite(v) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setISign(int language,String isign) throws SQLException
    {
        setLayer_(language,"isign",isign);
    }

    public void setSerialNum(String serialnum) throws SQLException
    {
        set("serialnum",serialnum);
        this.serialnum = serialnum;
    }

    public void setValidate(boolean valid) throws SQLException
    {
        set("valid",(valid ? "1" : "0"));
        this.valid = valid;
    }


    public void set(boolean message,int callsound) throws SQLException
    {
        if(!exists)
        {
            create(community,member);
            exists = true;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ProfileBBS SET message=" + DbAdapter.cite(message) + ",callsound=" + callsound + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.message = message;
        this.callsound = callsound;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT valid,message,callsound,serialnum,post,reply FROM ProfileBBS WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            if(db.next())
            {
                int j = 1;
                valid = db.getInt(j++) != 0;
                message = db.getInt(j++) != 0;
                callsound = db.getInt(j++);
                serialnum = db.getString(j++);
                post = db.getInt(j++);
                reply = db.getInt(j++);
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

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM ProfileBBS WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                al.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    //判断着个用户是否绑定key
    public static boolean isKey(String community,String member,String key) throws SQLException
    {
        boolean fa = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT serialnum FROM ProfileBBS WHERE community =" + db.cite(community) + " AND member =" + db.cite(member) + " AND serialnum= " + db.cite(key));
            if(db.next())
            {
                fa = true;
            }
        } finally
        {
            db.close();
        }
        return fa;
    }


}
