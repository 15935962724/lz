package tea.entity.admin.map;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;

public class GMap extends Entity
{
    public static Cache _cache = new Cache(100);
    private int node;
    private float lat;
    private float lng;
    private int zoom;
    private String member;
    private boolean hidden;
    private Date time;
    public GMap(int node,float lat,float lng,int zoom,String member,boolean hidden,Date time)
    {
        this.node = node;
        this.lat = lat;
        this.lng = lng;
        this.zoom = zoom;
        this.member = member;
        this.hidden = hidden;
        this.time = time;
    }

//127.0.0.1:8080=ABQIAAAAPtmsuSCbkV1daFlP-evayxTBfUk9TZrBRaIteybtnU2KziHEpRSG9NeOs1Q5QtDa3Nt6r7Nmq1Fvpw
    public static synchronized String key(String d) throws IOException,SQLException
    {
        String key = DNS.find(d).gkey;
        if(key == null)
        {
            /*
                     try
                     {
                         // System.out.println(open("http://code.google.com/apis/maps/signup/createkey?referer=http%3A%2F%2F" + d,"PREF=ID=615f36efca22b7db:TM=1234229304:LM=1234229304:S=u2zbZ_IreVItq5hA; NID=19=FE0_daPQd0PObSnfedSS7VdSeh_9SrQj9QULmGTFDHcIdGNZAarW21GIjJUEvOCBRd0jj9-3nMjeyp5Ib2AapssvOvwq4Tdvkfz3jLknd2r-fPyjHToS5UPKL5uu7xce; SID=DQAAAHMAAACNQkzWgI3GfG7arimHKFzp4ADvp7NwvB23pcADPyi3uBOyJW4iphU37ibBaB1MLX62i-tf-h_CuuCVBrSPtqlWoaf81dkCnej6Tvfem-NPI527sP-0Y_wuShktBCJurtCrrCGYixqi-ndmn7F0zaabGnTYk1_fygoRrkI86rGr0g"));
                         String h = (String) open("http://www.google.com/maps/api_signup?url=http%3A%2F%2F" + d,"PREF=ID=615f36efca22b7db:TM=1234229304:LM=1234229304:S=u2zbZ_IreVItq5hA; NID=19=FE0_daPQd0PObSnfedSS7VdSeh_9SrQj9QULmGTFDHcIdGNZAarW21GIjJUEvOCBRd0jj9-3nMjeyp5Ib2AapssvOvwq4Tdvkfz3jLknd2r-fPyjHToS5UPKL5uu7xce; SID=DQAAAHMAAACNQkzWgI3GfG7arimHKFzp4ADvp7NwvB23pcADPyi3uBOyJW4iphU37ibBaB1MLX62i-tf-h_CuuCVBrSPtqlWoaf81dkCnej6Tvfem-NPI527sP-0Y_wuShktBCJurtCrrCGYixqi-ndmn7F0zaabGnTYk1_fygoRrkI86rGr0g");
                         // String h = (String) open("http://code.google.com/apis/maps/signup/createkey?referer=http%3A%2F%2F" + d,"PREF=ID=615f36efca22b7db:TM=1234229304:LM=1234229304:S=u2zbZ_IreVItq5hA; NID=19=FE0_daPQd0PObSnfedSS7VdSeh_9SrQj9QULmGTFDHcIdGNZAarW21GIjJUEvOCBRd0jj9-3nMjeyp5Ib2AapssvOvwq4Tdvkfz3jLknd2r-fPyjHToS5UPKL5uu7xce; SID=DQAAAHMAAACNQkzWgI3GfG7arimHKFzp4ADvp7NwvB23pcADPyi3uBOyJW4iphU37ibBaB1MLX62i-tf-h_CuuCVBrSPtqlWoaf81dkCnej6Tvfem-NPI527sP-0Y_wuShktBCJurtCrrCGYixqi-ndmn7F0zaabGnTYk1_fygoRrkI86rGr0g");

                         int s = h.indexOf("key=") + 4;
                         int e = h.indexOf('"',s);
                         key = h.substring(s,e);
                         co.set(d,key);
                     } catch(Exception e)
                     {
                         e.printStackTrace();
                         System.out.println("地图注册API 出现问题.");
                     }
             */
        }
        return key;
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM GMap WHERE 1=1" + sql);
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

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,lat,lng,zoom,member,hidden,time FROM GMap gm WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int node = db.getInt(1);
                float lat = db.getFloat(2);
                float lng = db.getFloat(3);
                int zoom = db.getInt(4);
                String member = db.getString(5);
                boolean hidden = db.getInt(6) != 0;
                Date time = db.getDate(7);
                v.add(new GMap(node,lat,lng,zoom,member,hidden,time));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(int node,String point,String member) throws SQLException
    {
        String arr[] = point.split(",");
        create(node,Float.parseFloat(arr[0]),Float.parseFloat(arr[1]),Integer.parseInt(arr[2]),member);
    }

    public static void create(int node,float lat,float lng,int zoom,String member) throws SQLException
    {
        Date time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE GMap SET lat=" + lat + ",lng=" + lng + ",zoom=" + zoom + ",time=" + db.cite(time) + " WHERE node=" + node);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO GMap(node,lat,lng,zoom,member,hidden,time)VALUES(" + node + "," + lat + "," + lng + "," + zoom + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(true) + "," + DbAdapter.cite(time) + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node);
    }

    public void setHidden(boolean hidden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GMap SET hidden=" + db.cite(hidden) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.hidden = hidden;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM GMap WHERE node=" + node);
        } finally
        {
            db.close();
        }
    }

    public static GMap find(int node) throws SQLException
    {
        GMap obj = (GMap) _cache.get(node);
        if(obj == null)
        {
            Enumeration e = find(" AND node=" + node,0,1);
            if(e.hasMoreElements())
            {
                obj = (GMap) e.nextElement();
                _cache.put(node,obj);
            }
        }
        return obj;
    }

    public int getZoom()
    {
        return zoom;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public int getNode()
    {
        return node;
    }

    public float getLng()
    {
        return lng;
    }

    public float getLat()
    {
        return lat;
    }

    public boolean isHidden()
    {
        return hidden;
    }

    public String getMember()
    {
        return member;
    }
}
