package tea.entity.site;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.text.*;

public class CommunityOption extends Entity
{
    private static final Cache _cache = new Cache(100);
    private static Hashtable DEF = new Hashtable();
    static
    {
        DEF.put("tenderrole","/");
        DEF.put("eonip","eon.redcome.com");
        DEF.put("editortoolbar","/Source/DocProps/-/NewPage/Preview/-/Templates/-/Cut/Copy/Paste/PasteText/PasteWord/-/Print/SpellCheck/-/Undo/Redo/-/Find/Replace/-/SelectAll/RemoveFormat/-/Form/Checkbox/Radio/TextField/Textarea/Select/Button/ImageButton/HiddenField/\\n/Bold/Italic/Underline/StrikeThrough/-/Subscript/Superscript/-/OrderedList/UnorderedList/-/Outdent/Indent/-/JustifyLeft/JustifyCenter/JustifyRight/JustifyFull/-/Link/Unlink/Anchor/-/Image/Flash/Embed/Media/Table/Rule/Smiley/SpecialChar/PageBreak/\\n/Style/FontFormat/FontName/FontSize/-/TextColor/BGColor/-/FitWindow/");
        //第一站
        DEF.put("eyptemplate","左窄右宽");
        DEF.put("eypstyle","01浅紫");
        DEF.put("eyphitsmember","/"); //最近访客_会员
        DEF.put("eyphitstime","/"); //最近访客_时间
        //
        DEF.put("msnwidth","500");
        DEF.put("msnheight","400");
        //订阅
        DEF.put("subnode","/");
    }

    private String community;
    private Hashtable ht;
    //招标:/tenderinfo/tenderrole/
    //EON:/eonip/
    //SMS:/smsuser/smspwd/
    //OpenID:/openidhost/openidport/
    //DDNS:/ddnshost0/ddnshost1/ddnstime
    //sync:/synchost/syncport/syncperiod/synctime/
    //EYP:/eyptemplate/eypstyle/eyphits/
    public static CommunityOption find(String community)
    {
        CommunityOption obj = (CommunityOption) _cache.get(community);
        if(obj == null)
        {
            obj = new CommunityOption(community);
            _cache.put(community,obj);
        }
        return obj;
    }

    public CommunityOption(String community)
    {
        this.community = community;
        this.ht = new Hashtable();
    }

    public int getInt(String name) throws SQLException
    {
        String str = get(name);
        if(str == null)
        {
            return 0;
        }
        int value = 0;
        try
        {
            value = Integer.parseInt(str);
        } catch(NumberFormatException ex)
        {
        }
        return value;
    }

    public Date getDate(String name) throws SQLException
    {
        String str = get(name);
        if(str == null)
        {
            return null;
        }
        Date time = null;
        try
        {
            time = sdf3.parse(str);
        } catch(ParseException ex)
        {
        }
        return time;
    }

    public String get(String name) throws SQLException
    {
        String value = (String) ht.get(name);
        if(value == null)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT value FROM CommunityOption WHERE community=" + DbAdapter.cite(community) + " AND name=" + DbAdapter.cite(name));
                if(db.next())
                {
                    value = db.getString(1);
                } else
                {
                    value = (String) DEF.get(name);
                }
            } finally
            {
                db.close();
            }
            if(value != null)
            {
                ht.put(name,value);
            }
        }
        return value;
    }

    public static Enumeration find(String name,String value) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community FROM CommunityOption WHERE name=" + db.cite(name) + " AND value=" + db.cite(value));
            while(db.next())
            {
                v.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void set(String name,Object value) throws SQLException
    {
        String str;
        if(value instanceof Date)
        {
            str = sdf3.format((Date) value);
        } else
        {
            str = value.toString();
        }
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(0,"UPDATE CommunityOption SET value=" + DbAdapter.cite(str) + " WHERE community=" + DbAdapter.cite(community) + " AND name=" + DbAdapter.cite(name));
            if(j < 1)
            {
                db.executeUpdate(0,"INSERT INTO CommunityOption(community,name,value)VALUES(" + db.cite(community) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(str) + ")");
            }
        } finally
        {
            db.close();
        }
        ht.remove(name);
    }

    public void delete(String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"DELETE FROM CommunityOption WHERE community=" + DbAdapter.cite(community) + " AND name=" + DbAdapter.cite(name));
        } finally
        {
            db.close();
        }
        ht.remove(name);
    }

    public String getCommunity()
    {
        return community;
    }

}
