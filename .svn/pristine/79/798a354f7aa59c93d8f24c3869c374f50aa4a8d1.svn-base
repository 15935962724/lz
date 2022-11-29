package tea.entity.bpicture;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.util.Vector;
import java.util.Enumeration;

public class BLightbox extends Entity
{
    private static Cache _cache = new Cache(100);
    private int lbid;
    private String name; //图库名
    private String picid; //图片ID
    private String bpid; //会员名
    private Date createTime;
    private Date accessTime;
    private boolean exists;

    public BLightbox(int lbid) throws SQLException
    {
        this.lbid = lbid;
        load();
    }

    public BLightbox(int lbid,String name,String picid,String bpid,Date createTime, Date accessTime) throws SQLException
    {
        this.lbid = lbid;
        this.name = name;
        this.picid = picid;
        this.bpid=bpid;
        this.createTime=createTime;
        this.accessTime=accessTime;
        this.exists = true;
    }

    public static BLightbox find(int lbid) throws SQLException
    {
//        BLightbox obj = (BLightbox) _cache.get(lbid);
//        if(obj == null)
//        {
//            obj = new BLightbox(lbid);
//            _cache.put(lbid,obj);
//        }
        return new BLightbox(lbid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select lbid,name,picid,bpid,createtime,accesstime from lightbox where lbid=" + lbid);
            if(db.next())
            {
                lbid = db.getInt(1);
                name = db.getString(2);
                picid = db.getString(3);
                bpid=db.getString(4);
                createTime=db.getDate(5);
                accessTime =db.getDate(6);
                exists = true;
                _cache.clear();
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }



    public static void create(String name,String bpid) throws SQLException
    {
        java.util.Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Insert into  lightbox(name,bpid,picid,createtime,accesstime) values(" + db.cite(name) + "," + db.cite(bpid) + ",',',"+db.cite(d)+","+db.cite(d)+")");
        } finally
        {
            db.close();
        }
    }

    public static void setPic(String name,String bpid,String picid) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            BLightbox bl =BLightbox.find(BLightbox.findId(bpid,name));
            String gp = "";
            if(!bl.getpicid().equals(","))
            {
                gp=bl.getpicid();
            }
            String pid = gp;
            if(!isExisted(bpid,name,picid)){
                pid = gp + "," + picid;
            }
            db.executeUpdate("Update lightbox set picid="+db.cite(pid)+" where bpid="+db.cite(bpid)+" and name="+db.cite(name));
        } finally
        {
            db.close();
        }
    }

    public static void canPic(String name,String canPicid,String email) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update lightbox set picid="+db.cite(canPicid)+" where bpid="+db.cite(email)+" and name="+db.cite(name));
        } finally
        {
            db.close();
        }
    }

    public static void createCaption(String caption,int picid,String member,String lightbox) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into bpicaption(member,lightbox,picid,bcaption) values("+db.cite(member)+", "+db.cite(lightbox)+", "+picid+", "+db.cite(caption)+")");
        } finally
        {
            db.close();
        }
    }

    public static void upCaption(String caption,int picid,String member,String lightbox) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update bpicaption set bcaption="+db.cite(caption)+" where member="+db.cite(member)+" and picid="+picid+" and lightbox="+db.cite(lightbox));
        } finally
        {
            db.close();
        }
    }

    public static void delCaption(int picid,String member,String lightbox) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from bpicaption where member="+db.cite(member)+" and picid="+picid +" and lightbox="+db.cite(lightbox));
        } finally
        {
            db.close();
        }
    }

    public static String selCaption(int picid,String member,String lightbox) throws SQLException
    {
        String a = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select bcaption from bpicaption where member="+db.cite(member)+" and picid="+picid+" and lightbox="+db.cite(lightbox));
            while(db.next()){
                a = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return a;
    }



    public static boolean isExtCaption(String member,int picid,String lightbox) throws SQLException
        {
            boolean flag = false;

                StringBuilder sb = new StringBuilder();
                sb.append("select member from bpicaption where member=").append(DbAdapter.cite(member)).append(" and picid=").append(picid).append(" and lightbox=").append(DbAdapter.cite(lightbox));
                DbAdapter db = new DbAdapter(1);
                try
                {
                    db.executeQuery(sb.toString());
                    flag = db.next();
                } finally
                {
                    db.close();
                }

            return flag;
    }

    public static boolean isExisted(String email,String name,String picid) throws SQLException
    {
        boolean flag = false;

            StringBuilder sb = new StringBuilder();
            sb.append("SELECT name FROM lightbox WHERE bpid=").append(DbAdapter.cite(email)).append(" and name=").append(DbAdapter.cite(name)).append(" and picid like ("+DbAdapter.cite("%"+picid+"%")+")");
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery(sb.toString());
                flag = db.next();
            } finally
            {
                db.close();
            }

        return flag;
    }



    public static void set (String email,String oldname,String newname)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update lightbox set name="+db.cite(newname)+" where bpid="+db.cite(email)+" and name="+db.cite(oldname));

        }
        finally
        {
            db.close();
        }
    }

    public static void setLB(String member,String lightbox,int picid,String oldname)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update bpicaption set lightbox="+db.cite(lightbox)+" where lightbox="+db.cite(oldname)+" and member="+db.cite(member)+" and picid="+picid);

        }
        finally
        {
            db.close();
        }
    }


    public static void set (String email,String name)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.util.Date d = new Date();
        try
        {
            db.executeUpdate("Update lightbox set accesstime="+db.cite(d)+" where bpid="+db.cite(email)+" and name="+db.cite(name));
        }
        finally
        {
            db.close();
        }
    }



    public static int findId(String email, String name)throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select lbid from lightbox where bpid="+db.cite(email)+" and name=" + db.cite(name));
            while(db.next())
            {
                id = db.getInt(1);
            }
        }
        finally
        {
            db.close();
        }
        return id;
    }

    public static Enumeration findLightBox(String email) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {

            db.executeQuery("SELECT name FROM Lightbox WHERE bpid=" + DbAdapter.cite(email));
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }
    public static int countLightBox(String email) throws SQLException
    {
        int count=0;
        DbAdapter db = new DbAdapter(1);
        try
        {

            db.executeQuery("SELECT count(*) FROM Lightbox WHERE bpid=" + DbAdapter.cite(email));
            while(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }


    public static boolean isExisted(String email,String name) throws SQLException
    {
        boolean flag = false;

            StringBuilder sb = new StringBuilder();
            sb.append("SELECT name FROM lightbox WHERE bpid=").append(DbAdapter.cite(email)).append(" and name=").append(DbAdapter.cite(name));
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery(sb.toString());
                flag = db.next();
            } finally
            {
                db.close();
            }

        return flag;
    }



    public static void delete (int lbid)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete Lightbox  where lbid="+lbid);
        }
        finally
        {
            db.close();
        }
    }



    public boolean isExists()
    {
        return exists;
    }

    public int getlbid()
    {
        return lbid;
    }

    public String getname()
    {
        return name;
    }

    public String getpicid()
    {
        return picid;
    }

    public Date getAccessTime()
    {
        return accessTime;
    }

    public String getBpid()
    {
        return bpid;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public String getCreateTimeToString()
   {
       if(createTime == null)
       {
           return "";
       }
       return BLightbox.sdf.format(createTime);
   }

   public String getAccessTimeToString()
   {
       if(accessTime == null)
       {
           return "";
       }
       return BLightbox.sdf2.format(accessTime);
   }


}
