package tea.entity.node;

import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;

public class LInvestor
{
    private int node;
    private int language;
    private String fundname;
    private String fundinfo;
    private String fundsum;
    private Date fundsumload;
    private String fundarea;
    private String fundtrade;
    private String fundsymbiosis;
    private String fundwill;
    private String fundwebsite;
    private int fundperiod;
    private String fundlocal;
    private String fundidcard;
    private String fundlinkman;
    private String fundtel;
    private String fundfax;
    private String fundmail;
    private String fundpostcode;
    private String fundaddress;
    private boolean exists;
    public static final String SYMBIOSIS_TYPE[] =
            {"合资","合作","独资","入股","固定回报","风险回报","借款","面洽"};
    private String id;
    private static Cache _cache = new Cache(100);
    public static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM");
    private String mobile;

    public LInvestor()
    {
    }

    public LInvestor(int _nNode,int _nLanguage) throws SQLException
    {
        node = _nNode;
        language = _nLanguage;
        loadBasic();
    }

    public void create() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * //编号从TZ0500300开始,并且,其中不能出现4这个数字 int id = db.getInt("SELECT MAX(id) FROM LInvestor"); if (id < 500300) id = 500300 - 1; char ch[] = String.valueOf(++id).toCharArray(); for (int len = 0; len < ch.length; len++) { if ( (int) ch[len] == 4) { ++ch[len]; break; } }
             */
            /*
             * db.executeUpdate("LInvestorCreate " + node + "," + language + "," + // (Integer.parseInt(new String(ch))) + "," + DbAdapter.cite(id) + "," + DbAdapter.cite(fundname) + "," + DbAdapter.cite(fundinfo) + "," + DbAdapter.cite(fundsum) + "," + DbAdapter.cite(fundsumload) + "," + DbAdapter.cite(fundarea) + "," + DbAdapter.cite(fundtrade) + "," + DbAdapter.cite(fundsymbiosis) + "," + DbAdapter.cite(fundwill) + "," + DbAdapter.cite(fundwebsite) + "," + (fundperiod) + "," +
             * DbAdapter.cite(fundlocal) + "," + DbAdapter.cite(fundidcard) + "," + DbAdapter.cite(fundlinkman) + "," + DbAdapter.cite(fundtel) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(fundfax) + "," + DbAdapter.cite(fundmail) + "," + DbAdapter.cite(fundpostcode) + "," + DbAdapter.cite(fundaddress));
             */
            db.executeUpdate("INSERT INTO LInvestor(node,language,id,fundname	,fundinfo	,fundsum		,fundsumload	,fundarea	,fundtrade	,fundsymbiosis	,fundwill	,fundwebsite	,fundperiod	,fundlocal	,fundidcard	,fundlinkman,fundtel,fundfax,fundmail,fundpostcode,fundaddress,mobile) VALUES(" + node + "," + language + "," + DbAdapter.cite(id) + "," + DbAdapter.cite(fundname) + "," + DbAdapter.cite(fundinfo) + "," + DbAdapter.cite(fundsum) + "," + DbAdapter.cite(fundsumload) + "," + DbAdapter.cite(fundarea)
                             + "," + DbAdapter.cite(fundtrade) + "," + DbAdapter.cite(fundsymbiosis) + "," + DbAdapter.cite(fundwill) + "," + DbAdapter.cite(fundwebsite) + "," + (fundperiod) + "," + DbAdapter.cite(fundlocal) + "," + DbAdapter.cite(fundidcard) + "," + DbAdapter.cite(fundlinkman) + "," + DbAdapter.cite(fundtel) + "," + DbAdapter.cite(fundfax) + "," + DbAdapter.cite(fundmail) + "," + DbAdapter.cite(fundpostcode) + "," + DbAdapter.cite(fundaddress) + "," + DbAdapter.cite(mobile) + ")");
            this.exists = true;
            _cache.remove(node + ":" + language);
        } finally
        {
            db.close();
        }
    }

    public void set() throws SQLException
    {

        if(this.isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                /*
                 * db.executeUpdate("LInvestorEdit " + node + "," + language + "," + DbAdapter.cite(id) + "," + DbAdapter.cite(fundname) + "," + DbAdapter.cite(fundinfo) + "," + DbAdapter.cite(fundsum) + "," + DbAdapter.cite(fundsumload) + "," + DbAdapter.cite(fundarea) + "," + DbAdapter.cite(fundtrade) + "," + DbAdapter.cite(fundsymbiosis) + "," + DbAdapter.cite(fundwill) + "," + DbAdapter.cite(fundwebsite) + "," + (fundperiod) + "," + DbAdapter.cite(fundlocal) + "," +
                 * DbAdapter.cite(fundidcard) + "," + DbAdapter.cite(fundlinkman) + "," + DbAdapter.cite(fundtel) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(fundfax) + "," + DbAdapter.cite(fundmail) + "," + DbAdapter.cite(fundpostcode) + "," + DbAdapter.cite(fundaddress));
                 */
                db.executeUpdate("UPDATE LInvestor  SET  id	=" + DbAdapter.cite(id) + "	,fundname	=" + DbAdapter.cite(fundname) + "	,fundinfo	=" + DbAdapter.cite(fundinfo) + "	,fundsum		=" + DbAdapter.cite(fundsum) + ",fundsumload=" + DbAdapter.cite(fundsumload) + ",fundarea=" + DbAdapter.cite(fundarea) + "	,fundtrade	=" + DbAdapter.cite(fundtrade) + "	,fundsymbiosis	=" + DbAdapter.cite(fundsymbiosis) + "	,fundwill	=" + DbAdapter.cite(fundwill) + "	,fundwebsite	=" + DbAdapter.cite(fundwebsite)
                                 + "	,fundperiod	=" + (fundperiod) + "	,fundlocal	=" + DbAdapter.cite(fundlocal) + "	,fundidcard	=" + DbAdapter.cite(fundidcard) + "	,fundlinkman	=" + DbAdapter.cite(fundlinkman) + "	,fundtel		=" + DbAdapter.cite(fundtel) + "	,mobile     	=" + DbAdapter.cite(mobile) + ",fundfax		=" + DbAdapter.cite(fundfax) + "	,fundmail	=" + DbAdapter.cite(fundmail) + "	,fundpostcode	=" + DbAdapter.cite(fundpostcode) + "	,fundaddress	=" + DbAdapter.cite(fundaddress) + " WHERE node="
                                 + node + " AND language=" + language);
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

    public boolean isExists() throws SQLException
    {
        // loadBasic();
        return exists;
    }

    private void loadBasic() throws SQLException
    {
        // if (!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                // int j = db.getInt("LInvestorGetLanguage " + node + ", " + language);
                int j = this.getLanguage(language);
                db.executeQuery("SELECT fundname,fundinfo,fundsum,fundsumload,fundarea,fundtrade,fundsymbiosis,fundwill,fundwebsite,fundperiod	,fundlocal	,fundidcard	,fundlinkman	,fundtel		,fundfax		,fundmail	,fundpostcode	,fundaddress	,id,mobile  FROM LInvestor  WHERE node=" + node + " AND language=" + j);
                if(db.next())
                {
                    fundname = db.getVarchar(j,language,1);
                    fundinfo = db.getVarchar(j,language,2);
                    fundsum = db.getVarchar(j,language,3);
                    fundsumload = db.getDate(4);
                    fundarea = db.getVarchar(j,language,5);
                    fundtrade = db.getVarchar(j,language,6);
                    fundsymbiosis = db.getVarchar(j,language,7);
                    fundwill = db.getVarchar(j,language,8);
                    fundwebsite = db.getVarchar(j,language,9);
                    fundperiod = db.getInt(10);
                    fundlocal = db.getVarchar(j,language,11);
                    fundidcard = db.getVarchar(j,language,12);
                    fundlinkman = db.getVarchar(j,language,13);
                    fundtel = db.getVarchar(j,language,14);
                    fundfax = db.getVarchar(j,language,15);
                    fundmail = db.getVarchar(j,language,16);
                    fundpostcode = db.getVarchar(j,language,17);
                    fundaddress = db.getVarchar(j,language,18);
                    id = db.getString(19);
                    mobile = db.getString(20);
                    exists = true;
                } else
                {
                    exists = false;
                    mobile = id = fundname = fundsymbiosis = fundinfo = fundsum =
                            // fundsumload =
                            fundarea = fundtrade = fundwill = fundwebsite = fundlocal = fundidcard = fundlinkman = fundtel = fundfax = fundmail = fundpostcode = fundaddress = "";

                }
            } finally
            {
                db.close();
            }
            // _blLoaded = true;
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM LInvestor WHERE node=" + node);
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

    public static LInvestor find(int _nNode,int _nLanguage) throws SQLException
    {
        LInvestor objInvestor = (LInvestor) _cache.get(_nNode + ":" + _nLanguage);
        if(objInvestor == null)
        {
            objInvestor = new LInvestor(_nNode,_nLanguage);
            _cache.put(_nNode + ":" + _nLanguage,objInvestor);
        }
        return objInvestor;
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        LInvestor investor = LInvestor.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,54,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("code"))
            {
                value = (investor.getId());
            } else if(itemname.equals("fundname"))
            {
                value = (investor.getFundname());
            } else if(itemname.equals("fundinfo"))
            {
                value = (investor.getFundinfo());
            } else if(itemname.equals("fundsum"))
            {
                value = (investor.getFundsum());
            } else if(itemname.equals("fundsumload"))
            {
                value = (investor.getFundsumloadToString());
            } else if(itemname.equals("fundarea"))
            {
                value = (investor.getFundarea());
            } else if(itemname.equals("fundtrade"))
            {
                value = (investor.getFundtrade());
            } else if(itemname.equals("fundsymbiosis"))
            {
                value = (investor.getFundsymbiosis());
            } else if(itemname.equals("fundwill"))
            {
                value = (investor.getFundwill());
            } else if(itemname.equals("fundwebsite"))
            {
                value = (investor.getFundwebsite());
            } else if(itemname.equals("fundperiod"))
            {
                value = String.valueOf(investor.getFundperiod());
            } else if(itemname.equals("fundlocal"))
            {
                value = (investor.getFundlocal());
            } else if(itemname.equals("fundidcard"))
            {
                value = (investor.getFundidcard());
            } else if(itemname.equals("fundlinkman"))
            {
                value = (investor.getFundlinkman());
            } else if(itemname.equals("fundtel"))
            {
                value = (investor.getFundtel());
            } else if(itemname.equals("mobile"))
            {
                value = (investor.getMobile());
            } else if(itemname.equals("fundfax"))
            {
                value = (investor.getFundfax());
            } else if(itemname.equals("fundmail"))
            {
                value = (investor.getFundmail());
            } else if(itemname.equals("fundpostcode"))
            {
                value = (investor.getFundpostcode());
            } else if(itemname.equals("fundaddress"))
            {
                value = (investor.getFundaddress());
            } else if(itemname.equals("issuetime"))
            {
                value = (node.getTimeToString());
            }

            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/linvestor/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("LInvestorID" + itemname);
            sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

    public void setNode(int node)
    {
        this.node = node;
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }

    public void setFundname(String fundname)
    {
        this.fundname = fundname;
    }

    public void setFundinfo(String fundinfo)
    {
        this.fundinfo = fundinfo;
    }

    public void setFundsum(String fundsum)
    {
        this.fundsum = fundsum;
    }

    public void setFundsumload(Date fundsumload)
    {
        this.fundsumload = fundsumload;
    }

    public void setFundarea(String fundarea)
    {
        this.fundarea = fundarea;
    }

    public void setFundtrade(String fundtrade)
    {
        this.fundtrade = fundtrade;
    }

    public void setFundsymbiosis(String fundsymbiosis)
    {
        this.fundsymbiosis = fundsymbiosis;
    }

    public void setFundwill(String fundwill)
    {
        this.fundwill = fundwill;
    }

    public void setFundwebsite(String fundwebsite)
    {
        this.fundwebsite = fundwebsite;
    }

    public void setFundperiod(int fundperiod)
    {
        this.fundperiod = fundperiod;
    }

    public void setFundlocal(String fundlocal)
    {
        this.fundlocal = fundlocal;
    }

    public void setFundidcard(String fundidcard)
    {
        this.fundidcard = fundidcard;
    }

    public void setFundlinkman(String fundlinkman)
    {
        this.fundlinkman = fundlinkman;
    }

    public void setFundtel(String fundtel)
    {
        this.fundtel = fundtel;
    }

    public void setFundfax(String fundfax)
    {
        this.fundfax = fundfax;
    }

    public void setFundmail(String fundmail)
    {
        this.fundmail = fundmail;
    }

    public void setFundpostcode(String fundpostcode)
    {
        this.fundpostcode = fundpostcode;
    }

    public void setFundaddress(String fundaddress)
    {
        this.fundaddress = fundaddress;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public void setMobile(String mobile)
    {
        this.mobile = mobile;
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getFundname()
    {
        return fundname;
    }

    public String getFundinfo()
    {
        return fundinfo;
    }

    public String getFundsum()
    {
        return fundsum;
    }

    public Date getFundsumload()
    {
        return fundsumload;
    }

    public String getFundsumloadToString()
    {
        if(fundsumload == null)
        {
            return "";
        }
        return(sdf.format(fundsumload));
    }

    public String getFundarea()
    {
        return fundarea;
    }

    public String getFundtrade()
    {
        return fundtrade;
    }

    public String getFundsymbiosis()
    {
        return fundsymbiosis;
    }

    public String getFundwill()
    {
        return fundwill;
    }

    public String getFundwebsite()
    {
        return fundwebsite;
    }

    public int getFundperiod()
    {
        return fundperiod;
    }

    public String getFundlocal()
    {
        return fundlocal;
    }

    public String getFundidcard()
    {
        return fundidcard;
    }

    public String getFundlinkman()
    {
        return fundlinkman;
    }

    public String getFundtel()
    {
        return fundtel;
    }

    public String getFundfax()
    {
        return fundfax;
    }

    public String getFundmail()
    {
        return fundmail;
    }

    public String getFundpostcode()
    {
        return fundpostcode;
    }

    public String getFundaddress()
    {
        return fundaddress;
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
