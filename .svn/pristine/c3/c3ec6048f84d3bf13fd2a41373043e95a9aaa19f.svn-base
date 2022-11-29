package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Section extends Entity implements Cloneable
{
    public static Cache _cache = new Cache(1000);
    public static final String APPLY_STYLE[] =
            {"ThisNode","ThisTree","ThisTree"};
    //"ThisNode", "ThisTreeThisType", "ThisTreeAllNodes", "ThisCommThisType", "ThisCommAllNodes", "AllCommsThisType", "AllCommsAllNodes", "ThisRootThisType"
    public static final int APPLYS_THISNODE = 0;
    public static final int APPLYS_THISTREETHISTYPE = 1;
    public static final int APPLYS_THISTREEALLNODES = 2;
    public static final int APPLYS_THISCOMMTHISTYPE = 3;
    public static final int APPLYS_THISCOMMALLNODES = 4;
    public static final int APPLYS_ALLCOMMSTHISTYPE = 5;
    public static final int APPLYS_ALLCOMMSALLNODES = 6;
    public static final String SECTION_TYPE[] =
            {"Header1","AdLeft","Ad","AdRight","Header2","Body1","Body2","Body3","Footer","Direction","Talkback","ChatRoom"};
    public static final String SECTION_HideStyle[] =
            {"HidenAll","HidenInSub","HidenInLocation","NoHiden"};
    public static final int SECTIONT_HEADER1 = 0;
    public static final int SECTIONT_ADLEFT = 1;
    public static final int SECTIONT_AD = 2;
    public static final int SECTIONT_ADRIGHT = 3;
    public static final int SECTIONT_HEADER2 = 4;
    public static final int SECTIONT_BODYLEFT = 5;
    public static final int SECTIONT_BODY = 6;
    public static final int SECTIONT_BODYRIGHT = 7;
    public static final int SECTIONT_FOOTER = 8;
    public static final int SECTIONT_DIRECTION = 9;
    public static final int SECTIONT_TALKBACK = 10;
    public static final int SECTIONT_CHATROOM = 11;
    public static final String USER_STATUS[] =
            {"Always","BeforeLogin","AfterLogin","BeforeAccess","AfterAccess","SectionCreator","NodeCreator"};
    public static final int USERS_ALWAYS = 0;
    public static final int USERS_BEFORELOGIN = 1;
    public static final int USERS_AFTERLOGIN = 2;
    public static final int USERS_BEFOREACCESS = 3;
    public static final int USERS_AFTERACCESS = 4;
    public static final int USERS_SECTIONCREATOR = 5;
    public static final int USERS_NODECREATOR = 6;
    public static final int SECTIONO_TEXTORHTML = 1;
    public int section;
    public int style;
    public int styletype;
    public int stylecategory;
    public int node;
    public int position; //见SECTION_TYPE
    public int sequence;
    public int visible;
    public int options;
    public int status;
    public Date time;
    private Hashtable _htLayer;

    class Layer
    {
        /*
         * public boolean _blPicture; public boolean _blVoice; public boolean _blFile;
         */
        Layer()
        {
        }

        public String _strThemename;
        public String _strText;
        public String _strPicture;
        public String _strClickUrl;
        public String _strAlt;
        public int _nAlign;
        public String _strVoice;
        public String _strFileName;
        public String _strFileData;
        private boolean layerExisted;
    }


    public String getVoice(int i) throws SQLException
    {
        return getLayer(i)._strVoice;
    }

    public String getFileName(int i) throws SQLException
    {
        return getLayer(i)._strFileName;
    }

    public int getSequence() throws SQLException
    {
        return sequence;
    }

    public int getOptions() throws SQLException
    {
        return options;
    }

    public static Enumeration findByNode(int i) throws SQLException
    {
        // Node.find(i);
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT section FROM Section  WHERE node=" + i + " AND style IN(0,1,2,7)");
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

    public int getNode() throws SQLException
    {

        return node;
    }

    public int getVisible() throws SQLException
    {

        return visible;
    }

    public int getStyle() throws SQLException
    {

        return style;
    }

    public int getAlign(int i) throws SQLException
    {
        return getLayer(i)._nAlign;
    }

    public void setHiden(int node,int hiden) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE sectionhide SET hiden=" + hiden + " WHERE section=" + section + " AND node=" + node);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO sectionhide(section,node,hiden) VALUES (" + section + ", " + node + ", " + hiden + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public int getHiden(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT hiden FROM sectionhide WHERE section=" + section + " AND node= " + node);
            if(db.next())
            {
                return db.getInt(1);
            } else
            {
                return 3; //
            }
        } finally
        {
            db.close();
        }
    }


    public int getStatus() throws SQLException
    {
        return status;
    }

    public Date getTime() throws SQLException
    {
        return time;
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
                db.executeQuery("SELECT language,text,picture,clickurl,alt,align,voice,filename,filedata,themename FROM SectionLayer WHERE section=" + section + " ORDER BY "+(ConnectionPool._nType==1?"DBO.":"")+"LAYER(language," + i + ")");
                if(db.next())
                {
                    int j = 1;
                    int lang = db.getInt(j++);
                    layer._strText = db.getText(lang,i,j++);
                    layer._strPicture = db.getString(j++);
                    layer._strClickUrl = db.getString(j++);
                    layer._strAlt = db.getString(j++);
                    layer._nAlign = db.getInt(j++);
                    layer._strVoice = db.getString(j++);
                    layer._strFileName = db.getVarchar(lang,i,j++);
                    layer._strFileData = db.getString(j++);
                    layer._strThemename = db.getString(j++);
                    layer.layerExisted = lang == i;
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
            db.executeQuery("SELECT language FROM SectionLayer WHERE section=" + section);
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

    public Section clone(int nodeCode,int status) throws SQLException,CloneNotSupportedException
    {

        Section s = clone();
        s.node = nodeCode;
        s.status = status;
        s.set();

        Iterator it = getLanguages().iterator();
        while(it.hasNext())
        {
            int lang = ((Integer) it.next()).intValue();
            s.setLayer(lang,this.getThemename(lang),this.getText(lang),this.getPicture(lang),this.getClickUrl(lang),this.getAlt(lang),this.getAlign(lang),this.getVoice(lang),this.getFileName(lang),this.getFileData(lang));
        }

        it = Sectionhide.find(" AND section=" + section,0,200).iterator();
        while(it.hasNext())
        {
            Sectionhide sh = ((Sectionhide) it.next()).clone();
            sh.section = s.section;
            sh.set(sh.hiden);
        }
        return s;
    }

    public static int getMaxSequence(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT MAX(sequence) FROM Section WHERE node=" + i);
        } finally
        {
            db.close();
        }
        return j;
    }

//    public void set(int style,int styletype,int stylecategory,int position,int sequence,int visible,int options,int language,String text,String picture,String clickurl,String alt,int align,String voice,String filename,String filedata,Date time) throws SQLException
//    {
//        this.status = status;
//        this.style = style;
//        this.styletype = styletype;
//        this.stylecategory = stylecategory;
//        this.node = node;
//        this.position = position;
//        this.sequence = sequence;
//        this.visible = visible;
//        this.options = options;
//        this.time = time;
//        this.set();
//        this.setLayer(language,text,picture,clickurl,alt,align,voice,filename,filedata);
//        _htLayer.clear();
//        _cache2.clear();
//    }

    private void set(int i,String s) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SectionSetFileName " + section + ", " + i + ", " + DbAdapter.cite(s));
        } finally
        {
            db.close();
        }
        Layer layer = getLayer(i);
        layer._strFileName = s;
    }

    private void set(int i,int j,String s) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SectionSetFileData " + section + ", " + i + ", " + j + ", " + s);
        } finally
        {
            db.close();
        }
    }

    private void set_i(int i,String themename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(section,"UPDATE SectionLayer SET themename =" + db.cite(themename) + " WHERE language =" + i + " and section =" + this.section);
        } finally
        {
            db.close();
        }
        Layer layer = getLayer(i);
        layer._strThemename = themename;
    }


    private Section(int i)
    {
        section = i;
        _htLayer = new Hashtable();
    }

