package tea.entity.node;

import tea.entity.*;
import tea.db.*;
import java.util.*;

public class Field
{
    private String name;
    private String capital;
    private String dataType;
    private int type;
    private boolean exist;
    private static Cache _cache = new Cache(100);
    public Field(int type, String name, String capital, String dataType)
    {
        this.type = type;
        this.name = name;
        this.capital = capital;
        this.dataType = dataType;
        this.exist = true;
    }

    public Field(int type, String name)
    {
        this.type = type;
        this.name = name;
        loadBasic();
    }

    public String getName()
    {
        return name;
    }

    public String getCapital()
    {
        return capital;
    }

    public String getDataType()
    {
        return dataType;
    }

    void setName(String name)
    {
        this.name = name;
    }

    void setCapital(String capital)
    {
        this.capital = capital;
    }

    void setDataType(String dataType)
    {
        this.dataType = dataType;
    }

    public boolean exists()
    {
        return exist;
    }

    public static Enumeration findByType(int type)
    {
        Vector v = new Vector();
        String sql = null;
        switch (0)//ConnectionPool._nType
        {
        case 0:
            sql = "SHOW COLUMNS FROM " + Node.NODE_TYPE[type]; //DESC
            break;
        case 1:
            sql = "sp_columns " + Node.NODE_TYPE[type]; //"SELECT sc.name FROM sysobjects so INNER JOIN syscolumns sc ON so.id=sc.id WHERE so.name=" + DbAdapter.cite(Node.NODE_TYPE[type]);
            break;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql);
            while (db.next())
            {
                String name = null, dtype = null;
                switch (0)//ConnectionPool._nType
                {
                case 0:
                    name = db.getString(1);
                    dtype = db.getString(2);
                    break;
                case 1:
                    name = db.getString(4);
                    dtype = db.getString(6);
                    break;
                }
                if (!name.equalsIgnoreCase("node") && !name.equalsIgnoreCase("listing") && !name.equalsIgnoreCase("section") && !name.equalsIgnoreCase("language"))
                {
                    v.addElement(new Field(type, name, String.valueOf(name.charAt(0)).toUpperCase() + name.substring(1), dtype));
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Field find(int type, String columnName)
    {
        Field field = (Field) _cache.get(type + ":" + columnName);
        if (field == null)
        {
            field = new Field(type, columnName);
            _cache.put(type + ":" + columnName, field);
        }
        return field;
//        return new Field(type, columnName);
    }

    private void loadBasic()
    {
        if (this.type == 52)
        {
            if ("apply".equals(this.name)) //Apply表中的corpnode字段
            {
                this.capital = String.valueOf(name.charAt(0)).toUpperCase() + name.substring(1);
                this.dataType = "int";
                exist = true;
                return;
            }
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("sp_columns " + (type == 255 ? "Node" : Node.NODE_TYPE[type]));
            while (db.next())
            {
                String name = db.getString(4);
                if (name.equals(this.name))
                {
                    this.capital = String.valueOf(name.charAt(0)).toUpperCase() + name.substring(1);
                    this.dataType = db.getString(6);
                    exist = true;
                    break;
                }
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
    }
}
