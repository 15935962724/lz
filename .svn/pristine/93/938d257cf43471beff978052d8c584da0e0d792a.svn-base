package tea.entity.node;

import java.math.*;
import java.sql.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.html.*;
import tea.resource.*;

public class Goods extends Entity
{
    private static Cache _cache = new Cache(2000);
    private Hashtable _htLayer;
    private int node;
    private int language;
    private String goodstype;
    private int brand;
    private boolean status;
    private int company;
    private BigDecimal price; //定　　价
    private String no; //产品编号
    private int hits; //购买计数
    private int used; //0:不做区分  1:前台 2:后台
    private boolean dtype; //false:% dtype:0
    private float deduct; //提成量
    private int correspond;
    private int correspond2;
    private int correspond3;
    private int correspond4;
    private int correspond5;
    private int correspond6;
    private String barcode; //条形码
    private boolean exists;
    class Layer
    {
        String measure; //计量单位
        String spec; //规格
        String capability; //供货能力
        String smallpicture;
        String bigpicture;
        String commendpicture;
    }


    public static Goods find(int node) throws SQLException
    {
        Goods obj = (Goods) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new Goods(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public Goods(int node) throws SQLException
    {
        this.node = node;
        _htLayer = new Hashtable();
        load();
    }


    public void set(String goodstype,int brand,String no,boolean status,int company,BigDecimal price,int used,boolean dtype,float deduct,int correspond,int correspond2,int correspond3,int correspond4,int correspond5,int correspond6,int language,String measure,String spec,String capability,String smallpicture,String bigpicture,String commendpicture) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Goods SET goodstype=" + DbAdapter.cite(goodstype) + ",brand=" + brand + ",no=" + DbAdapter.cite(no) + ",status=" + (status ? "1" : "0") + ",company=" + company + ",price=" + price + ",used=" + used + ",dtype=" + DbAdapter.cite(dtype) + ",deduct=" + deduct + ",correspond=" + correspond + ",correspond2=" + correspond2 + ",correspond3=" + correspond3 + ",correspond4=" + correspond4 + ",correspond5=" + correspond5 + ",correspond6=" + correspond6 + "WHERE node=" + node);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Goods(node,goodstype,brand,no,status,company,price,dtype,deduct,correspond,correspond2,correspond3,correspond4,correspond5,correspond6,hits,language,used)VALUES(" +
                                 node + "," + DbAdapter.cite(goodstype) + "," + brand + "," + DbAdapter.cite(no) + "," + (status ? "1" : "0") + "," + company + "," + price + "," + db.cite(dtype) + "," + deduct + "," + correspond + "," + correspond2 + "," + correspond3 + "," + correspond4 + "," + correspond5 + "," + correspond6 + ",0," + language + "," + used + ")");
            }
            j = db.executeUpdate("UPDATE Goods SET measure=" + DbAdapter.cite(measure) + ",spec=" + DbAdapter.cite(spec) + ",capability=" + DbAdapter.cite(capability) + ",smallpicture=" + DbAdapter.cite(smallpicture) + ",bigpicture=" + DbAdapter.cite(bigpicture) + ",commendpicture=" + DbAdapter.cite(commendpicture) + ",used=" + used + " WHERE node=" + node + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Goods(node,language,measure,spec,capability,smallpicture,bigpicture,commendpicture,used)VALUES(" + node + "," + language + "," + DbAdapter.cite(measure) + "," + DbAdapter.cite(spec) + "," + DbAdapter.cite(capability) + "," + DbAdapter.cite(smallpicture) + "," + DbAdapter.cite(bigpicture) + "," + DbAdapter.cite(commendpicture) + "," + used + ")");
            }
        } finally
        {
            db.close();
        }
        this.goodstype = goodstype;
        this.brand = brand;
        this.no = no;
        this.status = status;
        this.company = company;
        this.price = price;
        this.used = used;
        this.dtype = dtype;
        this.deduct = deduct;
        this.correspond = correspond;
        this.correspond2 = correspond2;
        this.correspond3 = correspond3;
        this.correspond4 = correspond4;
        this.correspond5 = correspond5;
        this.correspond6 = correspond6;

        this.exists = true;
        _htLayer.clear();
    }

    public static Enumeration findByLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT brand FROM Brand WHERE language=" + language);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByBrand(int brand) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT g.node FROM Goods g WHERE g.brand=" + brand);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByCompany(int company) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT g.node FROM Goods g WHERE g.company=" + company);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByBrand(int brand,int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT n.node FROM Node n,Goods g WHERE g.node=n.node AND n.father=" + node + " AND g.brand LIKE " + DbAdapter.cite("%/" + brand + "/%"));
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByBrand(int brand,int node,String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT n.node FROM Node n,Goods g WHERE g.node=n.node AND n.father<>" + node + " AND n.community=" + DbAdapter.cite(community) + " AND g.brand LIKE " + DbAdapter.cite("%/" + brand + "/%"));
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Goods WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void setBarcode(String barcode) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Goods SET barcode=" + DbAdapter.cite(barcode) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.barcode = barcode;

    }

    public static boolean isBarcode(String barcode) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        boolean f = false;
        try
        {
            db.executeQuery("select node from Goods where barcode = " + db.cite(barcode));
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;

    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT goodstype,brand,no,status,company,price,hits,used,dtype,deduct,correspond,correspond2,correspond3,correspond4,correspond5,correspond6,barcode FROM Goods WHERE node=" + node);
            if(db.next())
            {
                goodstype = db.getString(1);
                brand = db.getInt(2);
                no = db.getString(3);
                status = db.getInt(4) != 0;
                company = db.getInt(5);
                price = db.getBigDecimal(6,2);
                hits = db.getInt(7);
                used = db.getInt(8);
                dtype = db.getInt(9) != 0;
                deduct = db.getFloat(10);
                correspond = db.getInt(11);
                correspond2 = db.getInt(12);
                correspond3 = db.getInt(13);
                correspond4 = db.getInt(14);
                correspond5 = db.getInt(15);
                correspond6 = db.getInt(16);
                barcode = db.getString(17);
                exists = true;
            } else
            {
                exists = false;
                goodstype = "/";
            }
        } finally
        {
            db.close();
        }
    }

    private Layer getLayer(int language) throws SQLException
    {
        Layer obj = (Layer) _htLayer.get(new Integer(language));
        if(obj == null)
        {
            int j = Node.getLanguage(node,language);
            obj = new Layer();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT measure,spec,capability,smallpicture,bigpicture,commendpicture FROM Goods WHERE node=" + node + " AND language=" + j);
                if(db.next())
                {
                    obj.measure = db.getVarchar(j,language,1);
                    obj.spec = db.getVarchar(j,language,2);
                    obj.capability = db.getVarchar(j,language,3);
                    obj.smallpicture = db.getString(4);
                    obj.bigpicture = db.getString(5);
                    obj.commendpicture = db.getString(6);
                } else
                {
                    obj.measure = obj.spec = obj.capability = obj.smallpicture = obj.bigpicture = obj.commendpicture = "";
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(language),obj);
        }
        return obj;
    }

    //查询出来的公司的主要产品
    public static String getGoods(int node,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        StringBuffer sp = new StringBuffer();
        try
        {
            db.executeQuery("SELECT node FROM Goods WHERE company = " + node);
            for(int i = 0;db.next();i++)
            {
                Node n = Node.find(db.getInt(1));
                sp.append("<a href =/servlet/Node?Node=" + db.getInt(1) + "&Language=" + language + ">" + n.getSubject(language) + "</a>&nbsp;&nbsp;");
                if(i == 3)
                    break;
            }
        } finally
        {
            db.close();
        }
        return sp.toString();
    }

    public void setGoodstype(String goodstype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Goods SET goodstype=" + DbAdapter.cite(goodstype) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.goodstype = goodstype;
    }

    public void setHits(int hits) throws SQLException
    {
        this.hits += hits;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Goods SET hits=" + this.hits + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getBrand()
    {
        return brand;
    }

    public String getMeasure(int language) throws SQLException
    {
        return getLayer(language).measure;
    }

    public String getSpec(int language) throws SQLException
    {
        return getLayer(language).spec;
    }

    public String getCapability(int language) throws SQLException
    {
        return getLayer(language).capability;
    }

    // 销售价
    public BigDecimal getPrice() throws SQLException
    {
        BigDecimal bd = price != null ? price : BigDecimal.ZERO;
        Enumeration e = Commodity.findByGoods(node);
        while(e.hasMoreElements())
        {
            BuyPrice bp = BuyPrice.find(((Integer) e.nextElement()).intValue(),1);
            if(bp.isExists() && (bd.floatValue() == 0F || bd.compareTo(bp.getPrice()) > 0))
            {
                bd = bp.getPrice();
            }
        }
        return bd;
    }

    // 供货价
    public BigDecimal getSupply() throws SQLException
    {
        BigDecimal bd = BigDecimal.ZERO;
        Enumeration enumer_commodity = Commodity.findByGoods(node);
        while(enumer_commodity.hasMoreElements())
        {
            BuyPrice bp = BuyPrice.find(((Integer) enumer_commodity.nextElement()).intValue(),1);
            if(bp.isExists() && (bd.floatValue() == 0F || bd.compareTo(bp.getSupply()) > 0))
            {
                bd = bp.getSupply();
            }
        }
        return bd;
    }

    // 标价
    public BigDecimal getList() throws SQLException
    {
        BigDecimal bd = BigDecimal.ZERO;
        Enumeration e = Commodity.findByGoods(node);
        while(e.hasMoreElements())
        {
            BuyPrice bp = BuyPrice.find(((Integer) e.nextElement()).intValue(),1);
            if(bp.isExists() && (bd.floatValue() == 0F || bd.compareTo(bp.getList()) > 0))
            {
                bd = bp.getList();
            }
        }
        return bd;
    }

    //积分
    public BigDecimal getPoint() throws SQLException
    {
        BigDecimal bd = BigDecimal.ZERO;
        Enumeration e = Commodity.findByGoods(node);
        while(e.hasMoreElements())
        {
            BuyPrice bp = BuyPrice.find(((Integer) e.nextElement()).intValue(),1);
            if(bp.isExists() && (bd.floatValue() == 0F || bd.compareTo(bp.getPoint()) > 0))
            {
                bd = bp.getPoint();
            }
        }
        return bd;
    }


    public String getSmallpicture(int language) throws SQLException
    {
        return getLayer(language).smallpicture;
    }

    public String getBigpicture(int language) throws SQLException
    {
        return getLayer(language).bigpicture;
    }

    public String getCommendpicture(int language) throws SQLException
    {
        return getLayer(language).commendpicture;
    }

    public boolean isStatus()
    {
        return status;
    }

    public int getCorrespond()
    {
        return correspond;
    }

    public int getCorrespond2()
    {
        return correspond2;
    }

    public int getCorrespond3()
    {
        return correspond3;
    }

    public int getCorrespond4()
    {
        return correspond4;
    }

    public int getCorrespond5()
    {
        return correspond5;
    }

    public int getCorrespond6()
    {
        return correspond6;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getGoodstype()
    {
        return goodstype;
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r)
    {
        RV rv = h.username == null ? null : new RV(h.username);
        StringBuilder sb = new StringBuilder();
        try
        {
            int _nNode = node._nNode;
            String subject = node.getSubject(h.language);
            Goods obj = Goods.find(_nNode);

            ListingDetail detail = ListingDetail.find(listing,34,h.language);
            Iterator e = detail.keys();
            while(e.hasNext())
            {
                tea.html.Span span = null;
                String name = (String) e.next(),value = null,v2 = null;
                int istype = detail.getIstype(name);
                if(istype == 0)
                {
                    continue;
                }
                if(name.equals("code"))
                {
                    value = node.getNumber(); //String.valueOf(_nNode);

                } else if(name.equals("brand"))
                {
                    /*
                     * String str = obj.getBrand(); String b[] = str.split("/"); StringBuilder _sbBrand = new StringBuilder(); if (b.length > 1) { for (int index = 1; index < b.length; index++) { try { _sbBrand.append(Brand.find(Integer.parseInt(b[index])).getName(h.language)); } catch (NumberFormatException ex1) { } } } value=(_sbBrand.toString());
                     */
                    Brand b = Brand.find(obj.getBrand());
                    value = b.getName(h.language);
                } else if(name.equals("name"))
                {
                    value = subject;
                } else if(name.equals("text"))
                {
                    // if((node.getOptions() & 0x40L) == 0&&node.getText2(h.language)!=null && node.getText2(h.language).length()>0)
                    // {
                    // value = node.getText2(h.language).replaceAll("   ", " &nbsp; ").replaceAll("\r\n", "<br />");//(tea.html.Text.toHTML(node.getText2(h.language)));
                    // } else
                    //  {

                    value = (node.getText2(h.language));
                    // }
                } else if(name.equals("measure"))
                {
                    value = (obj.getMeasure(h.language));
                } else if(name.equals("spec"))
                {
                    value = (obj.getSpec(h.language));
                } else if(name.equals("price"))
                {
                    value = "¥" + (String.valueOf(obj.getPrice()));
                } else if(name.equals("price2"))
                {
                    value = "¥" + (String.valueOf(obj.getSupply()));
                } else if(name.equals("price3"))
                {
                    value = "¥" + (String.valueOf(obj.getList()));
                } else if(name.equals("smallpicture"))
                {
                    String pic = obj.getSmallpicture(h.language);
                    if(pic.length() > 0)
                    {
                        tea.html.Image img = new tea.html.Image(pic);
                        img.setId("Goodssmallpicture");
                        value = (img.toString());
                    }
                } else if(name.equals("bigpicture"))
                {
                    String pic = obj.getBigpicture(h.language);
                    if(pic != null && pic.length() > 0)
                    {
                        tea.html.Image img = new tea.html.Image(pic);
                        img.setId("Goodsbigpicture");
                        value = img.toString();
                    }
                } else if(name.equals("recommendpicture"))
                {
                    String pic = obj.getCommendpicture(h.language);
                    if(pic.length() > 0)
                    {
                        tea.html.Image img = new tea.html.Image(pic);
                        img.setId("Goodsrecommendpicture");
                        value = (img.toString());
                    }
                } else if(name.equals("status2"))
                {
                    value = (obj.isStatus() ? "有货" : "无货");
                }

                else if(name.startsWith("correspond"))
                {
                    int correspond = 0;
                    StringBuilder s = new StringBuilder();
                    if(name.equals("correspond"))
                    {
                        correspond = obj.getCorrespond();
                    } else if(name.equals("correspond2"))
                    {
                        correspond = obj.getCorrespond2();
                    } else if(name.equals("correspond3"))
                    {
                        correspond = obj.getCorrespond3();
                    } else if(name.equals("correspond4"))
                    {
                        correspond = obj.getCorrespond4();
                    } else if(name.equals("correspond5"))
                    {
                        correspond = obj.getCorrespond5();
                    } else if(name.equals("correspond6"))
                    {
                        correspond = obj.getCorrespond6();
                    }
                    Node n = Node.find(correspond);
                    if(n.getCreator() != null)
                    {
                        Goods g = Goods.find(correspond);
                        String sp = g.getSmallpicture(h.language);
                        if(sp != null && sp.length() > 1)
                        {
                            s.append("<SPAN ID=GoodsIDcorrespondpic><A href=/servlet/Goods?Node=").append(correspond).append("&Language=").append(h.language).append("><IMG SRC=").append(sp).append("></A></SPAN>");
                        }
                        s.append("<SPAN ID=GoodsIDcorrespondsubject><A href=/servlet/Goods?Node=").append(correspond).append("&Language=").append(h.language).append(">").append(n.getSubject(h.language)).append("</A></SPAN>");
                        s.append("<SPAN ID=GoodsIDcorrespondprice>").append(r.getString(h.language,Common.CURRENCY[1])).append(g.getPrice()).append("</SPAN>");
                        s.append("<SPAN ID=GoodsIDcorrespondbutton><INPUT TYPE=BUTTON VALUE=购买 onclick=window.open('/servlet/Goods?Node=").append(correspond).append("&Language=").append(h.language).append("','_self');></SPAN>");
                    }
                    value = s.toString();
                } else if(name.equals("capability"))
                {
                    value = obj.getCapability(h.language);
                } else if(name.equals("company"))
                {
                    Brand b = null;
                    if(obj.getBrand() != 0 && (b = Brand.find(obj.getBrand())).isExists())
                    {
                        int company = b.getCompany();
                        if(company != 0)
                        {
                            Node n = Node.find(company);
                            if(n.getCreator() != null)
                            {
                                Company c = Company.find(company);
                                StringBuilder s = new StringBuilder();
                                String logo = c.getLogo(h.language);
                                if(logo != null && logo.length() > 0)
                                {
                                    s.append("<SPAN ID=CompanyLogo ><IMG onerror=\"this.style.display='none';\" SRC=").append(logo).append(" ></SPAN>");
                                }
                                s.append("<SPAN ID=CompanySubject ><A HREF=\"/servlet/Company?Node=").append(company).append("&Language=").append(h.language).append("\" target=_blank >").append(n.getSubject(h.language)).append("</A></SPAN>");
                                s.append("<SPAN ID=CompanyProduct >").append(c.getProduct(h.language)).append("</SPAN>");
                                s.append("<SPAN ID=CompanyWebpage ><A HREF=\"").append(c.getWebPage(h.language)).append("\" target=_blank >").append(c.getWebPage(h.language)).append("</A></SPAN>");
                                value = s.toString();
                            }
                        }
                    }
                } else if(name.equals("attribute")) // 动态属性-细节
                {
                    Enumeration enumer = AttributeValue.findByNode2(_nNode);
                    while(enumer.hasMoreElements())
                    {
                        int id = ((Integer) enumer.nextElement()).intValue();
                        AttributeValue av_obj = AttributeValue.find(_nNode,id);
                        if(av_obj.getAttrvalue(h.language) != null && av_obj.getAttrvalue(h.language).length() > 1)
                        {
                            Attribute attr_obj = Attribute.find(id);
                            if("img".equals(attr_obj.getTypes()))
                            {
                                value = ("<IMG SRC=" + av_obj.getAttrvalue(h.language) + ">");
                            } else if("file".equals(attr_obj.getTypes()))
                            {
                                value = ("<INPUT TYPE=BUTTON onClick=\"location='" + av_obj.getAttrvalue(h.language) + "';\">");
                            } else
                            {
                                value = (av_obj.getAttrvalue(h.language));
                            }
                            Span span_n = new Span(attr_obj.getName(h.language) + "：");
                            span_n.setId("GoodsIDN" + id);
                            Span span_v = new Span(value);
                            span_v.setId("GoodsIDV" + id);
                            sb.append(detail.getBeforeItem(name)).append(span_n).append(span_v).append(detail.getAfterItem(name));
                        }
                    }
                    continue;
                } else if(name.startsWith("attribute"))
                { // 动态属性
                    int id = Integer.parseInt(name.substring(9));
                    Attribute attr_obj = Attribute.find(id);
                    if(node.getCommunity().equals(attr_obj.getCommunity())) // 判断是否本社区的属性,列举的复制会把源社区所在的属性复制到本社区来.
                    {
                        AttributeValue av_obj = AttributeValue.find(_nNode,id);
                        v2 = av_obj.getAttrvalue(h.language);
                        if(v2 != null && v2.length() > 1)
                        {
                            if("img".equals(attr_obj.getTypes()))
                            {
                                value = "<IMG SRC=" + v2 + ">";
                            } else if("file".equals(attr_obj.getTypes()))
                            {
                                value = "<INPUT TYPE=BUTTON onClick=\"location='" + v2 + "';\">";
                            } else
                            {
                                value = v2;
                            }
                        }
                    } else
                    {
                        continue;
                    }
                } else
                {
                    continue;
                }
                int qu = detail.getQuantity(name);
                if(value != null && qu > 0 && value.length() > qu)
                {
                    value = value.substring(0,qu) + " ...";
                }
                switch(detail.getAnchor(name))
                {
                case 1:
                    tea.html.Anchor anchor = new tea.html.Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/goods/" + _nNode + "-" + h.language + ".htm",value);
                    anchor.setId("GoodsIDA" + name);
                    anchor.setTarget(target);
                    anchor.setTitle(subject);
                    span = new tea.html.Span(anchor);
                    break;
                case 2:
                {
                    String pic = obj.getBigpicture(h.language);
                    if(pic != null && pic.length() > 0)
                    {
                        // java.awt.image.BufferedImage bi = javax.imageio.ImageIO.read(file2);
                        //anchor = new Anchor("###",null,new Text(value),"GoodsIDAnchor2","javascript:window.open('about:blank','','height=300,width=400,top=200,left=300,toolbar=no,menubar=no,scrollbars=no, location=no, status=no').document.write('<img src=" + pic + " onload=window.resizeTo(this.width+30,this.height+50) >');"); // status:0;
                        span = new Span("<a href='javascript:;' id='GoodsIDAnchor2' onclick=\"mt.img('" + pic + "')\">" + value + "</a>");
                    }
                }
                break;
                case 3:
                {
                    String pic = obj.getCommendpicture(h.language);
                    if(pic != null && pic.length() > 0)
                    {
                        anchor = new Anchor("###",null,new Text(value),"GoodsIDAnchor2","javascript:window.open('about:blank','','height=300,width=400,top=200,left=300,toolbar=no,menubar=no,scrollbars=no, location=no, status=no').document.write('<img src=" + pic + " onload=window.resizeTo(this.width+30,this.height+50) >');"); // status:0;
                        span = new Span(anchor);
                    }
                }
                break;
                case 4: // 自身
                    if(v2 != null && v2.length() > 0)
                    {
                        anchor = new Anchor("###",null,new Text(value),"GoodsIDAnchor2","javascript:window.open('about:blank','','height=300,width=400,top=200,left=300,toolbar=no,menubar=no,scrollbars=no, location=no, status=no').document.write('<img src=" + v2 + " onload=window.resizeTo(this.width+30,this.height+50) >');"); // status:0;
                        span = new Span(anchor);
                    }
                    break;
                }
                if(span == null)
                {
                    span = new tea.html.Span(value);
                }
                span.setId("GoodsID" + name);
                sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
            }
            // //////////////////////////
            Span span = null;
            Enumeration eBuy = Commodity.findByGoods(_nNode); //
            while(eBuy.hasMoreElements())
            {
                int id = ((Integer) eBuy.nextElement()).intValue();
                Commodity buy_obj = Commodity.find(id);
                Iterator buy_listingDetailEnumeration = detail.keys(); //34
                while(buy_listingDetailEnumeration.hasNext())
                {
                    String name = (String) buy_listingDetailEnumeration.next(),value = null;
                    int istype = detail.getIstype(name);
                    if(istype == 0)
                    {
                        continue;
                    }
                    if(name.equals("supplier"))
                    {
                        Supplier s = Supplier.find(buy_obj.getSupplier());
                        if(s.isExists())
                        {
                            value = s.getName(h.language);
                        }
                    } else if(name.equals("sku"))
                    {
                        value = (buy_obj.getSKU());
                    } else if(name.equals("serialNumber"))
                    {
                        value = (buy_obj.getSerialNumber());
                    } else if(name.equals("goods"))
                    {
                        value = String.valueOf(buy_obj.getGoods());
                    } else if(name.equals("quality"))
                    {
                        value = String.valueOf(buy_obj.getQuality());
                    } else if(name.equals("inventory"))
                    {
                        value = String.valueOf(buy_obj.getInventory());
                    } else if(name.equals("minQuantity"))
                    {
                        value = String.valueOf(buy_obj.getMinQuantity());
                    } else if(name.equals("maxQuantity"))
                    {
                        value = String.valueOf(buy_obj.getMaxQuantity());
                    } else if(name.equals("delta"))
                    {
                        value = String.valueOf(buy_obj.getDelta());
                    } else if(name.equals("weight"))
                    {
                        value = String.valueOf(buy_obj.getWeight());
                    } else if(name.equals("volume"))
                    {
                        value = String.valueOf(buy_obj.getVolume());
                    } else
                    {
                        continue;
                    }
                    if(detail.getAnchor(name) != 0)
                    {
                        Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/goods/" + _nNode + "-" + h.language + ".htm",value);
                        anchor.setTarget(target);
                        anchor.setId("GoodsIDA" + name);
                        span = new Span(anchor);
                    } else
                    {
                        span = new Span(value);
                    }
                    span.setId("GoodsID" + name);
                    sb.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
                }
                Enumeration enumer = BuyPrice.find(id);
                while(enumer.hasMoreElements())
                {
                    int currency = ((Integer) enumer.nextElement()).intValue();
                    BuyPrice bp = BuyPrice.find(id,currency);
                    e = detail.keys();
                    while(e.hasNext())
                    {
                        String name = (String) e.next(),value = null;
                        if(name.equals("atsc")) //加入购物车
                        {
                            StringBuilder atsc = new StringBuilder();
                            String strid = "quantity." + Math.random();
                            if(detail.getIstype("quantity") > 0)
                            {
                                atsc.append(detail.getBeforeItem("quantity")).append("<input id=" + strid + " value=1 size=4>").append(detail.getAfterItem("quantity"));
                            } else
                            {
                                atsc.append("<input class=hiddenid  type=hidden id=" + strid + " value=1>");
                            }
                            String click;
                            // if(rv == null)
                            // {
                            // click = "window.showModalDialog('/jsp/user/RapidRegister.jsp?acts=g&node="+_nNode+"&commodity="+id+"&currency="+currency+"&strid="+strid+"',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:420px;dialogHeight:360px;');";
                            //click = "window.open('/servlet/StartLogin?node=" + _nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8") + "','_self');";
                            // } else
                            //{
                            click = "var obj=document.getElementById('" + strid + "'); if(submitInteger(obj,'" + r.getString(h.language,"InvalidQuantity") + "'))mt.post('/servlet/OfferBuy?node=" + _nNode + "&commodity=" + id + "&currency=" + currency + "&quantity='+obj.value);";
                            //}
                            atsc.append("<INPUT TYPE=BUTTON VALUE=" + r.getString(h.language,"CBAddToShoppingCart") + " onclick=\"" + click + "\">");
                            value = atsc.toString();

                        } else if(name.equals("wdsc")) //我的收藏
                        {
                            String strClick = null;
                            if(rv == null)
                            {
                                String nexturl = h.request.getRequestURI() + "?" + h.request.getQueryString();
                                //strClick = "window.open('/servlet/StartLogin?Node=" + _nNode + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8") + "','_self');";
                                strClick = "window.showModalDialog('/jsp/user/RapidRegister.jsp?acts=s&node=" + _nNode + "',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:420px;dialogHeight:360px;');";
                            } else
                            {
                                //strClick = "window.open('/jsp/add/AddToFavorite_1.jsp?Node=" + _nNode + "');"; // ,'height=170,width=370,left=250,top=150'
                                strClick = "showDialog('加入收藏','/servlet/OfferCollect?node=" + _nNode + "');";
                                //  strClick = "window.showModalDialog('/jsp/add/AddToFavorite_2.jsp?Node=" + _nNode + "',self,'edge:raised;scroll:0;status:1;help:0;resizable:0;dialogWidth:320px;dialogHeight:260px;center:1;');"; // scroll:1,'height=170,width=370,left=250,top=150'
                            }
                            value = (new tea.html.Button("加入收藏",r.getString(h.language,"加入收藏"),strClick).toString());
                        }

                        else if(name.equals("currency"))
                        {
                            value = r.getString(h.language,Common.CURRENCY[currency]);
                        } else if(name.equals("supply"))
                        {
                            value = r.getString(h.language,Common.CURRENCY[currency]) + String.valueOf(bp.getSupply());
                        } else if(name.equals("list"))
                        {
                            value = r.getString(h.language,Common.CURRENCY[currency]) + String.valueOf(bp.getList());
                        } else if(name.equals("ourPrice"))
                        {
                            value = r.getString(h.language,Common.CURRENCY[currency]) + String.valueOf(bp.getPrice());
                        } else if(name.equals("getPrice1")) // 1级代理
                        {
                            if(rv != null && Profile.find(rv._strV).getAgent() == 1)
                            {
                                value = (String.valueOf(bp.getPrice1()));
                            } else
                            {
                                continue;
                            }

                        } else if(name.equals("getPrice2")) // 2级代理
                        {
                            if(rv != null)
                            {
                                int agent = Profile.find(rv._strV).getAgent();
                                if(agent > 0 && agent < 3)
                                {
                                    value = (String.valueOf(bp.getPrice2()));
                                } else
                                {
                                    continue;
                                }
                            } else
                            {
                                continue;
                            }
                        } else if(name.equals("getPrice3")) // 2级代理
                        {
                            if(rv != null)
                            {
                                int agent = Profile.find(rv._strV).getAgent();
                                if(agent > 0 && agent < 4)
                                {
                                    value = (String.valueOf(bp.getPrice3()));
                                } else
                                {
                                    continue;
                                }
                            } else
                            {
                                continue;
                            }
                        } else if(name.equals("point"))
                        {
                            value = (String.valueOf(bp.getPoint()));
                        } else if(name.equals("convertCurrency"))
                        {
                            value = String.valueOf(bp.getConvertCurrency());
                        } else
                        {
                            continue;
                        }
                        if(detail.getAnchor(name) != 0)
                        {
                            Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/goods/" + _nNode + "-" + h.language + ".htm",value);
                            anchor.setTarget(target);
                            anchor.setId("GoodsIDA" + name);
                            span = new Span(anchor);
                        } else
                        {
                            span = new Span(value);
                        }
                        span.setId("GoodsID" + name);
                        sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
                    }
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return sb.toString();
    }

    public int getCompany()
    {
        return company;
    }

    public int getHits()
    {
        return hits;
    }

    public String getNo()
    {
        return no;
    }

    public boolean isDType()
    {
        return dtype;
    }

    public float getDeduct()
    {
        return deduct;
    }

    public int getUsed()
    {
        return used;
    }

    public String getBarcode()
    {
        return barcode;
    }

}
