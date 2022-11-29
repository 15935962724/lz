package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;

public class Expert extends Entity
{
    private int _nNode;
    private Hashtable _htLayer;
    private static Cache _cache = new Cache(100);
    private int language;
    private boolean sex = true; // 男
    private Date birthday;
    private String photo;
    private String photoBig;
    private String alias;
    private java.util.Date matriculation;
    private String folk;
    private String classes;
    private int graduate;
    private String aim;
    private String duty;
    private String technical;
    private String homePhone;
    private String handset;
    private String MSN;
    private String QQ;
    private String leaveWord;
    private String place;
    private String languageClass;
    String _strContact;
    String _strEmail;
    String _strOrganization;
    String _strAddress;
    String _strCity;
    String _strState;
    String _strZip;
    String _strCountry;
    String _strTelephone;
    String _strFax;
    String _strWebPage;
    int _nWebLanguage;
    String rfield;//主要研究领域
 	String mrr;//主要研究经历
    String mrrs;//主要研究成果
    String oci;//其他联系方式

    public String getOrganization() throws SQLException
    {
        return _strOrganization;
    }

    public String getAddress() throws SQLException
    {
        return _strAddress;
    }

    public String getZip() throws SQLException
    {
        return _strZip;
    }

    public void set(int language,String contact,String email,String organization,String address,String city,String state,String zip,String country,String telephone,String fax,String webpage,int weblanguage,boolean sex,Date birthday,String photo,String photoBig,String alias,java.util.Date matriculation,String folk,String classes,int graduate,String aim,String duty,String technical,String homePhone,String handset,String msn,String qq,String leaveWord,String place,
                    String languageClass,String rfield,String mrr,String mrrs,String oci) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeQuery("SELECT node  FROM Expert WHERE node=" + _nNode + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate("UPDATE Expert SET contact=" + DbAdapter.cite(contact) + ",email=" + DbAdapter.cite(email) + ",organization=" + DbAdapter.cite(organization) + ",address=" + DbAdapter.cite(address) + ",city=" + DbAdapter.cite(city) + ",state=" + DbAdapter.cite(state) + ",zip=" + DbAdapter.cite(zip) + ",country=" + DbAdapter.cite(country) + ",telephone=" + DbAdapter.cite(telephone) + ",fax=" + DbAdapter.cite(fax) + ",webpage=" + DbAdapter.cite(webpage) + ",weblanguage="
                                 + weblanguage + ",sex=" + (sex ? "1" : "0") + ",birthday=" + DbAdapter.cite(birthday) + " ,photo=" + DbAdapter.cite(photo) + " ,photobig =" + DbAdapter.cite(photoBig) + "  ,alias  =" + DbAdapter.cite(alias) + ",matriculation=" + DbAdapter.cite(matriculation) + ",folk  =" + DbAdapter.cite(folk) + " ,classes  =" + DbAdapter.cite(classes) + " ,graduate =" + graduate + " ,aim =" + DbAdapter.cite(aim) + " ,duty  =" + DbAdapter.cite(duty) + " ,technical=" + DbAdapter.cite(technical)
                                 + " ,homephone=" + DbAdapter.cite(homePhone) + " ,handset  =" + DbAdapter.cite(handset) + ",msn=" + DbAdapter.cite(msn) + "  ,qq   =" + DbAdapter.cite(qq) + " ,leaveword  =" + DbAdapter.cite(leaveWord) + "  ,place=" + DbAdapter.cite(place) + " , languageclass=" + DbAdapter.cite(languageClass) + " ,rfield=" + DbAdapter.cite(rfield)+ " ,mrr=" + DbAdapter.cite(mrr)+ " ,mrrs=" + DbAdapter.cite(mrrs)+ " ,oci=" + DbAdapter.cite(oci)+ "  WHERE node=" + _nNode + "  AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO Expert (node, language, contact, email, organization, address, city, state, zip, country, telephone, fax, webpage, weblanguage,sex,birthday,photo,photobig,alias   ,matriculation,folk  ,classes  ,graduate,aim,duty    ,technical    ,homephone    ,handset ,msn,qq ,leaveword    ,place,languageclass,rfield,mrr,mrrs,oci)VALUES (" + _nNode + ", " + language + ", " + DbAdapter.cite(contact) + ", " + DbAdapter.cite(email) + ", " + DbAdapter.cite(organization) + ", "
                                 + DbAdapter.cite(address) + "," + DbAdapter.cite(city) + ", " + DbAdapter.cite(state) + ", " + DbAdapter.cite(zip) + ", " + DbAdapter.cite(country) + ", " + DbAdapter.cite(telephone) + ", " + DbAdapter.cite(fax) + ", " + DbAdapter.cite(webpage) + "," + weblanguage + "," + (sex ? "1" : "0") + "," + DbAdapter.cite(birthday) + "," + DbAdapter.cite(photo) + "," + DbAdapter.cite(photoBig) + "," + DbAdapter.cite(alias) + "   ," + DbAdapter.cite(matriculation) + "," + DbAdapter.cite(folk)
                                 + "   ," + DbAdapter.cite(classes) + " ," + graduate + "," + DbAdapter.cite(aim) + " ," + DbAdapter.cite(duty) + "," + DbAdapter.cite(technical) + "    ," + DbAdapter.cite(homePhone) + " ," + DbAdapter.cite(handset) + "," + DbAdapter.cite(msn) + "," + DbAdapter.cite(qq) + " ," + DbAdapter.cite(leaveWord) + "," + DbAdapter.cite(place) + "," + DbAdapter.cite(languageClass)+ "," + DbAdapter.cite(rfield)+ "," + DbAdapter.cite(mrr)+ "," + DbAdapter.cite(mrrs)+ "," + DbAdapter.cite(oci) + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(_nNode + ":" + language);
    }

    public String getState() throws SQLException
    {
        return _strState;
    }

    private Expert(int node,int language) throws SQLException
    {
        _nNode = node;
        this.language = language;
        load();
    }

    public boolean isLayerExisted() throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node  FROM Expert  WHERE node=" + _nNode + " AND language=" + language);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public String getTelephone() throws SQLException
    {
        return _strTelephone;
    }

    public String getFax() throws SQLException
    {
        return _strFax;
    }

    public String getWebPage() throws SQLException
    {
        return _strWebPage;
    }

    public int getWebLanguage() throws SQLException
    {
        return _nWebLanguage;
    }

    private void load() throws SQLException
    {
        int j = this.getLanguage(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT contact, email, organization, address, city, state, zip, country, telephone, fax, webpage, weblanguage,sex,birthday,photo ,          photobig     ,          alias        ,          matriculation,          folk         ,         classes,          graduate     ,          aim          ,          duty         ,          technical    ,          homephone    ,          handset      ,          msn          ,          qq           ,          leaveword  ,place, languageclass,rfield,mrr,mrrs,oci  FROM Expert WHERE node="
                                  + _nNode + " AND language=" + j);
            if(db.next())
            {
                _strContact = db.getVarchar(j,language,1);
                _strEmail = db.getString(2);
                _strOrganization = db.getVarchar(j,language,3);
                _strAddress = db.getVarchar(j,language,4);
                _strCity = db.getVarchar(j,language,5);
                _strState = db.getVarchar(j,language,6);
                _strZip = db.getString(7);
                _strCountry = db.getVarchar(j,language,8);
                _strTelephone = db.getString(9);
                _strFax = db.getString(10);
                _strWebPage = db.getString(11);
                _nWebLanguage = db.getInt(12);
                sex = db.getInt(13) != 0;
                birthday = db.getDate(14);
                photo = db.getString(15);
                photoBig = db.getString(16);
                alias = db.getVarchar(j,language,17);
                matriculation = db.getDate(18);
                folk = db.getVarchar(j,language,19);
                classes = db.getVarchar(j,language,20);
                graduate = db.getInt(21);
                aim = db.getVarchar(j,language,22);
                duty = db.getVarchar(j,language,23);
                technical = db.getVarchar(j,language,24);
                homePhone = db.getString(25);
                handset = db.getString(26);
                MSN = db.getString(27);
                QQ = db.getString(28);
                leaveWord = db.getVarchar(j,language,29);
                place = db.getVarchar(j,language,30);
                languageClass = db.getVarchar(j,language,31);
                rfield=db.getVarchar(j, language, 32);
                mrr=db.getVarchar(j, language, 33);
                mrrs=db.getVarchar(j, language, 34);
                oci=db.getVarchar(j, language, 35);
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
            db.executeQuery("SELECT language FROM Expert WHERE node=" + _nNode);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Expert  WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(_nNode + ":" + language);
    }

    public static Expert find(int node,int language) throws SQLException
    {
        Expert obj = (Expert) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Expert(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public String getCity() throws SQLException
    {
        return _strCity;
    }

    public String getCountry() throws SQLException
    {
        return _strCountry;
    }

    public String getEmail() throws SQLException
    {
        return _strEmail;
    }

    public String getContact() throws SQLException
    {
        return _strContact;
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        int language = h.language;
        StringBuilder text = new StringBuilder();
        Span span = null;

        Expert classified = Expert.find(node._nNode,language);
        ListingDetail detail = ListingDetail.find(listing,28,language);
        java.util.Iterator enumer = detail.keys();
        while(enumer.hasNext())
        {
            String name = (String) enumer.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("Name"))
            {
                value = (node.getSubject(language));
            } else if(name.equals("Intro"))
            {
                if((node.getOptions() & 0x40L) == 0) // TEXT
                {
                    value = (Text.toHTML(node.getText2(language)));
                } else
                // HTML
                {
                    value = (node.getText2(language));
                }
            } else if(name.equals("photo"))
            {
                if(classified.getPhoto() != null && classified.getPhoto().length() > 0)
                {
                    value = (new tea.html.Image(classified.getPhoto()).toString()); // new tea.html.Image("/servlet/NodePicture").toString());
                } else
                {
                    value = ("");
                }
            } else if(name.equals("birthday"))
            {
                value = (classified.getBirthday("yyyy-MM-dd"));
            } else if(name.equals("sex"))
            {
                value = (classified.isSex() ? "男" : "女");
            } else if(name.equals("Contact"))
            {
                value = (classified.getContact());
            } else if(name.equals("EmailAddress"))
            {
                value = (classified.getEmail());
            } else if(name.equals("Organization"))
            {
                value = (classified.getOrganization());
            } else if(name.equals("Address"))
            {
                value = (classified.getAddress());
            } else if(name.equals("City"))
            {
                value = (classified.getCity());
            } else if(name.equals("State"))
            {
                value = (classified.getState());
            } else if(name.equals("Zip"))
            {
                value = (classified.getZip());
            } else if(name.equals("Country"))
            {
                value = (classified.getCountry());
            } else if(name.equals("Telephone"))
            {
                value = (classified.getTelephone());
            } else if(name.equals("Fax"))
            {
                value = (classified.getFax());
            } else if(name.equals("WebPage"))
            {
                value = (classified.getWebPage());
            } else if(name.equals("WebLanguage"))
            {
                value = String.valueOf(classified.getWebLanguage());
            } else if(name.equals("photobig"))
            {
                if(classified.getPhotoBig() != null && classified.getPhotoBig().length() > 0)
                {
                    value = (new tea.html.Image(classified.getPhotoBig()).toString());
                } else
                {
                    value = ("");
                }
            } else if(name.equals("alias"))
            {
                value = (classified.getAlias());
            } else if(name.equals("matriculation"))
            {
                value = (classified.getMatriculation("yyyy-MM-dd"));
            } else if(name.equals("folk"))
            {
                value = (classified.getFolk());
            } else if(name.equals("classes"))
            {
                value = (classified.getClasses());
            } else if(name.equals("graduate"))
            {
                value = String.valueOf(classified.getGraduate());
            } else if(name.equals("aim"))
            {
                value = (classified.getAim());
            } else if(name.equals("duty"))
            {
                value = (classified.getDuty());
            } else if(name.equals("technical"))
            {
                value = (classified.getTechnical());
            } else if(name.equals("homephone"))
            {
                value = (classified.getHomePhone());
            } else if(name.equals("handset"))
            {
                value = (classified.getHandset());
            } else if(name.equals("msn"))
            {
                value = (classified.getMSN());
            } else if(name.equals("qq"))
            {
                value = (classified.getQQ());
            } else if(name.equals("leaveword"))
            {
                value = (classified.getLeaveWord());
            } else if(name.equals("place"))
            {
                value = (classified.getPlace());
            } else if(name.equals("languageclass"))
            {
                value = (classified.getLanguageClass());
            } else if(name.equals("rfield"))
            {
                value = (classified.getRfield());
            } else if(name.equals("mrr"))
            {
                value = (classified.getMrr());
            } else if(name.equals("mrrs"))
            {
                value = (classified.getMrrs());
            } else if(name.equals("oci"))
            {
                value = (classified.getOci());
            }
            value = detail.getOptionsToHtml(name,node,value);
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/expert/" + node._nNode + "-" + language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("ExpertID" + name);
            text.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
        }
        return text.toString();
    }

    public int getLanguage()
    {
        return language;
    }

    public void setSex(boolean sex)
    {
        this.sex = sex;
    }

    public void setBirthday(Date birthday)
    {
        this.birthday = birthday;
    }

    public void setPhoto(String photo)
    {
        this.photo = photo;
    }

    public boolean isSex()
    {
        return sex;
    }

    public Date getBirthday()
    {
        return birthday;
    }

    public String getBirthday(String pattern)
    {
        if(birthday != null)
        {
            return(new java.text.SimpleDateFormat(pattern).format(birthday));
        } else
        {
            return("");
        }
    }

    public String getPhoto()
    {
        return photo;
    }

    public String getPhotoBig()
    {
        return photoBig;
    }

    public String getAlias()
    {
        return alias;
    }

    public java.util.Date getMatriculation()
    {
        return matriculation;
    }

    public String getMatriculation(String pattern)
    {
        if(matriculation == null)
        {
            return "";
        } else
        {
            return new java.text.SimpleDateFormat(pattern).format(matriculation);
        }
    }

    public String getFolk()
    {
        return folk;
    }

    public String getClasses()
    {
        return classes;
    }

    public int getGraduate()
    {
        return graduate;
    }

    public String getAim()
    {
        return aim;
    }

    public String getDuty()
    {
        return duty;
    }

    public String getTechnical()
    {
        return technical;
    }

    public String getHomePhone()
    {
        return homePhone;
    }

    public String getHandset()
    {
        return handset;
    }

    public String getLeaveWord()
    {
        return leaveWord;
    }

    public String getPlace()
    {
        return place;
    }

    public String getLanguageClass()
    {
        return languageClass;
    }

    public String getQQ()
    {
        return QQ;
    }

    public String getMSN()
    {
        return MSN;
    }
    public String getRfield() {
 		return rfield;
 	}

 	public void setRfield(String rfield) {
 		this.rfield = rfield;
 	}

 	public String getMrr() {
 		return mrr;
 	}

 	public void setMrr(String mrr) {
 		this.mrr = mrr;
 	}

 	public String getMrrs() {
 		return mrrs;
 	}

 	public void setMrrs(String mrrs) {
 		this.mrrs = mrrs;
 	}

 	public String getOci() {
 		return oci;
 	}

 	public void setOci(String oci) {
 		this.oci = oci;
 	}

}
