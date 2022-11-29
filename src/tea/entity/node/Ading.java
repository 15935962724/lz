package tea.entity.node;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Ading extends Entity
{
    class AgLayer
    {
        public String _strName;
        private String beforeItem;
        private String afterItem;
        private String picture;
        private boolean layerExisted;
        private String imgSize;
    }


    static boolean EMPTY;
    static
    {
        try
        {
            EMPTY = count("") < 1;
        } catch(Throwable ex)
        {}
    }

    private static Cache _cache = new Cache(100);
    public int ading;
    public int style;
    public int styletype;
    public int stylecategory;
    public int node;
    public int status;
    public int currency;
    public BigDecimal cpm;
    public Date starttime;
    public Date stoptime;
    private Hashtable _htAgLayer;
    public int position;
    public int sequence;
    public int ectypal; //副本ID号

    public void set(int style,int styletype,int stylecategory,int currency,BigDecimal bigdecimal,Date date,Date date1,int k,int position,int sequence,String name,
                    String beforeItem,String afterItem,String picture,int ectypal,String imgSize) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Ading SET style=" + style + ",styletype=" + styletype + ",stylecategory=" + stylecategory + ",currency=" + currency + ", " +
                             " cpm=" + bigdecimal + ",starttime=" + DbAdapter.cite(date) + ", stoptime=" + DbAdapter.cite(date1) + ",position=" + position + "," +
                             " sequence=" + sequence + ",ectypal=" + ectypal + " WHERE ading=" + ading);
            db.executeQuery("SELECT ading FROM AdingLayer WHERE ading=" + ading + " AND language=" + k);
            if(db.next())
            {
                db.executeUpdate("UPDATE AdingLayer SET name=" + DbAdapter.cite(name) + ",beforeitem=" + DbAdapter.cite(beforeItem) + ",afteritem=" + DbAdapter.cite(afterItem) + "	,picture=" + DbAdapter.cite(picture)+ "	,imgSize=" + DbAdapter.cite(imgSize) + " WHERE ading=" + ading + " AND language=" + k);
            } else
            {
                db.executeUpdate("INSERT INTO AdingLayer(ading, language, name,beforeitem,afteritem,picture,imgSize)VALUES (" + ading + ", " + k + ", " + DbAdapter.cite(name) + "," + DbAdapter.cite(beforeItem) + "," + DbAdapter.cite(afterItem) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(imgSize) + ")");
            }
        } finally
        {
            db.close();
        }
        style = style;
        currency = currency;
        cpm = bigdecimal;
        starttime = date;
        stoptime = date1;
        this.position = position;
        this.sequence = sequence;
        this.ectypal = ectypal;
        _htAgLayer.clear();
    }

    private Ading(int i) throws SQLException
    {
        ading = i;
        _htAgLayer = new Hashtable();
    }

    public static int create(int style,int styletype,int stylecategory,int node,int status,int k,BigDecimal bigdecimal,Date date,Date date1,int l,int position,int sequence,String name,String beforeItem,String afterItem,String picture,int ectypal) throws SQLException
    {
        int i1 = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Ading (style, styletype, stylecategory, node,status,currency, cpm, starttime, stoptime,position,sequence,ectypal)VALUES (" + style + ", " +
                             "" + styletype + ", " + stylecategory + ", " + node + "," + status + ", " + k + ", " + bigdecimal + ", " + DbAdapter.cite(date) + ", " + DbAdapter.cite(date1) + "," +
                             "" + position + "," + sequence + "," + ectypal + "  )");
            i1 = db.getInt("SELECT MAX(ading) FROM Ading");
            db.executeUpdate("INSERT INTO AdingLayer (ading, language, name,beforeitem,afteritem,picture)VALUES(" + i1 + ", " + l + ", " + DbAdapter.cite(name) + "," + DbAdapter.cite(beforeItem) + "," + DbAdapter.cite(afterItem) + "," + DbAdapter.cite(picture) + ")");
        } finally
        {
            db.close();
        }
        EMPTY = false;
        return i1;
    }

    public static int create(int style,int styletype,int stylecategory,int node,int status,int k,BigDecimal bigdecimal,Date date,Date date1,int l,int position,int sequence,String name,String beforeItem,String afterItem,String picture,int ectypal,String imgSize) throws SQLException
    {
        int i1 = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Ading (style, styletype, stylecategory, node,status,currency, cpm, starttime, stoptime,position,sequence,ectypal)VALUES (" + style + ", " +
                             "" + styletype + ", " + stylecategory + ", " + node + "," + status + ", " + k + ", " + bigdecimal + ", " + DbAdapter.cite(date) + ", " + DbAdapter.cite(date1) + "," +
                             "" + position + "," + sequence + "," + ectypal + "  )");
            i1 = db.getInt("SELECT MAX(ading) FROM Ading");
            db.executeUpdate("INSERT INTO AdingLayer (ading, language, name,beforeitem,afteritem,picture,imgSize)VALUES(" + i1 + ", " + l + ", " + DbAdapter.cite(name) + "," + DbAdapter.cite(beforeItem) + "," + DbAdapter.cite(afterItem) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(imgSize) + ")");
        } finally
        {
            db.close();
        }
        EMPTY = false;
        return i1;
    }
    public boolean isAgLayerExisted(int language) throws SQLException
    {
        return getAgLayer(language).layerExisted;
    }

    public int getNode()
    {
        return node;
    }

    public int getEctypal()
    {
        return ectypal;
    }

    public int getStyle()
    {
        return style;
    }

    public Date getStartTime()
    {
        return starttime;
    }

    public String getStartTimeToString()
    {
        if(starttime == null)
        {
            return "";
        }
        return sdf2.format(starttime);
    }

    public Date getStopTime()
    {
        return stoptime;
    }

    public String getStopTimeToString()
    {
        if(stoptime == null)
        {
            return "";
        }
        return sdf2.format(stoptime);
    }

    public String getName(int i) throws SQLException
    {
        return getAgLayer(i)._strName;
    }

    public String getPicture(int language) throws SQLException
    {
        return getAgLayer(language).picture;
    }
    
    public String getImgSize(int language) throws SQLException
    {
        return getAgLayer(language).imgSize;
    }
    
    public BigDecimal getCpm()
    {
        return cpm;
    }

    private AgLayer getAgLayer(int i) throws SQLException
    {
        AgLayer layer = (AgLayer) _htAgLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new AgLayer();
            int j = getLanguage(i);
            layer.layerExisted = j == i;
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,beforeitem,afteritem,picture,imgSize FROM AdingLayer WHERE ading=" + ading + " AND language=" + j);
                if(db.next())
                {
                    layer._strName = db.getVarchar(j,i,1);
                    layer.beforeItem = db.getVarchar(j,i,2);
                    layer.afterItem = db.getVarchar(j,i,3);
                    layer.picture = db.getString(4);
                    layer.imgSize = db.getString(5);
                }
            } finally
            {
                db.close();
            }
            _htAgLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    public boolean isLayerExisted(int language) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM AdingLayer WHERE ading=" + ading + " AND language=" + language);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM AdingLayer WHERE ading=" + ading);
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

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM AdingLayer WHERE ading=" + ading + "  AND language=" + i);
            db.executeQuery("SELECT ading FROM AdingLayer WHERE ading=" + ading);
            if(!db.next())
            {
                db.executeUpdate("DELETE FROM Ading WHERE ading=" + ading);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(ading));
    }

    public static Ading find(int i) throws SQLException
    {
        Ading t = (Ading) _cache.get(new Integer(i));
        if(t == null)
        {
            ArrayList al = find(" AND a.ading=" + i,0,1);
            t = al.size() < 1 ? new Ading(i) : (Ading) al.get(0);
        }
        return t;
    }

    public static ArrayList find(Node node,int status,int position,boolean flag) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append(" AND a.status=" + status);
        if(position != -1)
        {
            sql.append(" AND a.position=" + position);
        }
        sql.append(" AND (");
        //本节点///////////////////////////////////////////////
        sql.append("(");
        if(flag)
        {
            sql.append(" a.style=0 AND");
        }
        sql.append(" a.node=").append(node._nNode).append(")");
        //本树,类型为...///////////////////////////////////////////////
        sql.append(" OR ( a.style=2 AND ( a.styletype=255 OR ( a.styletype=").append(node.getType());
        if(node.getType() == 1)
        {
            Category c = Category.find(node._nNode);
            sql.append(" AND a.stylecategory=" + c.getCategory());
        }
        sql.append(" ) ) AND '" + node.getPath() + "' LIKE " + DbAdapter.concat("n.path","'%'"));
        sql.append(")");
