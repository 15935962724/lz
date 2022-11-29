package tea.entity.node;

import tea.ui.*;
import tea.entity.*;
import tea.db.DbAdapter;
import java.util.Hashtable;
import java.util.*;

import tea.html.Text;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Image;
import java.sql.SQLException;

public class Landscape extends Entity
{
    class Layer
    {
        public Layer()
        {
        }

        private String logograph;
        private String picture;
    }


    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private int distinction;
    private int weather;
    private boolean homeland;
    private int area1;
    private int area2;
    private int style;
    private int language;
    private int node;

    public Landscape(int _nNode)
    {
        this.node = _nNode;
        _htLayer = new Hashtable();
        loadBasic();
    }

    public static Landscape find(int _nNode)
    {
        Landscape obj = (Landscape) _cache.get(new Integer(_nNode));
        if(obj == null)
        {
            obj = new Landscape(_nNode);
            _cache.put(new Integer(_nNode),obj);
        }
        return obj;
    }

    private void loadBasic()
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT distinction,weather,homeland,area1,area2,style FROM Landscape WHERE node=" + node);
            if(dbadapter.next())
            {
                distinction = dbadapter.getInt(1);
                weather = dbadapter.getInt(2);
                homeland = dbadapter.getInt(3) != 0;
                area1 = dbadapter.getInt(4);
                area2 = dbadapter.getInt(5);
                style = dbadapter.getInt(6);
            } else
            {

            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT language FROM AdedLayer WHERE aded=" + node);
            while(dbadapter.next())
            {
                v.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
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

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                // int j = dbadapter.getInt("NodeGetLanguage " + node + ", " + i);
                int j = this.getLanguage(i);

                dbadapter.executeQuery("SELECT picture,logograph FROM Landscape WHERE node=" + node + " AND language=" + j);
                if(dbadapter.next())
                {
                    layer.picture = dbadapter.getVarchar(j,i,1);
                    layer.logograph = dbadapter.getText(j,i,2);
                }
            } finally
            {
                dbadapter.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    public void set(int distinction,int weather,boolean homeland,int area1,int area2,int style,int language,String picture,String logograph)
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            /*
             *
             * dbadapter.executeUpdate("LandscapeEdit " + node + ", " + language + ", " + distinction + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(logograph) + ", " + weather + ", " + (homeland ? "1" : "0") + ", " + area1 + ", " + area2 + ", " + style );
             *
             */
            dbadapter.executeQuery("SELECT node FROM Landscape WHERE node=" + node + " AND language=" + language);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate(" UPDATE Landscape  SET    distinction=" + distinction + ",  weather    =" + weather + "    ,  homeland   =" + (homeland ? "1" : "0") + "   ,  area1      =" + area1 + "      , area2      =" + area2 + "      ,  style      =" + style + "       WHERE node=" + node);
                dbadapter.executeUpdate("  UPDATE Landscape  SET   picture    =" + DbAdapter.cite(picture) + "    ,  logograph  =" + DbAdapter.cite(logograph) + "     WHERE node=" + node + " AND language=" + language);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO Landscape(node,language,distinction,picture    ,logograph  ,weather    ,homeland   ,area1      ,area2      ,style      )VALUES(" + node + "," + language + "," + distinction + "," + DbAdapter.cite(picture) + "    ," + DbAdapter.cite(logograph) + "  ," + weather + "    ," + (homeland ? "1" : "0") + "   ," + area1 + "," + area2 + " ," + style + ")");
            }
            this.distinction = distinction;
            this.weather = weather;
            this.homeland = homeland;
            this.area1 = area1;
            this.area2 = area2;
            this.style = style;
            _htLayer.clear();
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
    }

