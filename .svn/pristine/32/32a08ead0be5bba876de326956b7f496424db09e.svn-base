package tea.entity.util;

import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.site.*;
import java.util.*;

public class Lucenechoice
{
    public static Cache _cache = new Cache(100);
    public int lucenechoice;
    public int lucene;
    public int sequence;
    public boolean exists;
    private Hashtable _htLayer;

    class Layer
    {
        private String value;
        private String label;
        private boolean layerExists;
    }


    public Lucenechoice(int lucenechoice) throws SQLException
    {
        this.lucenechoice = lucenechoice;
        _htLayer = new Hashtable();
    }


    public static Lucenechoice find(int lucenechoice) throws SQLException
    {
        Lucenechoice t = (Lucenechoice) _cache.get(lucenechoice);
        if(t == null)
        {
            ArrayList al = find(" AND lucenechoice=" + lucenechoice,0,1);
            t = al.size() < 1 ? new Lucenechoice(lucenechoice) : (Lucenechoice) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT lucenechoice,lucene,sequence FROM Lucenechoice WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                Lucenechoice t = new Lucenechoice(db.getInt(1));
                t.lucene = db.getInt(2);
                t.sequence = db.getInt(3);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }


    public static int count(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(lucenechoice) FROM Lucenechoice WHERE 1=1" + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public void set() throws SQLException
    {
        String sql;
        if(lucenechoice < 1)
            sql = "INSERT INTO Lucenechoice(lucenechoice,lucene,sequence)VALUES(" + (lucenechoice = Seq.get()) + "," + lucene + "," + sequence + ")";
        else
            sql = "UPDATE Lucenechoice SET sequence=" + sequence + " WHERE lucenechoice=" + lucenechoice;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lucenechoice,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lucenechoice);
    }

    public void setLayer(int language,String value,String label) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(lucenechoice,"UPDATE LucenechoiceLayer SET value=" + DbAdapter.cite(value) + ",label=" + DbAdapter.cite(label) + " WHERE lucenechoice=" + lucenechoice + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate(lucenechoice,"INSERT INTO LucenechoiceLayer(lucenechoice,language,value,label)VALUES(" + lucenechoice + "," + language + "," + DbAdapter.cite(value) + "," + DbAdapter.cite(label) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void delete(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(lucenechoice,"DELETE LucenechoiceLayer WHERE lucenechoice=" + lucenechoice + " AND language=" + language);
            db.executeQuery("SELECT lucenechoice FROM LucenechoiceLayer WHERE lucenechoice=" + lucenechoice);
            if(!db.next())
            {
                db.executeUpdate(lucenechoice,"DELETE Lucenechoice WHERE lucenechoice=" + lucenechoice);
                exists = false;
                _cache.remove(lucene);
            }
        } finally
        {
            db.close();
        }
        _htLayer.remove(language);
    }

    private Layer getLayer(int language) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(language));
        if(layer == null)
        {
            layer = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                int j = language;
                db.executeQuery("SELECT language FROM LucenechoiceLayer WHERE lucenechoice=" + lucenechoice + " AND language=" + j);
                if(db.next())
                {
                    layer.layerExists = true;
                } else
                {
                    layer.layerExists = false;
                    if(j == 1)
                    {
                        j = 2;
                    } else if(j == 2)
                    {
                        j = 1;
                    }
                    db.executeQuery("SELECT language FROM LucenechoiceLayer WHERE lucenechoice=" + lucenechoice + " AND language=" + j);
                    if(!db.next())
                    {
                        j = db.getInt("SELECT language FROM LucenechoiceLayer WHERE lucenechoice=" + lucenechoice);
                    }
                }
                db.executeQuery("SELECT value,label FROM LucenechoiceLayer WHERE lucenechoice=" + lucenechoice + " AND language=" + j);
                if(db.next())
                {
                    layer.value = db.getVarchar(j,language,1);
                    layer.label = db.getVarchar(j,language,2);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(language),layer);
        }
        return layer;
    }


    public boolean isLayerExists(int language) throws SQLException
    {
        return getLayer(language).layerExists;
    }

    public String getValue(int language) throws SQLException
    {
        return getLayer(language).value;
    }

    public String getLabel(int language) throws SQLException
    {
        return getLayer(language).label;
    }
}