//    public static int create(int status,int style,int styletype,int stylecategory,int node,int position,int sequence,int visible,int options,int language,String text,String picture,String clickurl,String alt,int align,String voice,String filename,String filedata,Date time) throws SQLException
//    {
//        Section t = new Section(0);
//        t.status = status;
//        t.style = style;
//        t.styletype = styletype;
//        t.stylecategory = stylecategory;
//        t.node = node;
//        t.position = position;
//        t.sequence = sequence;
//        t.visible = visible;
//        t.options = options;
//        t.time = time;
//        t.set();
//        t.setLayer(language,text,picture,clickurl,alt,align,voice,filename,filedata);
//        _cache2.clear();
//        return t.section;
//    }

    public void set() throws SQLException
    {
        String sql;
        if(section < 1)
            sql = "INSERT INTO Section(section,status,style,styletype,stylecategory,node,position,sequence,visible,options,time)VALUES (" + (section = Seq.get()) + "," + status + ", " + style + ", " + styletype + ", " + stylecategory + ", " + node + "," + position + ", " + sequence + ", " + visible + ", " + options + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE Section SET style=" + style + ",styletype=" + styletype + ",stylecategory=" + stylecategory + ",position=" + position + ",sequence=" + sequence + ",visible=" + visible + ",options=" + options + ",time=" + DbAdapter.cite(time) + " WHERE section=" + section;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(section,sql);
        } finally
        {
            db.close();
        }
    }

    public void setLayer(int language,String name,String text,String picture,String clickurl,String alt,int align,String voice,String filename,String filedata) throws SQLException
    {
        String[] arr = DbAdapter.split("SectionLayer","text",text,"section=" + section + " AND language=" + language);

        String sql = "UPDATE SectionLayer SET themename=" + DbAdapter.cite(name) + ",text=" + DbAdapter.cite(arr[0]) + ",clickurl=" + DbAdapter.cite(clickurl) + ",alt=" + DbAdapter.cite(alt) + ",align=" + align;
        if(picture != null)
            sql += ",picture=" + DbAdapter.cite(picture);
        if(voice != null)
            sql += ",voice=" + DbAdapter.cite(voice);
        if(filedata != null)
            sql += ",filedata=" + DbAdapter.cite(filedata) + ",filename=" + DbAdapter.cite(filename);
        sql += " WHERE section=" + section + " AND language=" + language;

        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(section,sql);
            if(j < 1)
                db.executeUpdate(section,"INSERT INTO SectionLayer(section,language,themename,text,picture,clickurl,alt,align,voice,filedata,filename)VALUES (" + section + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(arr[0]) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(clickurl) + ", " + DbAdapter.cite(alt) + "," + align + "," + DbAdapter.cite(voice) + "," + DbAdapter.cite(filename) + ", " + DbAdapter.cite(filedata) + ")");
            for(int i = 1;i < arr.length;i++)
            {
                db.executeUpdate(section,arr[i]);
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        return getLayer(i).layerExisted;
    }

    public int getStyleType() throws SQLException
    {

        return styletype;
    }

    public int getStyleCategory() throws SQLException
    {
        return stylecategory;
    }

    public String getPicture(int i) throws SQLException
    {
        return getLayer(i)._strPicture;
    }

    public String getClickUrl(int i) throws SQLException
    {
        return getLayer(i)._strClickUrl;
    }

    public int getPosition() throws SQLException
    {
        return position;
    }

    public String getFileData(int i) throws SQLException
    {
        return getLayer(i)._strFileData;
    }

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(section,"DELETE FROM SectionLayer WHERE section=" + section + " AND language=" + i);
            db.executeQuery("SELECT section FROM SectionLayer WHERE section=" + section);
            if(!db.next())
            {
                db.executeUpdate(section,"DELETE FROM Section WHERE section=" + section);
                _cache.remove(section);
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public static Section find(int i) throws SQLException
    {
        Section t = (Section) _cache.get(new Integer(i));
        if(t == null)
        {
            ArrayList al = find(" AND s.section=" + i,0,1);
            t = al.size() < 1 ? new Section(i) : (Section) al.get(0);
        }
        return t;
    }

    public static ArrayList find(Node node,int status,int position,boolean flag) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append(" AND s.status=" + status + " AND s.position=" + position + " AND (");
        //本节点///////////////////////////////////////////////
        sql.append("(");
        if(flag)
        {
            sql.append(" s.style=0 AND");
        }
        sql.append(" s.node=").append(node._nNode).append(")");
        //本树,类型为...///////////////////////////////////////////////
        sql.append(" OR ( s.style=2 AND ( s.styletype=255 OR ( s.styletype=").append(node.getType());
        if(node.getType() == 1)
        {
            Category c = Category.find(node._nNode);
            sql.append(" AND s.stylecategory=" + c.getCategory());
        }
        sql.append(" ) ) AND '" + node.getPath() + "' LIKE " + DbAdapter.concat("n.path","'%'"));
        sql.append(")");
        //
        sql.append(")");
        if(flag)
        {
            sql.append(" AND  s.section NOT IN (SELECT distinct s.section FROM Section s, sectionhide sh ,Node n WHERE s.section=sh.section AND n.node=sh.node AND " + " (( sh.hiden=0 AND " + DbAdapter.cite(node.getPath()) + " LIKE " + DbAdapter.concat("n.path","'%'") + ") OR (sh.hiden=2 AND " + DbAdapter.cite(node.getPath()) + " LIKE n.path ) " + " or ( sh.hiden=1 AND (" + DbAdapter.cite(node.getPath()) + " LIKE " + DbAdapter.concat("n.path","'%'") + ") AND ( " + DbAdapter.cite(node.getPath())
                       + " NOT LIKE n.path)))) ");
        }
        sql.append(" ORDER BY s.sequence");
        return find(sql.toString(),0,200);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT s.section,s.style,s.styletype,s.stylecategory,s.node,s.status,s.position,s.sequence,s.visible,s.options,s.time FROM Section s INNER JOIN Node n ON s.node=n.node WHERE " + sql.substring(4),pos,size);
            while(db.next())
            {
                int j = 1;
                int id = db.getInt(j++);
                Section t = (Section) _cache.get(id);
                if(t == null)
                    t = new Section(id);
                t.style = db.getInt(j++);
                t.styletype = db.getInt(j++);
                t.stylecategory = db.getInt(j++);
                t.node = db.getInt(j++);
                t.status = db.getInt(j++);
                t.position = db.getInt(j++);
                t.sequence = db.getInt(j++);
                t.visible = db.getInt(j++);
                t.options = db.getInt(j++);
                t.time = db.getDate(j++);
                _cache.put(t.section,t);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public String getText(int i) throws SQLException
    {
        return getLayer(i)._strText;
    }

    public String getThemename(int i) throws SQLException
    {
        return getLayer(i)._strThemename;
    }

    public Vector getLanguages() throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM SectionLayer WHERE section=" + section);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v;
    }

    public String getAlt(int i) throws SQLException
    {
        return getLayer(i)._strAlt;
    }

    public Section clone() throws CloneNotSupportedException
    {
        Section t = (Section)super.clone();
        t.section = 0;
        return t;
    }
}
