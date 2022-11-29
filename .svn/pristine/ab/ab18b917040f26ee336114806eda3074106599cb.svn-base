package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;
import tea.entity.util.*;
import tea.resource.Resource;
import tea.entity.admin.map.*;
import java.sql.SQLException;

public class Company extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final String PROPERTY_TYPE[] =
            {"----------------------------------------","外商独资．外企办事处","中外合营(合资．合作)","私营．民营企业","国有企业","国内上市公司","政府机关／非盈利机构","事业单位"};
    public static final String ENROL_TYPE[] =
            {"----------------------------------------","无","人民币 10 万元以下","人民币 10 万元 - 30 万元","人民币 30 万元 - 50 万元","人民币 50 万元 - 100 万元","人民币 100 万元 - 200 万元","人民币 200 万元 - 300 万元","人民币 300 万元 - 500 万元","人民币 500 万元 - 700 万元","人民币 700 万元 - 1000 万元","人民币 1000 万元 - 2000 万元","人民币 2000 万元 - 3000 万元","人民币 3000 万元 - 5000 万元","人民币 5000 万元 - 1 亿元","人民币 1 亿元以上"};
    public static final String DEVELOPER_TYPE[] =
            {"----------------------------------------","少于5 人","11 - 20 人","21 - 30 人","31 - 40 人","41 - 50 人","51 - 60 人","61 - 70 人","71 - 80 人","81 - 90 人","91 - 100 人","100 人以上"};
    public static final String SIZE_TYPE[] =
            {"----------------------------------------","1 - 49人","50 - 99人","100 - 499人","500 - 999人","1000人以上"};
    public static final String MODE_TYPE[] =
            {"生产型","贸易型","服务型","政府或其他机构"};
    public static final String GRADE_TYPE[] ={"无等级", "金牌", "银牌", "铜牌"};
    private Hashtable _htLayer;
    private int _nNode;
    private int sequence = 0;
    private String personelarea;
    private java.math.BigDecimal moneys;//缴费
    /*
     * 每个招聘机构都要增加此字段,而且是1对1的关系,不允许两家招聘机构有相同的应聘者范围,此值将作为招聘机构除现有主键之外的另一个主键,通过手工方式维护与sap相关机构的一致.
     */
    private String aptyp;
    private String qualification[] = new String[4]; //公司资质
    class Layer
    {
        Layer()
        {
        }

        String _strContact; //联系人
        String _strEmail;
        String _strOrganization;
        String _strAddress;
        int category;
        int _nCity;
        String _strState;
        String _strZip;
        String _strCountry;
        String _strTelephone;
        String _strFax;
        String _strWebPage;
        String _strMap;
        String _strEyp;
        boolean _bSex = true;
        String _strLicense;
        int _nProperty; //公司性质
        int scale; //公司规模
        int _strCalling; //所属行业
        String modes;
        int enrol; //注册资金
        String product; //主营产品或服务
        String enroladd; //公司注册地
        String fareadd; //主要经营地点
        String birth; //出生日期
        String brand; //品牌
        String principal; //法人代表/负责人
        int turnover; //年营业额
        String agora;
        String client; //客户
        int export; //年出口额
        int imports; //年进口额
        String attestation;
        String bank; //开户银行
        String accounts; //开户帐号
        boolean oem; //是否提供OEM代加工
        int developer; //研发部门人数
        String turnout;
        String acreage;
        String mass;
        String branch; //部门
        String job; //职位
        String logo;
        String picture;
        String banner; //横幅图
        int superior; //上级公司
        //企业文化///
        String culturetitle; //标题
        String culturepicture; //图片
        String culturecontent; //内容
        //广告///
        String adpic[] = new String[4];
        String adlink[] = new String[4];
        int grade; //等级
        int compositor; //排序
        int credit; //信誉额度
    }



    public String getOrganization(int i) throws SQLException
    {
        return getLayer(i)._strOrganization;
    }

    public boolean getSex(int i) throws SQLException
    {
        return getLayer(i)._bSex;
    }

    public String getLicense(int i) throws SQLException
    {
        return getLayer(i)._strLicense;
    }

    public int getProperty(int i) throws SQLException
    {
        return getLayer(i)._nProperty;
    }

    public int getScale(int i) throws SQLException
    {
        return getLayer(i).scale;
    }

    public int getCalling(int i) throws SQLException
    {
        return getLayer(i)._strCalling;
    }

    public String getCallingToString(int i) throws SQLException
    {
        return tea.htmlx.TradeSelection.getTrade(getLayer(i)._strCalling);
    }

    public void setSex(boolean sex,int language) throws SQLException
    {
        set_(language,"sex",(sex ? "1" : "0"));
    }

    private void set_(int language,String field,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET " + field + "=" + DbAdapter.cite(value) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setLicense(String license,int language) throws SQLException
    {
        set_(language,"license",license);
    }

    public void setProperty(int property,int language) throws SQLException
    {
        set_(language,"property",String.valueOf(property));
    }

    public void setScale(int scale,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET scale=" + scale + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setCalling(int calling,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET calling=" + calling + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public String getAddress(int i) throws SQLException
    {
        return getLayer(i)._strAddress;
    }

    public String getZip(int i) throws SQLException
    {
        return getLayer(i)._strZip;
    }

    public void set(int language,String contact,String email,String organization,String address,int city,String state,String zip,String country,String telephone,String fax,String webpage,String map,String eyp) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int c = db.executeUpdate("UPDATE Company SET contact=" + DbAdapter.cite(contact) + ",email=" + DbAdapter.cite(email) + ",organization=" + DbAdapter.cite(organization) + ",address=" + DbAdapter.cite(address) + ",city=" + city + ",state=" + DbAdapter.cite(state) + ",zip=" + DbAdapter.cite(zip) + ",country=" + DbAdapter.cite(country) + ",telephone=" + DbAdapter.cite(telephone) + ",fax=" + DbAdapter.cite(fax) + ", webpage=" + DbAdapter.cite(webpage) + ",map=" + DbAdapter.cite(map) + ",eyp=" + DbAdapter.cite(eyp) + " WHERE node=" + _nNode + " AND language=" + language);
            if(c < 1)
            {
                db.executeUpdate("INSERT INTO Company(node, language, contact, email, organization, address, city, state, zip, country, telephone, fax, webpage,map,eyp) VALUES (" + _nNode + ", " + language + ", " + DbAdapter.cite(contact) + ", " + DbAdapter.cite(email) + ", " + DbAdapter.cite(organization) + ", " + DbAdapter.cite(address) + ", " + city + ", " + DbAdapter.cite(state) + ", " + DbAdapter.cite(zip) + ", " + DbAdapter.cite(country) + ", " + DbAdapter.cite(telephone) + ", " + DbAdapter.cite(fax) + ", " + DbAdapter.cite(webpage) + ", " + DbAdapter.cite(map) + ", " + DbAdapter.cite(eyp) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void set(int category,int city,int enrol,int scale,int property,int language,String product,String principal,String birth,String brand) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET category=" + category + ",city=" + city + ",enrol=" + enrol + ",scale=" + scale + ",property=" + property + ",product=" + DbAdapter.cite(product) + ",principal=" + DbAdapter.cite(principal) + ",birth=" + DbAdapter.cite(birth) + ",brand=" + DbAdapter.cite(brand) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public String getState(int i) throws SQLException
    {
        return getLayer(i)._strState;
    }

    public void setState(int i,boolean state) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET state" + i + "=" + db.cite(state) + " WHERE node=" + _nNode + " AND language=" + 1);
        } finally
        {
            db.close();
        }
    }

    private Company(int i)
    {
        _nNode = i;
        _htLayer = new Hashtable();
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Company WHERE node=" + _nNode + " AND language=" + i);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public String getTelephone(int i) throws SQLException
    {
        return getLayer(i)._strTelephone;
    }

    public String getFax(int i) throws SQLException
    {
        return getLayer(i)._strFax;
    }

    public String getWebPage(int i) throws SQLException
    {
        return getLayer(i)._strWebPage;
    }

    private Layer getLayer(int lang) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(lang));
        if(layer == null)
        {
            layer = new Layer();
            int j = Node.getLanguage(_nNode,lang);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT contact,email,organization,address,category,city,state,zip,country,telephone, fax, " +
                		"webpage, map ,sex ,license,property,scale,calling,modes,enrol,product,enroladd,fareadd,birth,brand," +
                		"principal,turnover,agora,client,export,imports,attestation,bank,accounts,oem,developer,turnout,acreage," +
                		"mass,branch,job,logo,picture,superior,personelarea,aptyp,eyp,banner,qualification0,qualification1," +
                		"qualification2,qualification3,culturetitle,culturepicture,culturecontent,adpic0,adpic1,adpic2,adpic3," +
                		"adlink0,adlink1,adlink2,adlink3,moneys,grade,compositor,credit FROM Company  WHERE node=" + _nNode + " AND language=" + j);
                if(db.next())
                {
                    layer._strContact = db.getVarchar(j,lang,1);
                    layer._strEmail = db.getString(2);
                    layer._strOrganization = db.getVarchar(j,lang,3);
                    layer._strAddress = db.getVarchar(j,lang,4);
                    layer.category = db.getInt(5);
                    layer._nCity = db.getInt(6);
                    layer._strState = db.getVarchar(j,lang,7);
                    layer._strZip = db.getString(8);
                    layer._strCountry = db.getVarchar(j,lang,9);
                    layer._strTelephone = db.getString(10);
                    layer._strFax = db.getString(11);
                    layer._strWebPage = db.getString(12);
                    layer._strMap = db.getString(13);
                    layer._bSex = db.getInt(14) != 0;
                    layer._strLicense = db.getString(15);
                    layer._nProperty = db.getInt(16);
                    layer.scale = db.getInt(17);
                    layer._strCalling = db.getInt(18);
                    layer.modes = db.getVarchar(j,lang,19);
                    layer.enrol = db.getInt(20);
                    layer.product = db.getVarchar(j,lang,21);
                    layer.enroladd = db.getVarchar(j,lang,22);
                    layer.fareadd = db.getVarchar(j,lang,23);
                    layer.birth = db.getVarchar(j,lang,24);
                    layer.brand = db.getVarchar(j,lang,25);
                    layer.principal = db.getVarchar(j,lang,26);
                    layer.turnover = db.getInt(27);
                    layer.agora = db.getVarchar(j,lang,28);
                    layer.client = db.getVarchar(j,lang,29);
                    layer.export = db.getInt(30);
                    layer.imports = db.getInt(31);
                    layer.attestation = db.getVarchar(j,lang,32);
                    layer.bank = db.getVarchar(j,lang,33);
                    layer.accounts = db.getVarchar(j,lang,34);
                    layer.oem = db.getInt(35) != 0;
                    layer.developer = db.getInt(36);
                    layer.turnout = db.getVarchar(j,lang,37);
                    layer.acreage = db.getVarchar(j,lang,38);
                    layer.mass = db.getVarchar(j,lang,39);
                    layer.branch = db.getVarchar(j,lang,40);
                    layer.job = db.getVarchar(j,lang,41);
                    layer.logo = db.getString(42);
                    layer.picture = db.getString(43);
                    layer.superior = db.getInt(44);
                    personelarea = db.getString(45);
                    aptyp = db.getString(46);
                    layer._strEyp = db.getString(47);
                    layer.banner = db.getString(48);
                    qualification[0] = db.getString(49);
                    qualification[1] = db.getString(50);
                    qualification[2] = db.getString(51);
                    qualification[3] = db.getString(52);
                    layer.culturetitle = db.getVarchar(j,lang,53);
                    layer.culturepicture = db.getString(54);
                    layer.culturecontent = db.getVarchar(j,lang,55);
                    layer.adpic[0] = db.getString(56);
                    layer.adpic[1] = db.getString(57);
                    layer.adpic[2] = db.getString(58);
                    layer.adpic[3] = db.getString(59);
                    layer.adlink[0] = db.getString(60);
                    layer.adlink[1] = db.getString(61);
                    layer.adlink[2] = db.getString(62);
                    layer.adlink[3] = db.getString(63);
                    moneys = db.getBigDecimal(64,2);
                    layer.grade = db.getInt(65);
                    layer.compositor = db.getInt(66);
                    layer.credit = db.getInt(67);
                }
                if(layer.banner == null)
                {
                    layer.banner = "/tea/image/eyp/banner.jpg";
                }
                for(int i = 0;i < layer.adpic.length;i++)
                {
                    if(layer.adpic[i] == null)
                    {
                        layer.adpic[i] = "/tea/image/eyp/ad" + i + ".jpg";
                    }
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(lang),layer);
        }
        return layer;
    }
    public void set(int grade, int compositor, int credit, int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET grade=" + (grade) + ",compositor=" + compositor + ",credit=" + (credit) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }
    public int getGrade(int language) throws SQLException
    {
        return getLayer(language).grade;
    }

    public int getCompositor(int language) throws SQLException
    {
        return getLayer(language).compositor;
    }

    public int getCredit(int language) throws SQLException
    {
        return getLayer(language).credit;
    }

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Company WHERE node=" + _nNode + " AND language=" + i);
        } finally
        {
            db.close();
        }
        _htLayer.remove(new Integer(i));
    }

    public static Company find(int i)
    {
        Company company = (Company) _cache.get(new Integer(i));
        if(company == null)
        {
            company = new Company(i);
            _cache.put(new Integer(i),company);
        }
        return company;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Company WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration find2(String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,language,telephone,city FROM Company WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int node = db.getInt(1);
                int lang = db.getInt(2);
                String addr = db.getString(3);
                int city = db.getInt(4);
                vector.addElement(new Object[]
                                  {new Integer(node),new Integer(lang),addr,new Integer(city)
                });
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public int getCity(int i) throws SQLException
    {
        return getLayer(i)._nCity;
    }

    public int getCategory(int i) throws SQLException
    {
        return getLayer(i).category;
    }

    public int getSuperior(int language) throws SQLException
    {
        return getLayer(language).superior;
    }

    public String getCountry(int i) throws SQLException
    {
        return getLayer(i)._strCountry;
    }

    public String getEmail(int i) throws SQLException
    {
        return getLayer(i)._strEmail;
    }

    public String getContact(int i) throws SQLException
    {
        return getLayer(i)._strContact;
    }

    public static String getDetail(Node node,Http h,int listing,String target,Resource r) throws SQLException
    {
        int language = h.language;
        Span span = null;
        StringBuilder htm = new StringBuilder();
        boolean anchorThis = false;

        r.add("/tea/ui/node/type/obj/EditClassified");
        Company obj = Company.find(node._nNode);
        ListingDetail ld = ListingDetail.find(listing,21,language);;
        Iterator enumer = ld.keys();
        while(enumer.hasNext())
        {
            String name = (String) enumer.next(),value = null;
            int istype = ld.getIstype(name);
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
                    if(value!=null){
                    	value=value.replaceAll("\r\n", "<br/>");
                    }
                } else
                // HTML
                {
                    value = (node.getText2(language));
                }
                
            } else if(name.equals("logo"))
            {
                String logo = obj.getLogo(language);
                if(logo != null && logo.length() > 0)
                {
                    value = (new tea.html.Image(logo).toString());
                } else
                {
                    value = (new tea.html.Image("/res/lib/u/0805/080561405.jpg").toString());
                }

            } else if(name.equals("picture"))
            {
                if(obj.getPicture(language) != null && obj.getPicture(language).length() > 0)
                {
                    value = (new tea.html.Image(obj.getPicture(language)).toString());
                } else
                {
                    value = (new tea.html.Image("/res/lib/u/0805/080561405.jpg").toString());
                }
            } else if(name.equals("CorpJob"))
            {
                Enumeration enumeration = Job.findByOrg(node._nNode);
                int nodecode;
                StringBuilder sb = new StringBuilder();
                while(enumeration.hasMoreElements())
                {
                    nodecode = ((Integer) enumeration.nextElement()).intValue();
                    Job job = Job.find(nodecode,language);
                    node = Node.find(nodecode);
                    sb.append("<TR ID=\"CompanyIDCorpJobSub\"><TD><A ID=JobIDName HREF=\"/servlet/Job?node=" + nodecode + "\">" + job.getName() + "</A></TD><TD><SPAN ID=JobIDSltLocId>" + job.getLocIdToHtml() + "</SPAN></TD><TD><SPAN ID=JobIDValidity>" + node.getTimeToString() + "</SPAN></TD><TD><SPAN ID=JobIDTxtHeadCount>" + job.getHeadCount() + "</SPAN></TD></TR>"); // (new
                    // java.text.SimpleDateFormat("yyyy-MM-dd")).format(node.getTime())
                    // + "
                    // <A
                    // HREF=\"/servlet/Job?Node="
                    // +
                    // nodecode
                    // +
                    // "\">"
                    // +
                    // job.getName()
                    // +
                    // "</A>&nbsp;"
                    // +
                    // job.getSltLocId("&nbsp;"));
                }
                value = (sb.toString());
            } else if(name.equals("Contact"))
            {
                value = (obj.getContact(language));
            } else if(name.equals("CorpJobButton"))
            {
                value = ("<INPUT TYPE=BUTTON VALUE=" + r.getString(language,"CorpJob") + " onClick=\"window.open('/servlet/Node?node=" + node._nNode + "')\"/>");
            } else if(name.equals("EditButton"))
            {
                // String param = teasession.getQueryString();
                // if (param == null)
                // param = "";
                // value=("<INPUT TYPE=BUTTON VALUE=" +
                // r.getString(language, "Edit") + "
                // onClick=\"window.open('/servlet/EditNode?Node=" +
                // node._nNode + "&nexturl=" + teasession.getRequestURI() +
                // "?" + param + "', '_self')\"/>");
                value = ("<INPUT TYPE=HIDDEN NAME=Node VALUE=" + node._nNode + " />");
            } else if(name.equals("DeleteButton"))
            {
                String param = h.request.getQueryString();
                if(param == null)
                {
                    param = "";
                }
                value = ("<INPUT TYPE=\"BUTTON\" VALUE=" + r.getString(language,"CBDeleteNode") + " onClick=\"if(confirm('" + r.getString(language,"ConfirmDeleteTree") + "')){window.open('/servlet/DeleteNode?node=" + node._nNode + "&nexturl=" + h.request.getRequestURI() + "?" + param + "', '_self');}\"/>");
            } else if(name.equals("EmailAddress"))
            {
                anchorThis = true;
                value = (obj.getEmail(language));
            } else if(name.equals("Organization"))
            {
                value = (obj.getOrganization(language));
            } else if(name.equals("Address"))
            {
                value = (obj.getAddress(language));
            } else if(name.equals("City"))
            {
                value = Card.find(obj.getCity(language)).toString();
            } else if(name.equals("State"))
            {
                value = (obj.getState(language));
            } else if(name.equals("Zip"))
            {
                value = (obj.getZip(language));
            } else if(name.equals("Country"))
            {
                value = (obj.getCountry(language));
            } else if(name.equals("Telephone"))
            {
                value = (obj.getTelephone(language));
            } else if(name.equals("Fax"))
            {
                value = (obj.getFax(language));
            } else if(name.equals("WebPage"))
            {
                anchorThis = true;
                value = (obj.getWebPage(language));
            } else if(name.equals("map"))
            {
//					Mapabc map = Mapabc.find(node._nNode);
//					if (map.isExists() && !map.isHidden())
//					{
//						value = "<iframe src=http://channel.mapabc.com/openmap/map.jsp?id=" + map.getSid() + "&uid=7246&eid=102341&w=600&h=500 width=611 height=511 frameborder=0 ></iframe>";
//					}
            } else if(name.equals("eyp"))
            {
                value = obj.getEyp(language);
            } else if(name.equals("license"))
            {
                value = obj.getLicense(language);
                if(value != null)
                {
                    value = "<IMG SRC=" + value + ">";
                }
            } else if(name.equals("property"))
            {
                int property = obj.getProperty(language);
                if(property != 255)
                {
                    value = PROPERTY_TYPE[property];
                }
            } else if(name.equals("scale"))
            {
                int scale = obj.getScale(language);
                if(scale != 255)
                {
                    value = SIZE_TYPE[scale];
                }
            } else if(name.equals("calling"))
            {
                value = ((obj.getCallingToString(language)));
            } else if(name.equals("modes"))
            {
                value = ((obj.getMode(language)));
            } else if(name.equals("enrol"))
            {
                int enrol = obj.getEnrol(language);
                if(enrol != 255)
                {
                    value = ENROL_TYPE[enrol];
                }
            } else if(name.equals("product"))
            {
                value = ((obj.getProduct(language)));
            } else if(name.equals("enroladd"))
            {
                value = ((obj.getEnroladd(language)));
            } else if(name.equals("fareadd"))
            {
                value = ((obj.getFareadd(language)));
            } else if(name.equals("birth"))
            {
                value = ((obj.getBirth(language)));
            } else if(name.equals("brand"))
            {
                value = ((obj.getBrand(language)));
            } else if(name.equals("principal"))
            {
                value = ((obj.getPrincipal(language)));
            } else if(name.equals("turnover"))
            {
                int turnover = obj.getTurnover(language);
                if(turnover != 255)
                {
                    value = ENROL_TYPE[turnover];
                }
            } else if(name.equals("agora"))
            {
                value = ((obj.getAgora(language)));
            } else if(name.equals("client"))
            {
                value = ((obj.getClient(language)));
            } else if(name.equals("export"))
            {
                int export = obj.getExport(language);
                if(export != 255)
                {
                    value = ENROL_TYPE[export];
                }
            } else if(name.equals("imports"))
            {
                int imports = obj.getImports(language);
                if(imports != 255)
                {
                    value = ENROL_TYPE[imports];
                }
            } else if(name.equals("attestation"))
            {
                value = ((obj.getAttestation(language)));
            } else if(name.equals("bank"))
            {
                value = ((obj.getBank(language)));
            } else if(name.equals("accounts"))
            {
                value = ((obj.getAccounts(language)));
            } else if(name.equals("oem"))
            {
                value = ((obj.isOem(language) ? "是" : "否"));
            } else if(name.equals("developer"))
            {
                int developer = obj.getDeveloper(language);
                if(developer != 255)
                {
                    value = DEVELOPER_TYPE[developer];
                }
            } else if(name.equals("turnout"))
            {
                value = ((obj.getTurnout(language)));
            } else if(name.equals("acreage"))
            {
                value = ((obj.getAcreage(language)));
            } else if(name.equals("mass"))
            {
                value = ((obj.getMass(language)));
            } else if(name.equals("branch"))
            {
                value = ((obj.getBranch(language)));
            } else if(name.equals("job"))
            {
                value = ((obj.getJob(language)));
            } else if(name.equals("goods"))
            {
            	/*
                StringBuilder sb = new StringBuilder();
                Enumeration e = Brand.findByCompany(node._nNode);
                while(e.hasMoreElements())
                {
                    int brand = ((Integer) e.nextElement()).intValue();
                    sb.append("<LI>");
                    Enumeration e2 = Goods.findByBrand(brand);
                    while(e2.hasMoreElements())
                    {
                        int goods = ((Integer) e2.nextElement()).intValue();
                        Node n = Node.find(goods);
                        Goods g = Goods.find(goods);
                        String pic = g.getSmallpicture(language);
                        if(pic != null && pic.length() > 0)
                        {
                            sb.append("<SPAN ID=GoodsSmallpicture ><IMG onerror=\"this.style.display='none';\" SRC=").append(pic).append(" ></SPAN>");
                        }
                        sb.append("<SPAN ID=GoodsSubject ><A HREF=\"/servlet/Goods?node=").append(goods).append("&Language=").append(language).append("\" target=_blank >").append(n.getSubject(language)).append("</A></SPAN>");
                        sb.append("<SPAN ID=GoodsCapability >").append(g.getCapability(language)).append("</SPAN>");
                    }
                    sb.append("</LI>");
                }
                value = sb.toString();
                */
            	 StringBuilder sb = new StringBuilder();

                      Enumeration e2 = Goods.findByCompany(node._nNode);

                      while(e2.hasMoreElements())
                      {
                          int goods = ((Integer) e2.nextElement()).intValue();
                          Node n = Node.find(goods);
                          Goods g = Goods.find(goods);
                          String pic = g.getSmallpicture(language);
                          if(n.getSubject(h.language)!=null && n.getSubject(language).length()>0 && !n.isHidden()){

                               sb.append("<SPAN ID=Goods001><SPAN ID=GoodsSmallpicture ><A HREF=\"/servlet/Goods?node=" + goods + "&Language=" + language + " \" target=_blank ><IMG onerror=\"this.style.display='none';\" SRC=");
                               if (pic != null && pic.length() > 0)
                               {
                                   sb.append(pic);
                               }else
                               {
                                   sb.append("/tea/image/company_1.jpg");
                               }

                               sb.append(" ></A></SPAN>");
                              sb.append("<SPAN ID=GoodsSubject ><A HREF=\"/servlet/Goods?node=").append(goods).append("&Language=").append(language).append("\" target=_blank >").append(n.getSubject(language)).append("</A></SPAN>");
                              sb.append("<SPAN ID=GoodsCapability >").append(g.getCapability(language)).append("</SPAN></SPAN>");
                          }
                      }

                  value = sb.toString();

            }
            int qu = ld.getQuantity(name);
            if(value != null && qu > 0 && value.length() > qu)
            {
                value = value.substring(0,qu) + " ...";
            }
            if(ld.getAnchor(name) != 0)
            {
                Anchor anchor = null;
                if(anchorThis)
                {
                    anchorThis = false;
                    anchor = new Anchor(value,value);
                } else
                {
                    anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/company/" + node._nNode + "-" + language + ".htm",value);
                }
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("CompanyID" + name);
            htm.append(ld.getBeforeItem(name)).append(span).append(ld.getAfterItem(name));
        }
        return htm.toString();
    }

    public void setMode(String modes,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET modes=" + DbAdapter.cite(modes) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setEnrol(int enrol,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET enrol=" + (enrol) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setProduct(String product,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET product=" + DbAdapter.cite(product) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setEnroladd(String enroladd,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET enroladd=" + DbAdapter.cite(enroladd) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setFareadd(String fareadd,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET fareadd=" + DbAdapter.cite(fareadd) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setBirth(String birth,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET birth=" + DbAdapter.cite(birth) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setBrand(String brand,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET brand=" + DbAdapter.cite(brand) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setPrincipal(String principal,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET principal=" + DbAdapter.cite(principal) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setTurnover(String turnover,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET turnover=" + DbAdapter.cite(turnover) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setAgora(String agora,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET agora=" + DbAdapter.cite(agora) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setClient(String client,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET client=" + DbAdapter.cite(client) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setExport(int export,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET export=" + (export) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setImports(int imports,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET imports=" + (imports) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setAttestation(String attestation,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET attestation=" + DbAdapter.cite(attestation) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setBank(String bank,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET bank=" + DbAdapter.cite(bank) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setAccounts(String accounts,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET accounts=" + DbAdapter.cite(accounts) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setOem(boolean oem,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET oem=" + (oem ? "1" : "0") + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setSuperior(int superior,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET superior=" + superior + " WHERE node=" + _nNode + " AND language=" + language);
            sequence = 0;
            setSequence(0);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    private void setSequence(int superior) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Vector vector = new Vector();
        try
        {
            db.executeQuery("SELECT DISTINCT Node.node,Node.sequence,time FROM Node,Company WHERE Node.community=(SELECT community FROM Node WHERE node=" + this._nNode + ") AND Node.node=Company.node AND superior=" + superior + " ORDER BY Node.sequence ,time");
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
            Enumeration enumer = vector.elements();
            while(enumer.hasMoreElements())
            {
                int nodecode = ((Integer) enumer.nextElement()).intValue();
                db.executeUpdate("UPDATE Company SET sequence=" + (++sequence) + " WHERE node=" + nodecode);
                setSequence(nodecode);
            }
        } finally
        {
            db.close();
        }
    }

    public void setDeveloper(int developer,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET developer=" + developer + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setTurnout(String turnout,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET turnout=" + DbAdapter.cite(turnout) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setAcreage(String acreage,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET acreage=" + DbAdapter.cite(acreage) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setMass(String mass,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET mass=" + DbAdapter.cite(mass) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public String getMode(int language) throws SQLException
    {
        return getLayer(language).modes;
    }

    public int getEnrol(int language) throws SQLException
    {
        return getLayer(language).enrol;
    }

    public String getProduct(int language) throws SQLException
    {
        return getLayer(language).product;
    }

    public String getEnroladd(int language) throws SQLException
    {
        return getLayer(language).enroladd;
    }

    public String getFareadd(int language) throws SQLException
    {
        return getLayer(language).fareadd;
    }

    public String getBirth(int language) throws SQLException
    {
        return getLayer(language).birth;
    }

    public String getBrand(int language) throws SQLException
    {
        return getLayer(language).brand;
    }

    public String getPrincipal(int language) throws SQLException
    {
        return getLayer(language).principal;
    }

    public int getTurnover(int language) throws SQLException
    {
        return getLayer(language).turnover;
    }

    public String getAgora(int language) throws SQLException
    {
        return getLayer(language).agora;
    }

    public String getClient(int language) throws SQLException
    {
        return getLayer(language).client;
    }

    public int getExport(int language) throws SQLException
    {
        return getLayer(language).export;
    }

    public int getImports(int language) throws SQLException
    {
        return getLayer(language).imports;
    }

    public String getAttestation(int language) throws SQLException
    {
        return getLayer(language).attestation;
    }

    public String getBank(int language) throws SQLException
    {
        return getLayer(language).bank;
    }

    public String getAccounts(int language) throws SQLException
    {
        return getLayer(language).accounts;
    }

    public boolean isOem(int language) throws SQLException
    {
        return getLayer(language).oem;
    }

    public int getDeveloper(int language) throws SQLException
    {
        return getLayer(language).developer;
    }

    public String getTurnout(int language) throws SQLException
    {
        return getLayer(language).turnout;
    }

    public String getAcreage(int language) throws SQLException
    {
        return getLayer(language).acreage;
    }

    public String getMass(int language) throws SQLException
    {
        return getLayer(language).mass;
    }

    public void setBranch(String branch,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET branch=" + DbAdapter.cite(branch) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setJob(String job,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET job=" + DbAdapter.cite(job) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public String getBranch(int language) throws SQLException
    {
        return getLayer(language).branch;
    }

    public String getJob(int language) throws SQLException
    {
        return getLayer(language).job;
    }

    public void setLogo(String logo,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET logo=" + DbAdapter.cite(logo) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setPicture(String picture,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET picture=" + DbAdapter.cite(picture) + " WHERE node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setAd(int language,int i,String pic,String link) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("UPDATE Company SET adlink").append(i).append("=").append(DbAdapter.cite(link));
        if(pic != null)
        {
            sb.append(",adpic").append(i).append("=").append(DbAdapter.cite(pic));
        }
        sb.append(" WHERE node=").append(_nNode).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sb.toString());
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public String getLogo(int language) throws SQLException
    {
        return getLayer(language).logo;
    }

    public String getPicture(int language) throws SQLException
    {
        return getLayer(language).picture;
    }

    public String[] getAdPic(int language) throws SQLException
    {
        return getLayer(language).adpic;
    }

    public String[] getAdLink(int language) throws SQLException
    {
        return getLayer(language).adlink;
    }

    public String getMap(int language) throws SQLException
    {
        return getLayer(language)._strMap;
    }

    public String getEyp(int language) throws SQLException
    {
        return getLayer(language)._strEyp;
    }

    public String getBanner(int language) throws SQLException
    {
        return getLayer(language).banner;
    }

    public void setBanner(int language,String banner) throws SQLException
    {
        set_(language,"banner",String.valueOf(banner));
    }

    public String getPersonelarea() throws SQLException
    {
        getLayer(1);
        return personelarea;
    }

    public String getAptyp() throws SQLException
    {
        getLayer(1);
        return aptyp;
    }
    public java.math.BigDecimal getMoneys() throws SQLException
    {
        getLayer(1);
        return moneys;
    }

    public String[] getQualification() throws SQLException
    {
        getLayer(1);
        return qualification;
    }

    public void setQualification(String qualification[]) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET qualification0=" + DbAdapter.cite(qualification[0]) + ",qualification1=" + DbAdapter.cite(qualification[1]) + ",qualification2=" + DbAdapter.cite(qualification[2]) + ",qualification3=" + DbAdapter.cite(qualification[3]) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.qualification = qualification;
    }
    public void setMoneys(java.math.BigDecimal moneys)throws SQLException
    {
        DbAdapter db = new DbAdapter();
      try
      {
          db.executeUpdate("UPDATE Company SET moneys=" + (moneys)  + " WHERE node=" + _nNode);
      } finally
      {
          db.close();
      }
      this.moneys = moneys;
    }

    public void setCulture(int language,String title,String picture,String content) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("UPDATE Company SET culturetitle=").append(DbAdapter.cite(title));
        if(picture != null)
        {
            sb.append(",culturepicture=").append(DbAdapter.cite(picture));
        }
        sb.append(",culturecontent=").append(DbAdapter.cite(content)).append(" WHERE node=").append(_nNode).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sb.toString());
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public String getCultureTitle(int language) throws SQLException
    {
        return getLayer(language).culturetitle;
    }

    public String getCulturePicture(int language) throws SQLException
    {
        return getLayer(language).culturepicture;
    }

    public String getCultureContent(int language) throws SQLException
    {
        return getLayer(language).culturecontent;
    }

    public void setAptyp(String aptyp) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Company SET aptyp=" + DbAdapter.cite(aptyp) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.aptyp = aptyp;
    }

    public static int findByAptyp(String aptyp) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Company WHERE aptyp=" + DbAdapter.cite(aptyp));
            if(db.next())
            {
                return db.getInt(1);
            } else
            {
                return 0;
            }
        } finally
        {
            db.close();
        }
    }
}
