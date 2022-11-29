package tea.entity.node;

import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;

public class LFinancing
{
    private static Cache _cache = new Cache(100);
    private String name;
    private String essence;
    private String reside;
    private String area;
    private String synopsis;
    private String future;
    private String allmoney;
    private String financingmoney;
    private String investcallback;
    private String redound;
    private String yearrestrict;
    private String fashion;
    private String unitname;
    private String unitessence;
    private String unitsynopsis;
    private String linkman;
    private String phone;
    private String fax;
    private String email;
    private String postalcode;
    private String address;
    private Date issuedate;
    private int node;
    private int language;
    private boolean exists;
    private String website;
    private String homeplace;
    private String idcard;
    private String evolve;
    private String id;
    private String mobile;

    public LFinancing()
    {

    }

    public static LFinancing find(int node,int language) throws SQLException
    {
        LFinancing obj = (LFinancing) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new LFinancing(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public LFinancing(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    public void set() throws SQLException
    {
        if(this.isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                /*
                 * db.executeUpdate("LFinancingEdit " + node + "," + DbAdapter.cite(id) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(essence) + "," + DbAdapter.cite(reside) + "," + DbAdapter.cite(area) + "," + DbAdapter.cite(synopsis) + "," + DbAdapter.cite(future) + "," + DbAdapter.cite(allmoney) + "," + DbAdapter.cite(financingmoney) + "," + DbAdapter.cite(investcallback) + "," + DbAdapter.cite(redound) + "," + DbAdapter.cite(yearrestrict) + "," + DbAdapter.cite(fashion) + "," +
                 * DbAdapter.cite(unitname) + "," + DbAdapter.cite(unitessence) + "," + DbAdapter.cite(unitsynopsis) + "," + DbAdapter.cite(linkman) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(postalcode) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(issuedate) + "," + language + "," + DbAdapter.cite(evolve) + "," + DbAdapter.cite(idcard) + "," + DbAdapter.cite(homeplace) + "," +
                 * DbAdapter.cite(website));
                 */
                db.executeUpdate("UPDATE LFinancing  SET  id		=" + DbAdapter.cite(id) + ",name		=" + DbAdapter.cite(name) + ",essence		=" + DbAdapter.cite(essence) + ",reside		=" + DbAdapter.cite(reside) + ",area		=" + DbAdapter.cite(area) + ",synopsis		=" + DbAdapter.cite(synopsis) + ",future		=" + DbAdapter.cite(future) + ",allmoney		=" + DbAdapter.cite(allmoney) + ",financingmoney		 =" + DbAdapter.cite(financingmoney) + " ,investcallback		 =" + DbAdapter.cite(investcallback)
                                 + " ,redound 		=" + DbAdapter.cite(redound) + " ,yearrestrict		=" + DbAdapter.cite(yearrestrict) + ",fashion		=" + DbAdapter.cite(fashion) + ",unitname		=" + DbAdapter.cite(unitname) + ",unitessence		=" + DbAdapter.cite(unitessence) + ",unitsynopsis		=" + DbAdapter.cite(unitsynopsis) + ",linkman		=" + DbAdapter.cite(linkman) + ",phone		=" + DbAdapter.cite(phone) + ",fax		=" + DbAdapter.cite(fax) + ",email		=" + DbAdapter.cite(email) + ",postalcode		="
                                 + DbAdapter.cite(postalcode) + ",address		=" + DbAdapter.cite(address) + ",issuedate=" + DbAdapter.cite(issuedate) + ",evolve		  =" + DbAdapter.cite(evolve) + "			,idcard		  =" + DbAdapter.cite(idcard) + "		,homeplace	  =" + DbAdapter.cite(homeplace) + "	,website		  =" + DbAdapter.cite(website) + "	,mobile=" + DbAdapter.cite(mobile) + " WHERE node=" + node + " AND language=" + language);
                _cache.remove(node + ":" + language);
            } finally
            {
                db.close();
            }
        } else
        {
            create();
        }
    }

    public void create() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * //编号从RZ0500300开始,并且,其中不能出现4这个数字 int id = db.getInt("SELECT MAX(id) FROM Investor"); if (id < 500300) id = 500300 - 1; char ch[] = String.valueOf(++id).toCharArray(); for (int len = 0; len < ch.length; len++) { if ( (int) ch[len] == 4) { ++ch[len]; break; } }
             */
            /*
             * db.executeUpdate("LFinancingCreate " +
             *
             * DbAdapter.cite(id) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(essence) + "," + DbAdapter.cite(reside) + "," + DbAdapter.cite(area) + "," + DbAdapter.cite(synopsis) + "," + DbAdapter.cite(future) + "," + DbAdapter.cite(allmoney) + "," + DbAdapter.cite(financingmoney) + "," + DbAdapter.cite(investcallback) + "," + DbAdapter.cite(redound) + "," + DbAdapter.cite(yearrestrict) + "," + DbAdapter.cite(fashion) + "," + DbAdapter.cite(unitname) + "," + DbAdapter.cite(unitessence) +
             * "," + DbAdapter.cite(unitsynopsis) + "," + DbAdapter.cite(linkman) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(postalcode) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(issuedate) + "," + language + "," + DbAdapter.cite(evolve) + "," + DbAdapter.cite(idcard) + "," + DbAdapter.cite(homeplace) + "," + DbAdapter.cite(website));
             */
            db.executeUpdate("INSERT INTO LFinancing(node ,id,name ,essence,reside ,area,synopsis,future ,allmoney,financingmoney ,investcallback ,redound,yearrestrict,fashion,unitname,unitessence,unitsynopsis,linkman,phone ,fax ,email ,postalcode ,address ,issuedate ,language,evolve,idcard,homeplace,website,mobile)VALUES(" + node + " ," + DbAdapter.cite(id) + "," + DbAdapter.cite(name) + " ," + DbAdapter.cite(essence) + "," + DbAdapter.cite(reside) + " ," + DbAdapter.cite(area) + ","
                             + DbAdapter.cite(synopsis) + "," + DbAdapter.cite(future) + " ," + DbAdapter.cite(allmoney) + "," + DbAdapter.cite(financingmoney) + " ," + DbAdapter.cite(investcallback) + " ," + DbAdapter.cite(redound) + "," + DbAdapter.cite(yearrestrict) + "," + DbAdapter.cite(fashion) + "," + DbAdapter.cite(unitname) + "," + DbAdapter.cite(unitessence) + "," + DbAdapter.cite(unitsynopsis) + "," + DbAdapter.cite(linkman) + "," + DbAdapter.cite(phone) + " ," + DbAdapter.cite(fax) + " ,"
                             + DbAdapter.cite(email) + " ," + DbAdapter.cite(postalcode) + " ," + DbAdapter.cite(address) + " ," + DbAdapter.cite(issuedate) + " ," + language + " ," + DbAdapter.cite(evolve) + "," + DbAdapter.cite(idcard) + "," + DbAdapter.cite(homeplace) + "," + DbAdapter.cite(website) + "," + DbAdapter.cite(mobile) + ")");
            this.exists = true;
            _cache.remove(node + ":" + language);
        } finally
        {
            db.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // int j = db.getInt("LFinancingGetLanguage " + node + ", " + language);
            int j = this.getLanguage(language);
            db.executeQuery("SELECT    name ,    essence,    reside ,    area,    synopsis,    future ,    allmoney,    financingmoney ,    investcallback ,    redound,    yearrestrict,    fashion,    unitname,   unitessence,    unitsynopsis,    linkman,    phone ,    fax ,    email ,    postalcode ,    address ,    issuedate ,evolve		,idcard		,homeplace	,website	,id,mobile	FROM LFinancing WHERE node= " + node + " AND language=" + j);
            if(db.next())
            {
                name = db.getVarchar(j,language,1);
                essence = db.getVarchar(j,language,2);
                // 已有语言,要显示出的语言,列的索引
                reside = db.getVarchar(j,language,3);
                area = db.getVarchar(j,language,4);
                synopsis = db.getVarchar(j,language,5);
                future = db.getVarchar(j,language,6);
                allmoney = db.getVarchar(j,language,7);
                financingmoney = db.getVarchar(j,language,8);
                investcallback = db.getVarchar(j,language,9);
                redound = db.getVarchar(j,language,10);
                yearrestrict = db.getVarchar(j,language,11);
                fashion = db.getVarchar(j,language,12);
                unitname = db.getVarchar(j,language,13);
                unitessence = db.getVarchar(j,language,14);
                unitsynopsis = db.getVarchar(j,language,15);
                linkman = db.getVarchar(j,language,16);
                phone = db.getVarchar(j,language,17);
                fax = db.getVarchar(j,language,18);
                email = db.getVarchar(j,language,19);
                postalcode = db.getVarchar(j,language,20);
                address = db.getVarchar(j,language,21);
                issuedate = db.getDate(22);
                evolve = db.getVarchar(j,language,23);
                idcard = db.getVarchar(j,language,24);
                homeplace = db.getVarchar(j,language,25);
                website = db.getVarchar(j,language,26);
                id = db.getString(27);
                mobile = db.getString(28);
                exists = true;
            } else
            {
                exists = false;
                name = id = essence = reside = area = synopsis = future = allmoney = financingmoney = investcallback = redound = yearrestrict = fashion = unitname = unitessence = unitsynopsis = linkman = phone = fax = email = postalcode = evolve = idcard = homeplace = website = address = "";
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
            db.executeQuery("SELECT language FROM LFinancing WHERE node=" + node);
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

    public void setName(String name) throws SQLException
    {
        this.name = name;
    }

    public void setEssence(String essence) throws SQLException
    {
        this.essence = essence;
    }

    public void setReside(String reside) throws SQLException
    {
        this.reside = reside;
    }

    public void setArea(String area) throws SQLException
    {
        this.area = area;
    }

    public void setSynopsis(String synopsis) throws SQLException
    {
        this.synopsis = synopsis;
    }

    public void setFuture(String future) throws SQLException
    {
        this.future = future;
    }

    public void setAllmoney(String allmoney) throws SQLException
    {
        this.allmoney = allmoney;
    }

    public void setFinancingmoney(String financingmoney) throws SQLException
    {
        this.financingmoney = financingmoney;
    }

    public void setInvestcallback(String investcallback) throws SQLException
    {
        this.investcallback = investcallback;
    }

    public void setRedound(String redound) throws SQLException
    {
        this.redound = redound;
    }

    public boolean isExists() throws SQLException
    {
        return exists;
    }

    public void setYearrestrict(String yearrestrict) throws SQLException
    {
        this.yearrestrict = yearrestrict;
    }

    public void setFashion(String fashion) throws SQLException
    {
        this.fashion = fashion;
    }

    public void setUnitname(String unitname) throws SQLException
    {
        this.unitname = unitname;
    }

    public void setUnitessence(String unitessence) throws SQLException
    {
        this.unitessence = unitessence;
    }

    public void setUnitsynopsis(String unitsynopsis) throws SQLException
    {
        this.unitsynopsis = unitsynopsis;
    }

    public void setLinkman(String linkman) throws SQLException
    {
        this.linkman = linkman;
    }

    public void setPhone(String phone) throws SQLException
    {
        this.phone = phone;
    }

    public void setFax(String fax) throws SQLException
    {
        this.fax = fax;
    }

    public void setEmail(String email) throws SQLException
    {
        this.email = email;
    }

    public void setPostalcode(String postalcode) throws SQLException
    {
        this.postalcode = postalcode;
    }

    public void setAddress(String address) throws SQLException
    {
        this.address = address;
    }

    public void setIssuedate(Date issuedate) throws SQLException
    {
        this.issuedate = issuedate;
    }

    public void setLanguage(int language) throws SQLException
    {
        this.language = language;
    }

    public void setWebsite(String website)
    {
        this.website = website;
    }

    public void setHomeplace(String homeplace)
    {
        this.homeplace = homeplace;
    }

    public void setIdcard(String idcard)
    {
        this.idcard = idcard;
    }

    public void setEvolve(String evolve)
    {
        this.evolve = evolve;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public void setMobile(String mobile)
    {
        this.mobile = mobile;
    }

    public String getName() throws SQLException
    {
        return name;
    }

    public String getEssence() throws SQLException
    {
        return essence;
    }

    public String getReside() throws SQLException
    {
        return reside;
    }

    public String getArea() throws SQLException
    {
        return area;
    }

    public String getSynopsis() throws SQLException
    {
        return synopsis;
    }

    public String getFuture() throws SQLException
    {
        return future;
    }

    public String getAllmoney() throws SQLException
    {
        return allmoney;
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();

        LFinancing obj = LFinancing.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,53,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("code"))
            {
                value = (obj.getId());
            } else if(name.equals("name"))
            {
                value = (obj.getName());
            } else if(name.equals("essence"))
            {
                value = (obj.getEssence());
            } else if(name.equals("reside"))
            {
                value = (obj.getReside());
            } else if(name.equals("area"))
            {
                value = (obj.getArea());
            } else if(name.equals("synopsis"))
            {
                value = (obj.getSynopsis());
            } else if(name.equals("future"))
            {
                value = (obj.getFuture());
            } else if(name.equals("allmoney"))
            {
                value = (obj.getAllmoney());
            } else if(name.equals("objmoney"))
            {
                value = (obj.getFinancingmoney());
            } else if(name.equals("investcallback"))
            {
                value = (obj.getInvestcallback());
            } else if(name.equals("redound"))
            {
                value = (obj.getRedound());
            } else if(name.equals("yearrestrict"))
            {
                value = (obj.getYearrestrict());
            } else if(name.equals("fashion"))
            {
                value = (obj.getFashion());
            } else if(name.equals("unitname"))
            {
                value = (obj.getUnitname());
            } else if(name.equals("unitessence"))
            {
                value = (obj.getUnitessence());
            } else if(name.equals("unitsynopsis"))
            {
                value = (obj.getUnitsynopsis());
            } else if(name.equals("linkman"))
            {
                value = (obj.getLinkman());
            } else if(name.equals("phone"))
            {
                value = (obj.getPhone());
            } else if(name.equals("mobile"))
            {
                value = (obj.getMobile() == null ? "" : obj.getMobile());
            } else if(name.equals("fax"))
            {
                value = (obj.getFax());
            } else if(name.equals("email"))
            {
                value = (obj.getEmail());
            } else if(name.equals("postalcode"))
            {
                value = (obj.getPostalcode());
            } else if(name.equals("address"))
            {
                value = (obj.getAddress());
            } else if(name.equals("issuetime"))
            {
                value = (node.getTimeToString());
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/lfinancing/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("LFinancingID" + name);
            sb.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
        }
        return sb.toString();
    }

    public String getFinancingmoney() throws SQLException
    {
        return financingmoney;
    }

    public String getInvestcallback() throws SQLException
    {
        return investcallback;
    }

    public String getRedound() throws SQLException
    {
        return redound;
    }

    public String getYearrestrict() throws SQLException
    {
        return yearrestrict;
    }

    public String getFashion() throws SQLException
    {
        return fashion;
    }

    public String getUnitname() throws SQLException
    {
        return unitname;
    }

    public String getUnitessence() throws SQLException
    {
        return unitessence;
    }

    public String getUnitsynopsis() throws SQLException
    {
        return unitsynopsis;
    }

    public String getLinkman() throws SQLException
    {
        return linkman;
    }

    public String getPhone() throws SQLException
    {
        return phone;
    }

    public String getFax() throws SQLException
    {
        return fax;
    }

    public String getEmail() throws SQLException
    {
        return email;
    }

    public String getPostalcode() throws SQLException
    {
        return postalcode;
    }

    public String getAddress() throws SQLException
    {
        return address;
    }

    public Date getIssuedate() throws SQLException
    {
        return issuedate;
    }

    public int getNode() throws SQLException
    {
        return node;
    }

    public int getLanguage() throws SQLException
    {
        return language;
    }

    public String getWebsite()
    {
        return website;
    }

    public String getHomeplace()
    {
        return homeplace;
    }

    public String getIdcard()
    {
        return idcard;
    }

    public String getEvolve()
    {
        return evolve;
    }

    public String getId()
    {
        return id;
    }

    public String getMobile()
    {
        return mobile;
    }

}