//
        sql.append(")");
//        if (flag)
//        {
//            sql.append(" AND  a.ading NOT IN (SELECT distinct a.ading FROM Ading s, adinghide sh ,Node n WHERE a.ading=sh.ading AND n.node=sh.node AND " + " (( sh.hiden=0 AND " + DbAdapter.cite(n.getPath()) + " LIKE " + db.concat("n.path", "'%'") + ") OR (sh.hiden=2 AND " + DbAdapter.cite(n.getPath()) + " LIKE n.path ) " + " or ( sh.hiden=1 AND (" + DbAdapter.cite(n.getPath()) + " LIKE " + db.concat("n.path", "'%'") + ") AND ( " + DbAdapter.cite(n.getPath())
//                       + " NOT LIKE n.path)))) ");
//        }
        sql.append(" ORDER BY a.sequence");
        return find(sql.toString(),0,200);
    }

    public static ArrayList find_(Node node,int status,int position,boolean flag) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        //PC端手机端都显示，去掉状态值判断
//        sql.append(" AND a.status=" + status);
        if(position != -1)
        {
            sql.append(" AND a.position=" + position);
        }
        sql.append(" AND (");
        //本节点///////////////////////////////////////////////
        sql.append("(");
        if(flag)
        {
            sql.append(" a.style=0 AND");
        }
        sql.append(" a.node=").append(node._nNode).append(")");
        //本树,类型为...///////////////////////////////////////////////
        sql.append(" OR ( a.style=2 AND ( a.styletype=255 OR ( a.styletype=").append(node.getType());
        if(node.getType() == 1)
        {
            Category c = Category.find(node._nNode);
            sql.append(" AND a.stylecategory=" + c.getCategory());
        }
        sql.append(" ) ) AND '" + node.getPath() + "' LIKE " + DbAdapter.concat("n.path","'%'"));
        sql.append(")");
        sql.append(")");
        sql.append(" ORDER BY a.sequence");
        return find(sql.toString(),0,200);
    }
    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(*) FROM Ading a INNER JOIN Node n ON a.node=n.node WHERE 1=1" + sql);
        } finally
        {
            db.close();
        }
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        if(EMPTY)
            return al;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT a.ading,a.style,a.styletype,a.stylecategory,a.node,a.status,a.currency,a.cpm,a.starttime,a.stoptime,a.position,a.sequence,a.ectypal FROM Ading a INNER JOIN Node n ON a.node=n.node WHERE " + sql.substring(4),pos,size);
            while(db.next())
            {
                int j = 1;
                int id = db.getInt(j++);
                Ading t = (Ading) _cache.get(id);
                if(t == null)
                    t = new Ading(id);
                t.style = db.getInt(j++);
                t.styletype = db.getInt(j++);
                t.stylecategory = db.getInt(j++);
                t.node = db.getInt(j++);
                t.status = db.getInt(j++);
                t.currency = db.getInt(j++);
                t.cpm = db.getBigDecimal(j++,2);
                t.starttime = db.getDate(j++);
                t.stoptime = db.getDate(j++);
                t.position = db.getInt(j++);
                t.sequence = db.getInt(j++);
                t.ectypal = db.getInt(j++);
                _cache.put(t.ading,t);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

//    public static Vector find(int node, int _nPosition) throws SQLException
//    {
//        Node node = Node.find(node);
//        Date date = new Date(System.currentTimeMillis());
//        Vector v = new Vector();
//        StringBuilder sql = new StringBuilder();
//
//        DbAdapter db = new DbAdapter();
//        sql.append("SELECT ading FROM Ading a INNER JOIN Node n ON a.node=n.node WHERE");
//        // ///////////////////////////////////////////////
//        sql.append("( a.node=" + node + " AND a.position=" + _nPosition + " AND a.style=0 AND (a.starttime IS NULL OR a.starttime<" + DbAdapter.cite(date) + ") AND (a.stoptime IS NULL OR a.stoptime>" + DbAdapter.cite(date) + ") )");
//
//        // ///////////////////////////////////////////////
//        sql.append(" OR ( a.position=" + _nPosition + " AND a.style=1 AND n.community=" + DbAdapter.cite(node.getCommunity()) + " AND n.type=" + node.getType() + " AND " + DbAdapter.cite(node.getPath()) + " LIKE " + db.concat("n.path", "'%'") + " AND (a.starttime IS NULL OR a.starttime<" + DbAdapter.cite(date) + ") AND (a.stoptime IS NULL OR a.stoptime>" + DbAdapter.cite(date) + ") )");
//
//        // ///////////////////////////////////////////////
//        sql.append(" OR ( a.position=" + _nPosition + " AND a.style=2 AND n.community=" + DbAdapter.cite(node.getCommunity()) + " AND " + DbAdapter.cite(node.getPath()) + " LIKE " + db.concat("n.path", "'%'") + " AND (a.starttime IS NULL OR a.starttime<" + DbAdapter.cite(date) + ") " + " AND (a.stoptime IS NULL OR a.stoptime>" + DbAdapter.cite(date) + ") )");
//
//        // ///////////////////////////////////////////////
//        sql.append(" OR ( a.position=" + _nPosition + " AND a.style=" + 3 + " AND n.community=" + DbAdapter.cite(node.getCommunity()) + " AND n.type=" + node.getType() + " AND (a.starttime IS NULL OR a.starttime<" + DbAdapter.cite(date) + ") " + " AND (a.stoptime IS NULL OR a.stoptime>" + DbAdapter.cite(date) + ") )");
//
//        // ///////////////////////////////////////////////
//        sql.append(" OR ( a.position=" + _nPosition + " AND a.style=" + 4 + " AND n.community=" + DbAdapter.cite(node.getCommunity()) + " AND (a.starttime IS NULL OR a.starttime<" + DbAdapter.cite(date) + ") " + " AND (a.stoptime IS NULL OR a.stoptime>" + DbAdapter.cite(date) + ") )");
//
//        // ///////////////////////////////////////////////
//        sql.append(" OR ( a.position=" + _nPosition + " AND a.style=" + 5 + " AND n.type=" + node.getType() + " AND (a.starttime IS NULL OR a.starttime<" + DbAdapter.cite(date) + ") " + " AND (a.stoptime IS NULL OR a.stoptime>" + DbAdapter.cite(date) + ") )");
//
//        // ///////////////////////////////////////////////
//        sql.append(" OR ( a.position=" + _nPosition + " AND a.style=" + 6 + " AND (a.starttime IS NULL OR a.starttime<" + DbAdapter.cite(date) + ") " + " AND (a.stoptime IS NULL OR a.stoptime>" + DbAdapter.cite(date) + ") )");
//
//        // ///////////////////////////////////////////////
//        sql.append(" OR ( a.position=" + _nPosition + " AND a.style=" + 7 + " AND n.community=" + DbAdapter.cite(node.getCommunity()) + " AND n.type=" + node.getType() + " AND (a.starttime IS NULL OR a.starttime<" + DbAdapter.cite(date) + ") " + " AND (a.stoptime IS NULL OR a.stoptime>" + DbAdapter.cite(date) + ") " + " AND '" + node.getPath() + "' LIKE " + db.concat("'%/'", db.cast("a.styleroot", "VARCHAR(50)"), "'/%'") + ")");
//        try
//        {
//            db.executeQuery(sql.toString());
//            while (db.next())
//            {
//                v.addElement(new Integer(db.getInt(1)));
//            }
//        } finally
//        {
//            db.close();
//        }
//        return v;
//    }

    public int getCurrency()
    {
        return currency;
    }

    public int getPosition()
    {
        return position;
    }

    public int getSequence()
    {
        return sequence;
    }

    public int getStyleType()
    {
        return styletype;
    }

    public int getStyleCategory()
    {
        return stylecategory;
    }

    public String getBeforeItem(int language) throws SQLException
    {
        return getAgLayer(language).beforeItem;
    }

    public String getAfterItem(int language) throws SQLException
    {
        return getAgLayer(language).afterItem;
    }

}