    public static java.util.Enumeration findByStyle(String community,int style) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT DISTINCT Node.node FROM Landscape,Node WHERE Landscape.node=Node.node AND Node.community=" + DbAdapter.cite(community) + " AND Landscape.style=" + style);
            while(dbadapter.next())
            {
                vector.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        Landscape obj = Landscape.find(node._nNode);
        StringBuilder text = new StringBuilder();
        Class c = obj.getClass();
        r.add("tea/resource/Landscape");
        String subject = node.getSubject(h.language);

        Span span = null;
        ListingDetail detail = ListingDetail.find(listing,81,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("getSubject"))
            {
                value = (subject);
            } else if(itemname.equals("getPicture"))
            {
                value = obj.getPicture(h.language);
                if(value != null && value.length() > 0)
                {
                    value = (new Image(value,subject).toString());
                }
            } else if(itemname.equals("getLogograph"))
            {
                value = (obj.getLogograph(h.language));
            }

            /*
             * else if (itemname.equals("map")) { if (obj.getMap() != null && obj.getMap().length() > 0) { value=(new tea.html.Button("map", r.getString(language, "CBMap"), "javascript:window.showModalDialog('" + hostel.getMap() + "','','edge:raised;status:0;help:0;resizable:1;dialogWidth:609px;dialogHeight:507px;');").toString()); //+9 +27 } else { value=(null); } }
             */
            else

            if(itemname.equals("getDistinction")) // 星级
            {
                StringBuilder sb = new StringBuilder();
                for(int index = obj.getDistinction();index > 0;index--)
                {
                    sb.append("☆");
                }
                value = (sb.toString());
            } else if(itemname.equals("isHomeland")) //
            {
                if(obj.isHomeland())
                {
                    value = (r.getString(h.language,"Homeland"));
                } else
                {
                    value = (r.getString(h.language,"External"));
                }
            } else if(itemname.equals("getArea1")) //
            {
                String a;
                if(obj.getArea1() < 1000)
                {
                    a = "0" + obj.getArea1();
                } else
                {
                    a = String.valueOf(obj.getArea1());
                }
                value = (r.getString(h.language,"Area1." + a));
            } else if(itemname.equals("getArea2")) //
            {
                String a;
                if(obj.getArea1() < 1000)
                {
                    a = "0" + obj.getArea2();
                } else
                {
                    a = String.valueOf(obj.getArea2());
                }
                value = (r.getString(h.language,"Area2." + a));
            } else if(itemname.equals("getText")) // 内容
            {
                String name;
                if((node.getOptions() & 0x40L) == 0)
                {
                    name = (Text.toHTML(node.getText2(h.language)));
                } else
                {
                    name = (node.getText2(h.language));
                }
                value = (name);
            } else if(itemname.equals("getWeather")) // 天气
            {
                String name = null;
                if(obj.getWeather() != 0)
                {
                    name = (tea.entity.node.Node.find(obj.getWeather()).getSubject(h.language));
                }
                value = (name);
            } else if(itemname.equals("getStyle")) //
            {
                String name = null;
                if(obj.getStyle() != 0)
                {
                    name = (r.getString(h.language,"Style." + obj.getStyle()));
                }
                value = (name);
            } else

            if(itemname.equals("getCorrelation")) //
            {
                StringBuilder sb = new StringBuilder();
                ArrayList al = node.getCorrelation(h.language,81);
                for(int i = 0;i < al.size();i++)
                {
                    Node n = (Node) al.get(i);
                    sb.append("<span id='LandscapeIDCorrelationItem'><a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/landscape/" + n._nNode + "-" + h.language + ".htm'>" + n.getSubject(h.language) + "</a></span><br>");
                }
                value = sb.toString();
            } else if(itemname.equals("getCHostel")) //
            {
                java.util.Enumeration enumer = Correlative.find(node._nNode,48);
                StringBuilder sb = new StringBuilder();
                for(int index = 0;(index <= detail.getQuantity(itemname) || detail.getQuantity(itemname) == 0) && enumer.hasMoreElements();index++)
                {
                    int id = ((Integer) enumer.nextElement()).intValue();
                    Anchor anchor = new Anchor("/servlet/Hostel?node=" + id + "&language=" + h.language,tea.entity.node.Node.find(id).getSubject(h.language));
                    anchor.setTarget("_blank");
                    span = new Span(anchor);
                    span.setId("LandscapeIDCHostelItem");
                    sb.append(span.toString() + "<BR>");
                }
                value = (sb.toString());
            } else if(itemname.equals("getCLandscape")) //
            {
                java.util.Enumeration enumer = Correlative.find(node._nNode,81);
                StringBuilder sb = new StringBuilder();
                for(int index = 0;(index <= detail.getQuantity(itemname) || detail.getQuantity(itemname) == 0) && enumer.hasMoreElements();index++)
                {
                    int id = ((Integer) enumer.nextElement()).intValue();
                    Anchor anchor = new Anchor("/servlet/Landscape?node=" + id + "&language=" + h.language,tea.entity.node.Node.find(id).getSubject(h.language));
                    anchor.setTarget("_blank");
                    span = new Span(anchor);
                    span.setId("LandscapeIDCLandscapeItem");
                    sb.append(span.toString() + "<BR>");
                }
                value = (sb.toString());
            } else if(itemname.equals("getCLStyle")) //
            {
                java.util.Enumeration enumer = Landscape.findByStyle(node.getCommunity(),obj.getStyle());
                StringBuilder sb = new StringBuilder();
                for(int index = 0;(index <= detail.getQuantity(itemname) || detail.getQuantity(itemname) == 0) && enumer.hasMoreElements();index++)
                {
                    int id = ((Integer) enumer.nextElement()).intValue();
                    Anchor anchor = new Anchor("/servlet/Landscape?node=" + id + "&language=" + h.language,tea.entity.node.Node.find(id).getSubject(h.language));
                    anchor.setTarget("_blank");
                    span = new Span(anchor);
                    span.setId("LandscapeIDCLStyleItem");
                    sb.append(span.toString() + "<BR>");
                }
                value = (sb.toString());
            } else

            {
                try
                {
                    java.lang.reflect.Method m = c.getMethod(itemname,(java.lang.Class[])null);
                    Object o = m.invoke(obj,(Object[])null);
                    if(o instanceof String)
                    {
                        value = ((String) o);
                    } else if(o instanceof Integer)
                    {
                        value = (((Integer) o).toString());
                    }
                } catch(Exception ex)
                {
                    ex.printStackTrace();
                }
            }

            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/servlet/Landscape?node=" + node._nNode + "&language=" + h.language,value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("LandscapeID" + itemname);
            text.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return text.toString();
    }

    public int getDistinction()
    {
        return distinction;
    }

    public String getPicture(int language) throws SQLException
    {
        return getLayer(language).picture;
    }

    public String getLogograph(int language) throws SQLException
    {
        return getLayer(language).logograph;
    }

    public int getWeather()
    {
        return weather;
    }

    public boolean isHomeland()
    {
        return homeland;
    }

    public int getArea1()
    {
        return area1;
    }

    public int getArea2()
    {
        return area2;
    }

    public int getStyle()
    {
        return style;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getNode()
    {
        return node;
    }

}
