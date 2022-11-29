package tea.entity.node;

import java.util.*;
import tea.entity.*;
import tea.db.DbAdapter;

import tea.html.Anchor;
import tea.html.Span;
import tea.html.Text;
import java.sql.SQLException;
import tea.ui.TeaSession;

public class Environmental
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private boolean classes;
    private String address;
    private String postalcode;
    private String phone;
    private String fax;
    private String polyName;
    private int type;
    private String ployAdd;
    private Date ployTime;
    private String ployCon;
    private String ploy;
    private String point;
    private String object;
    private String[] vemark;
    private String sponsor;
    private String vouchName;
    private String vouchCom;
    private String vouchDuty;
    private String vouchTele;
    private String comm;
    private String comTele;
    private String conName;
    private String vouch;
    private boolean exists;
    public static final String ENVIRONMENTAL_TYPE[] =
            {"污染治理","环保宣传","环境教育","沙漠治理","植树造林","生物多样性保护","水土保持","环境科研","环境管理","与环保违法行为作斗争","其他"};

    public static Environmental find(int node,int language) throws SQLException
    {
        Environmental obj = (Environmental) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Environmental(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public Environmental(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // int j = db.getInt("EnvironmentalGetLanguage " + node + "," + language);
            int j = this.getLanguage(language);
            db.executeQuery("SELECT classes		,address		,postalcode	,phone		,fax		,polyname	,type		,ployadd		,ploytime	,ploycon		,ploy		,point		,object		,sponsor ,vemark				,vemark2		,vemark3		,vemark4		,vemark5		,vemark6		,vemark7		,vouchname	,vouchcom	,vouchduty	,vouchtele	,comm		,comtele		,conname		,vouch		      FROM Environmental WHERE node= " + node + " AND language=" + j);
            if(db.next())
            {
                vemark = new String[7];
                classes = db.getInt(1) != 0;
                address = db.getVarchar(j,language,2);
                postalcode = db.getString(3);
                phone = db.getString(4);
                fax = db.getString(5);
                polyName = db.getVarchar(j,language,6);
                type = db.getInt(7);
                ployAdd = db.getVarchar(j,language,8);
                ployTime = db.getDate(9);
                ployCon = db.getVarchar(j,language,10);
                ploy = db.getVarchar(j,language,11);
                point = db.getVarchar(j,language,12);
                object = db.getVarchar(j,language,13);
                sponsor = db.getVarchar(j,language,14);
                vemark[0] = db.getVarchar(j,language,15);
                vemark[1] = db.getVarchar(j,language,16);
                vemark[2] = db.getVarchar(j,language,17);
                vemark[3] = db.getVarchar(j,language,18);
                vemark[4] = db.getVarchar(j,language,19);
                vemark[5] = db.getVarchar(j,language,20);
                vemark[6] = db.getVarchar(j,language,21);
                vouchName = db.getVarchar(j,language,22);
                vouchCom = db.getVarchar(j,language,23);
                vouchDuty = db.getVarchar(j,language,24);
                vouchTele = db.getString(25);
                comm = db.getVarchar(j,language,26);
                comTele = db.getString(27);
                conName = db.getVarchar(j,language,28);
                vouch = db.getVarchar(j,language,29);

                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM Environmental WHERE node=" + node);
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

    public void set(boolean classes,String address,String postalcode,String phone,String fax,String polyname,int type,String ployadd,java.util.Date ploytime,String ploycon,String ploy,String point,String object,String sponsor,String vemark[],String vouchname,String vouchcom,String vouchduty,String vouchtele,String comm,String comtele,String conname,String vouch) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * db.executeUpdate("EnvironmentalEdit " + node + "," + language + "," + (classes ? "1" : "0") + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(postalcode) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(polyname) + "," + (type) + "," + DbAdapter.cite(ployadd) + "," + DbAdapter.cite(ploytime) + "," + DbAdapter.cite(ploycon) + "," + DbAdapter.cite(ploy) + "," + DbAdapter.cite(point) + "," + DbAdapter.cite(object) + "," + DbAdapter.cite(sponsor) +
             * "," + DbAdapter.cite(vemark[0]) + "," + DbAdapter.cite(vemark[1]) + "," + DbAdapter.cite(vemark[2]) + "," + DbAdapter.cite(vemark[3]) + "," + DbAdapter.cite(vemark[4]) + "," + DbAdapter.cite(vemark[5]) + "," + DbAdapter.cite(vemark[6]) + "," + DbAdapter.cite(vouchname) + "," + DbAdapter.cite(vouchcom) + "," + DbAdapter.cite(vouchduty) + "," + DbAdapter.cite(vouchtele) + "," +
             *
             * DbAdapter.cite(comm) + "," + DbAdapter.cite(comtele) + "," + DbAdapter.cite(conname) + "," + DbAdapter.cite(vouch));
             *
             */
            db.executeQuery("SELECT node FROM Environmental WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate("UPDATE Environmental SET  classes		= " + (classes ? "1" : "0") + "	,address		= " + DbAdapter.cite(address) + "	,postalcode	= " + DbAdapter.cite(postalcode) + "	,phone		= " + DbAdapter.cite(phone) + "		,fax		= " + DbAdapter.cite(fax) + "		,polyname	= " + DbAdapter.cite(polyname) + "	,type		= " + (type) + "		,ployadd		= " + DbAdapter.cite(ployadd) + "	,ploytime	= " + DbAdapter.cite(ploytime) + "	,ploycon		= " + DbAdapter.cite(ploycon) + "	,ploy		= "
                                 + DbAdapter.cite(ploy) + "		,point		= " + DbAdapter.cite(point) + "		,object		= " + DbAdapter.cite(object) + "		,sponsor		= " + DbAdapter.cite(sponsor) + "	,vemark		= " + DbAdapter.cite(vemark[0]) + "		,vemark2		= " + DbAdapter.cite(vemark[1]) + "	,vemark3		= " + DbAdapter.cite(vemark[2]) + "	,vemark4		= " + DbAdapter.cite(vemark[3]) + "	,vemark5		= " + DbAdapter.cite(vemark[4]) + "	,vemark6		= " + DbAdapter.cite(vemark[5]) + "	,vemark7		= " + DbAdapter.cite(vemark[6])
                                 + "	,vouchname	= " + DbAdapter.cite(vouchname) + "	,vouchcom	= " + DbAdapter.cite(vouchcom) + "	,vouchduty	= " + DbAdapter.cite(vouchduty) + "	,vouchtele	= " + DbAdapter.cite(vouchtele) + "	,comm		= " + DbAdapter.cite(comm) + "		,comtele		= " + DbAdapter.cite(comtele) + "	,conname		= " + DbAdapter.cite(conname) + "	,vouch		= " + DbAdapter.cite(vouch) + "		WHERE node=" + node + " AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO Environmental(node,language, classes		,address		,postalcode	,phone		,fax		,polyname	,type		,ployadd		,ploytime	,ploycon,ploy,point		,object	,sponsor ,vemark,vemark2,vemark3,vemark4,vemark5,vemark6,vemark7,vouchname	,vouchcom	,vouchduty	,vouchtele	,comm		,comtele		,conname		,vouch	   )VALUES(" + node + "," + language + " , " + (classes ? "1" : "0") + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(postalcode) + "	," + DbAdapter.cite(phone) + ","
                                 + DbAdapter.cite(fax) + "		," + DbAdapter.cite(polyname) + "	," + (type) + "," + DbAdapter.cite(ployadd) + "," + DbAdapter.cite(ploytime) + "	," + DbAdapter.cite(ploycon) + "," + DbAdapter.cite(ploy) + "	," + DbAdapter.cite(point) + "	," + DbAdapter.cite(object) + "," + DbAdapter.cite(sponsor) + " ," + DbAdapter.cite(vemark[0]) + "	," + DbAdapter.cite(vemark[1]) + "	," + DbAdapter.cite(vemark[2]) + "		," + DbAdapter.cite(vemark[3]) + "		," + DbAdapter.cite(vemark[4]) + "		,"
                                 + DbAdapter.cite(vemark[5]) + "		," + DbAdapter.cite(vemark[6]) + "		," + DbAdapter.cite(vouchname) + "	," + DbAdapter.cite(vouchcom) + "	," + DbAdapter.cite(vouchduty) + "	," + DbAdapter.cite(vouchtele) + "	," + DbAdapter.cite(comm) + "		," + DbAdapter.cite(comtele) + "		," + DbAdapter.cite(conname) + "		," + DbAdapter.cite(vouch) + "	  )");
            }
            _cache.remove(node + ":" + language);
        } finally
        {
            db.close();
        }
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        r.add("tea/resource/Environmental");
        Span span = null;
        StringBuilder sb = new StringBuilder();
        tea.entity.node.Environmental obj = tea.entity.node.Environmental.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,75,h.language);
        java.util.Iterator enumeration = detail.keys();
        while(enumeration.hasNext())
        {
            String name = (String) enumeration.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("address"))
            {
                value = (obj.getAddress());
            } else if(name.equals("postalcode"))
            {
                value = ((obj.getPostalcode()));
            } else if(name.equals("classes"))
            {
                value = ((obj.isClasses() ? r.getString(h.language,"Collectivity") : r.getString(h.language,"Individual")));
            } else if(name.equals("type"))
            {
                if(obj.getType() > 0)
                {
                    value = (ENVIRONMENTAL_TYPE[obj.getType() - 1]);
                } else
                {
                    value = ("");
                }
            } else if(name.equals("phone"))
            {
                value = (obj.getPhone());
            } else if(name.equals("fax"))
            {
                value = (obj.getFax());
            } else if(name.equals("polyname"))
            {
                value = (obj.getPolyName());
            } else if(name.equals("ployadd"))
            {
                value = (obj.getPloyAdd());
            } else if(name.equals("ploytime"))
            {
                value = (obj.getPloyTime("yyyy-MM-dd"));
            } else if(name.equals("text"))
            {
                value = (node.getText2(h.language));
            } else if(name.equals("ploy"))
            {
                value = (obj.getPloy());
            } else if(name.equals("point"))
            {
                value = (obj.getPoint());
            } else if(name.equals("object"))
            {
                value = (obj.getObject());
            } else if(name.equals("vemark"))
            {
                value = (obj.getVemark()[0]);
            } else if(name.equals("vemark2"))
            {
                value = (obj.getVemark()[1]);
            } else if(name.equals("vemark3"))
            {
                value = (obj.getVemark()[2]);
            } else if(name.equals("vemark4"))
            {
                value = (obj.getVemark()[3]);
            } else if(name.equals("vemark5"))
            {
                value = (obj.getVemark()[4]);
            } else if(name.equals("vemark6"))
            {
                value = (obj.getVemark()[5]);
            } else if(name.equals("vemark7"))
            {
                value = (obj.getVemark()[6]);
            } else if(name.equals("sponsor"))
            {
                value = (obj.getSponsor());
            } else if(name.equals("vouchname"))
            {
                value = (obj.getVouchName());
            } else if(name.equals("vouchcom"))
            {
                value = (obj.getVouchCom());
            } else if(name.equals("vouchduty"))
            {
                value = (obj.getVouchDuty());
            } else if(name.equals("vouchtele"))
            {
                value = (obj.getVouchTele());
            } else if(name.equals("comm"))
            {
                value = (obj.getComm());
            } else if(name.equals("comtele"))
            {
                value = (obj.getComTele());
            } else if(name.equals("conname"))
            {
                value = (obj.getConName());
            } else if(name.equals("vouch"))
            {
                value = (obj.getVouch());
            }

            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/environmental/" + node + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("EnvironmentalID" + name);
            sb.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
        }
        return sb.toString();
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public boolean isClasses()
    {
        return classes;
    }

    public String getAddress()
    {
        return address;
    }

    public String getPostalcode()
    {
        return postalcode;
    }

    public String getPhone()
    {
        return phone;
    }

    public String getFax()
    {
        return fax;
    }

    public String getPolyName()
    {
        return polyName;
    }

    public int getType()
    {
        return type;
    }

    public String getPloyAdd()
    {
        return ployAdd;
    }

    public Date getPloyTime()
    {
        return ployTime;
    }

    public String getPloyTime(String pattern)
    {
        if(ployTime == null)
        {
            return "";
        } else
        {
            return new java.text.SimpleDateFormat(pattern).format(ployTime);
        }
    }

    public String getPloyCon()
    {
        return ployCon;
    }

    public String getPloy()
    {
        return ploy;
    }

    public String getPoint()
    {
        return point;
    }

    public String getObject()
    {
        return object;
    }

    public String[] getVemark()
    {
        return vemark;
    }

    public String getSponsor()
    {
        return sponsor;
    }

    public String getVouchName()
    {
        return vouchName;
    }

    public String getVouchCom()
    {
        return vouchCom;
    }

    public String getVouchDuty()
    {
        return vouchDuty;
    }

    public String getVouchTele()
    {
        return vouchTele;
    }

    public String getComm()
    {
        return comm;
    }

    public String getComTele()
    {
        return comTele;
    }

    public String getConName()
    {
        return conName;
    }

    public String getVouch()
    {
        return vouch;
    }

    public boolean isExists()
    {
        return exists;
    }
}
