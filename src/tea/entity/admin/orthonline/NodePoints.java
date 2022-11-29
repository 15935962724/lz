package tea.entity.admin.orthonline;

import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.entity.integral.Integral;
import tea.entity.node.Node;
import tea.db.*;
import tea.entity.*;
import java.io.*;

public class NodePoints extends Entity
{
    private int nodeid;
    private float scwz;
    private float llwz;
    private float sczy;
    private float xzzy;
    private float wzbll;
    private float zybxz;

    public NodePoints(int nodeid) throws SQLException
    {
        this.nodeid = nodeid;
        load();
    }

    public static NodePoints find(int nodeid) throws SQLException
    {
        return new NodePoints(nodeid);
    }

    public static NodePoints get(int nodeid) throws SQLException
    {
        int nid = nodeid;
        DbAdapter db = new DbAdapter();
        try
        {
//				db.executeQuery("select  np.nodeid " +
//						" FROM NodePoints np,Node n,Node nn" +
//						" WHERE np.nodeid=nn.node " +
//						"and  n.path like'%/'+CONVERT(nvarchar(20),np.nodeid)+'/%' " +
//						"and n.node=" +nodeid+
//						" order by len(nn.path)  desc");
            db.executeQuery("SELECT np.nodeid FROM NodePoints np,Node nn WHERE np.nodeid=nn.node AND nn.path LIKE " + db.concat("'%/'",db.cast("np.nodeid","VARCHAR"),"'/%'") + " AND nn.node=" + nodeid + " ORDER BY " + db.length("nn.path") + " DESC");
//			System.out.println("select  np.nodeid " +
//					" FROM NodePoints np,Node nn" +
//					" WHERE np.nodeid=nn.node " +
//					"and  nn.path like'%/'+CONVERT(nvarchar(20),np.nodeid)+'/%' " +
//					"and nn.node=" +nodeid+
//					" order by len(nn.path)  desc");
            if(db.next())
            {
                nid = db.getInt(1);

            }
        } finally
        {
            db.close();
        }
        return new NodePoints(nid);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Node node = Node.find(nodeid);

        try
        {
            //System.out.print(" select nodeid,scwz,llwz,sczy,xzzy,wzbll,zybxz" +	" FROM NodePoints WHERE nodeid =" +nodeid);
            db.executeQuery("SELECT nodeid,scwz,llwz,sczy,xzzy,wzbll,zybxz FROM NodePoints WHERE nodeid =" + nodeid);
            if(db.next())
            {
                nodeid = db.getInt(1);
                scwz = db.getFloat(2);
                llwz = db.getFloat(3);
                sczy = db.getFloat(4);
                xzzy = db.getFloat(5);
                wzbll = db.getFloat(6);
                zybxz = db.getFloat(7);
            } else
            {
                Integral it = Integral.find(Integral.getIgid(node.getCommunity(),node.getType(),0));
                //nodeid=0;
                if(it.isExists())
                {
                    scwz = it.getScwz();
                    llwz = it.getLlwz();
                    sczy = it.getSczy();
                    xzzy = it.getXzzy();
                    wzbll = it.getWzbll();
                    zybxz = it.getZybxz();
                } else
                {
                    scwz = 0;
                    llwz = 0;
                    sczy = 0;
                    xzzy = 0;
                    wzbll = 0;
                    zybxz = 0;
                }
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(int nodeid,float scwz,float llwz,float sczy,float xzzy,float wzbll,float zybxz) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        //Date times = new Date();
        int i = 0;
        try
        {
            db.executeUpdate(nodeid,"INSERT INTO NodePoints(nodeid,scwz,llwz,sczy,xzzy,wzbll,zybxz)VALUES(" + nodeid + "," + scwz + "," + llwz + "," + sczy + "," + xzzy + "," + wzbll + "," + zybxz + ")");
        } finally
        {
            db.close();
        }

    }

    public static void set(int nodeid,float scwz,float llwz,float sczy,float xzzy,float wzbll,float zybxz) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(nodeid,"UPDATE NodePoints SET " +
                             "scwz=" + scwz +
                             ",llwz=" + llwz +
                             ",sczy=" + sczy +
                             ",xzzy=" + xzzy +
                             ",wzbll=" + wzbll +
                             ",zybxz=" + zybxz +
                             " WHERE nodeid = " + nodeid);
        } finally
        {
            db.close();
        }
    }


    public static boolean isExist(int nodeid) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * FROM NodePoints  WHERE nodeid=");
        sb.append(nodeid);

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

    public int getNodeid()
    {
        return nodeid;
    }

    public void setNodeid(int nodeid)
    {
        this.nodeid = nodeid;
    }

    public float getScwz()
    {
        return scwz;
    }

    public void setScwz(float scwz)
    {
        this.scwz = scwz;
    }

    public float getLlwz()
    {
        return llwz;
    }

    public void setLlwz(float llwz)
    {
        this.llwz = llwz;
    }

    public float getSczy()
    {
        return sczy;
    }

    public void setSczy(float sczy)
    {
        this.sczy = sczy;
    }

    public float getXzzy()
    {
        return xzzy;
    }

    public void setXzzy(float xzzy)
    {
        this.xzzy = xzzy;
    }

    public float getWzbll()
    {
        return wzbll;
    }

    public void setWzbll(float wzbll)
    {
        this.wzbll = wzbll;
    }

    public float getZybxz()
    {
        return zybxz;
    }

    public void setZybxz(float zybxz)
    {
        this.zybxz = zybxz;
    }

}
