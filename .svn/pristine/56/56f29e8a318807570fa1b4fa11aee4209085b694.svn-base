package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;
import tea.ui.TeaSession;

public class Flight extends Entity
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private int node;
    private String mark;
    private Date takeoff;
    private Date descent;
    public static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm");
    private String logo;
    private boolean exists;
    private float price;
    private String week;
    private int startaerodrome;
    private int terminusaerodrome;
    private float tax;
    private int company;
    private boolean nonstop;
    private int fly;

    class Layer
    {
        public Layer()
        {
        }

        private String types;
        private String starttime;
        private String terminus;
        private String eat;
        private String remark;
    }


    public Flight(int node)
    {
        _htLayer = new Hashtable();
        this.node = node;
        loadBasic();
    }

    private void loadBasic()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,mark, takeoff ,descent,logo,price,week,startaerodrome,terminusaerodrome,tax,company,nonstop,fly FROM Flight WHERE node=" + node);
            if(db.next())
            {
                node = db.getInt(1);
                mark = db.getString(2);
                takeoff = db.getDate(3);
                descent = db.getDate(4);
                logo = db.getString(5);
                price = db.getFloat(6);
                week = db.getString(7);
                startaerodrome = db.getInt(8);
                terminusaerodrome = db.getInt(9);
                tax = db.getFloat(10);
                company = db.getInt(11);
                nonstop = db.getInt(12) != 0;
                fly = db.getInt(13);
                exists = true;
            } else
            {
                exists = false;
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
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
                db.executeQuery("SELECT types,starttime,terminus,eat,remark FROM Flight WHERE node=" + node + " AND language=" + j);
                if(db.next())
                {
                    layer.types = db.getVarchar(j,i,1);
                    layer.starttime = db.getVarchar(j,i,2);
                    layer.terminus = db.getVarchar(j,i,3);
                    layer.eat = db.getVarchar(j,i,4);
                    layer.remark = db.getVarchar(j,i,5);
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
            db.executeQuery("SELECT language FROM Flight WHERE node=" + node);
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

    public void delete()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flight WHERE node=" + node);
            _cache.remove(new Integer(node));
            _htLayer.clear();
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public static Flight find(int node)
    {
        Flight flightObj = (Flight) _cache.get(new Integer(node));
        if(flightObj == null)
        {
            flightObj = new Flight(node);
            _cache.put(new Integer(node),flightObj);
        }
        return flightObj;
    }

    /*
     * public static java.util.Enumeration findByNode(int node) {
     *
     * Vector vector = new java.util.Vector(); DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT flight FROM Flight WHERE node=" + node); while (db.next()) { vector.addElement(new Integer(db.getInt(1))); } } catch (Exception exception) { exception.printStackTrace(); } finally { db.close(); } return vector.elements(); }
     */
    /*
     * private void weave() { allCourse = new StringBuilder(); allCourse.append(this.course[0]); for (int i = 1; i < course.length && course[i] != null && course[i].length() > 0; i++) { allCourse.append("--" + this.course[i]); }
     *
     * allDescent = new StringBuilder(); allDescent.append(this.descent[0]); for (int i = 1; i < descent.length && descent[i] != null && descent[i].length() > 0; i++) { allDescent.append("--" + this.descent[i]); }
     *
     * this.allTakeoff = new StringBuilder(); allTakeoff.append(this.takeoff[0]); for (int i = 1; i < takeoff.length && takeoff[i] != null && takeoff[i].length() > 0; i++) { allTakeoff.append("--" + this.takeoff[i]); } }
     */
    public static void create(int node,String mark,String week,Date takeoff,Date descent,String logo,float price,int starttimeaerodrome,int terminusaerodrome,float tax,int company,boolean nonstop,int fly,int language,String types,String starttime,String terminus,String eat,String remark)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * db.executeUpdate("FlightCreate " + node + "," + DbAdapter.cite(mark) + "," + DbAdapter.cite(week) + "," + DbAdapter.cite(takeoff) + "," + DbAdapter.cite(descent) + "," + DbAdapter.cite(logo) + "," + price + "," + starttimeaerodrome + "," + terminusaerodrome + "," + tax + "," + company + "," + (nonstop ? "1" : "0") + "," + fly + "," + language + "," + DbAdapter.cite(types) + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(terminus) + "," + DbAdapter.cite(eat) + "," +
             * DbAdapter.cite(remark));
             */
            db.executeUpdate("INSERT INTO Flight(node , mark ,week, takeoff, descent,logo,price,starttimeaerodrome ,terminusaerodrome,tax ,company ,nonstop ,fly)VALUES(" + node + " , " + DbAdapter.cite(mark) + "," + DbAdapter.cite(week) + " , " + DbAdapter.cite(takeoff) + ", " + DbAdapter.cite(descent) + "," + DbAdapter.cite(logo) + "," + price + "," + starttimeaerodrome + " ," + terminusaerodrome + "," + tax + " ," + company + " ," + (nonstop ? "1" : "0") + "," + fly + ")");
            db.executeUpdate(" INSERT INTO Flight (node, language, types   , starttime   , terminus, eat     , remark  )VALUES( " + node + ", " + language + "," + DbAdapter.cite(types) + "   , " + DbAdapter.cite(starttime) + "   , " + DbAdapter.cite(terminus) + ", " + DbAdapter.cite(eat) + "     , " + DbAdapter.cite(remark) + "  )");
            _cache.remove(new Integer(node));
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public void set(int node,String mark,String week,Date takeoff,Date descent,String logo,float price,int starttimeaerodrome,int terminusaerodrome,float tax,int company,boolean nonstop,int fly,int language,String types,String starttime,String terminus,String eat,String remark)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * db.executeUpdate("FlightEdit " + node + "," + DbAdapter.cite(mark) + "," + DbAdapter.cite(week) + "," + DbAdapter.cite(takeoff) + "," + DbAdapter.cite(descent) + "," + DbAdapter.cite(logo) + "," + price + "," + starttimeaerodrome + "," + terminusaerodrome + "," + tax + "," + company + "," + (nonstop ? "1" : "0") + "," + fly + "," + language + "," + DbAdapter.cite(types) + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(terminus) + "," + DbAdapter.cite(eat) + "," +
             * DbAdapter.cite(remark));
             */
            db.executeUpdate("UPDATE Flight SET price=" + price + ",logo=" + DbAdapter.cite(logo) + "   ,mark=" + DbAdapter.cite(mark) + "   ,week	=" + DbAdapter.cite(week) + "   ,takeoff =" + DbAdapter.cite(takeoff) + ",descent =" + DbAdapter.cite(descent) + ",starttimeaerodrome   =" + starttimeaerodrome + "  ,terminusaerodrome=" + terminusaerodrome + ",tax  =" + tax + " ,company  =" + company + " ,nonstop  =" + (nonstop ? "1" : "0") + "  ,fly=" + fly + " WHERE node=" + node);
            db.executeQuery("SELECT node FROM Flight WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate("UPDATE Flight SET types   =" + DbAdapter.cite(types) + "   ,starttime   =" + DbAdapter.cite(starttime) + "   ,terminus=" + DbAdapter.cite(terminus) + ",eat     =" + DbAdapter.cite(eat) + "     ,remark  =" + DbAdapter.cite(remark) + "  WHERE node=" + node + " AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO Flight(node   , mark   ,week, takeoff, descent,logo,price,startaerodrome ,terminusaerodrome,tax,company,nonstop ,fly  )VALUES(" + node + ", " + DbAdapter.cite(mark) + "  ," + DbAdapter.cite(week) + " , " + DbAdapter.cite(takeoff) + "," + DbAdapter.cite(descent) + "," + DbAdapter.cite(logo) + "," + price + "," + starttimeaerodrome + "," + terminusaerodrome + "," + tax + "," + company + "," + (nonstop ? "1" : "0") + "," + fly + ")");
                db.executeUpdate(" INSERT INTO Flight ( node,language ,types   , starttime   , terminus, eat     , remark  )VALUES( " + node + "," + language + ", " + DbAdapter.cite(types) + "   , " + DbAdapter.cite(starttime) + "   , " + DbAdapter.cite(terminus) + ", " + DbAdapter.cite(eat) + "     , " + DbAdapter.cite(remark) + "  )");
            }
            this.node = node;
            this.mark = mark;
            this.week = week;
            this.takeoff = takeoff;
            this.descent = descent;
            this.logo = logo;
            this.price = price;
            this.startaerodrome = startaerodrome;
            this.terminusaerodrome = terminusaerodrome;
            this.tax = tax;
            this.company = company;
            this.nonstop = nonstop;
            this.fly = fly;
            _htLayer.clear();
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public int getNode()
    {
        return node;
    }

    public String getMark()
    {
        return mark;
    }

    public Date getTakeoff()
    {
        return takeoff;
    }

    public String getTakeoffToString()
    {
        return sdf.format(takeoff);
    }

    public Date getDescent()
    {
        return descent;
    }

    public String getLogo()
    {
        return logo;
    }

    public boolean isExists()
    {
        return exists;
    }

    public float getPrice()
    {
        return price;
    }

    public String getWeek()
    {
        return week;
    }

    public int getStartaerodrome()
    {
        return startaerodrome;
    }

    public int getTerminusaerodrome()
    {
        return terminusaerodrome;
    }

    public float getTax()
    {
        return tax;
    }

    public int getCompany()
    {
        return company;
    }

    public boolean isNonstop()
    {
        return nonstop;
    }

    public int getFly()
    {
        return fly;
    }

    public String getDescentToString()
    {
        return sdf.format(descent);
    }

    public String getTypes(int language) throws SQLException
    {
        return getLayer(language).types;
    }

    public String getStart(int language) throws SQLException
    {
        return getLayer(language).starttime;
    }

    public String getTerminus(int language) throws SQLException
    {
        return getLayer(language).terminus;
    }

    public String getEat(int language) throws SQLException
    {
        return getLayer(language).eat;
    }

    public String getRemark(int language) throws SQLException
    {
        return getLayer(language).remark;
    }

    public static Text getDetail(Node node,Http h,Listing listing,String target,tea.resource.Resource r) throws SQLException
    {
        int iListing = listing.getListing();

        Text text = new Text();
        Span span = null;
        Flight flight = Flight.find(node._nNode);
        ListingDetail detail = ListingDetail.find(iListing,49,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0 || name.startsWith("b_"))
            {
                continue;
            } else if(name.equals("name"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("logo"))
            {
                if(flight.getLogo() != null && flight.getLogo().length() > 0)
                {
                    value = (new Image(flight.getLogo()).toString());
                } else
                {
                    value = (null);
                }
            } else // 航班
            if(name.equals("getTypes"))
            {
                value = (flight.getTypes(h.language));
            } else

            if(name.equals("getStart"))
            {
                value = (flight.getStart(h.language));
            } else if(name.equals("getTerminus"))
            {
                value = (flight.getTerminus(h.language));
            } else if(name.equals("getEat"))
            {
                value = (flight.getEat(h.language));
            } else if(name.equals("getRemark"))
            {
                value = (flight.getRemark(h.language));
            } else if(name.equals("isNonstop"))
            {
                value = ((flight.isNonstop() ? r.getString(h.language,"Yes") : r.getString(h.language,"No")));
            } else if(name.equals("getFly"))
            {
                switch(flight.getFly())
                {
                case 0:
                    value = (r.getString(h.language,"OneWay"));
                    break;
                case 1:
                    value = (r.getString(h.language,"Cruise"));
                    break;
                case 2:
                    value = (r.getString(h.language,"Linkage"));
                    break;
                }
            } else if(name.equals("getCompany"))
            {
                value = (Node.find(flight.getCompany()).getSubject(h.language));
            } else if(name.equals("getTerminusaerodrome"))
            {
                tea.entity.site.Aerodrome a = tea.entity.site.Aerodrome.find(flight.getTerminusaerodrome());
                value = (a.getName(h.language));
            } else if(name.equals("getStartaerodrome"))
            {
                tea.entity.site.Aerodrome a = tea.entity.site.Aerodrome.find(flight.getStartaerodrome());
                value = (a.getName(h.language));
            }

            /*
             * if (name.equals("getPrice")) { value=(String.valueOf(flight.getPrice())); }
             */
            //
            else
            {

                try
                {
                    Class c = flight.getClass();
                    java.lang.reflect.Method m = c.getMethod(name,(java.lang.Class[])null);
                    Object obj = m.invoke(flight,(Object[])null);
                    if(obj instanceof String)
                    {
                        value = ((String) obj);
                    } else if(obj instanceof Integer)
                    {
                        value = (((Integer) obj).toString());
                    } else if(obj instanceof Float)
                    {
                        value = (((Float) obj).toString());
                    }
                } catch(Exception ex)
                {
                    value = (null);
                }
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/flight/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("FlightID" + name);
            text.add(new Text(detail.getBeforeItem(name) + span + detail.getAfterItem(name)));

        }
        // 舱位

        java.util.Enumeration enumeration2 = Berth.findByNode(node._nNode);
        while(enumeration2.hasMoreElements())
        {
            Berth berth = Berth.find(((Integer) enumeration2.nextElement()).intValue());
            Iterator ei = detail.keys();
            while(ei.hasNext())
            {
                String name = (String) ei.next(),value = null;
                int istype = detail.getIstype(name);
                if(istype == 0 || !name.startsWith("b_"))
                {
                    continue;
                }
                if(name.equals("b_getName"))
                {
                    value = (berth.getName(h.language));
                } else if(name.equals("b_getAagio"))
                {
                    value = String.valueOf(berth.getAagio());
                } else if(name.equals("b_getPrice"))
                {
                    value = String.valueOf(berth.getPrice());
                }
                if(detail.getAnchor(name) != 0)
                {
                    Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/flight/" + node._nNode + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                } else
                {
                    span = new Span(value);
                }
                span.setId("FlightID" + name);
                text.add(new Text(detail.getBeforeItem(name) + span + detail.getAfterItem(name)));
            }
        }
        return text;
    }

}
