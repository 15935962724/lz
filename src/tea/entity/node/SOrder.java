package tea.entity.node;

import java.math.*;
import java.util.*;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;

public class SOrder extends Entity
{
    public final static String ADDRESS[] =
            {"东四街道办事处","东华门街道貌岸然办事处","东直门街道办事处","北新桥街道办事处","安定门街道办事处","交道口街道办事处","和平里街道办事处","建国门街道办事处","景门街道办事处","朝阳门街道办事处","二龙路街道办事处","厂桥街道貌岸然办事处","月坛街道办事处"};
    public final static String CODE[] =
            {"A1","A2","A3","A4","A5","A6","A7","A8","A9","A10","B1","B2","B3"};
    public static final String TRADE_STATUS[] =
            {"NewOrder","CancelOrder","Confirmed","Finish","Incept"}; // 新订单,取消订单,准备发货,要求确认,确认,已经发货,要求退款,退款等待处理,不予退款,批准退款,等待处理
    /*
     * 0 NewOrder=新订单 1 CancelOrder=取消订单 2 Confirmed=确认 3 ApprovedShipped=已经发货
     */
    public static String INVOICE_TYPE[] =
            {"已付","未付","已付增值税发票"};
    public static String IDEA_TYPE[] =
            {"很好","好","一般","差","很差"}; // idea
    public static String PTYPE_TYPE[] =
            {"","易洁卡","现场支付"};
    private int node;
    private int language;
    private String address;
    private Date time;
    private int[] service;
    private int[] amount; //作业数量
    private BigDecimal price[]; //收费金额
    private int[] aservice;
    private int[] aamount;
    private BigDecimal aprice[];
    private int idea;
    private boolean exists;
    private static Cache _cache = new Cache(100);
    private BigDecimal total;
    private BigDecimal atotal;
    private String iD;
    private int status;
    private String waiter; // 作业员
    private String clientSign;
    private String waiterSign;
    private Date signTime;
    private String phone;
    private String feedback;
    private int exwaiter;
    private BigDecimal cash;
    private BigDecimal subtract;
    private int invoice;
    private int waiterFigure; // 业务员(只能有一个)
    private int area;
    private int ptype;
    private int aptype; // 附加项目支付方式
    private int point; // 积分

    public SOrder(int _nNode,int _nLanguage) throws SQLException
    {
        node = _nNode;
        language = _nLanguage;
        service = new int[5];
        amount = new int[5];
        price = new BigDecimal[5];
        aservice = new int[3];
        aamount = new int[3];
        aprice = new BigDecimal[3];
        total = new java.math.BigDecimal("0");
        atotal = new java.math.BigDecimal("0");
        loadBasic();
    }

    public static int count(RV rv,int status) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(DISTINCT (Node.node)) FROM Node,SOrder WHERE Node.node=SOrder.node AND rcreator=" + DbAdapter.cite(rv._strR) + " AND vcreator=" + DbAdapter.cite(rv._strV) + " AND SOrder.status=" + status);
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    public static int count(String member,int status) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(DISTINCT (Node.node)) FROM Node,SOrder,AdminUsrRole WHERE Node.node=SOrder.node AND AdminUsrRole.member=" + DbAdapter.cite(member) + " AND AdminUsrRole.[zone] like '%/'+CONVERT(varchar(10), SOrder.address)+'/%' AND SOrder.status=" + status);
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration find(String community,String member,int status) throws SQLException
    {
        /*
         * System.out.println("SELECT DISTINCT (Node.node) FROM Node,SOrder,Conductor,AdminZone WHERE Node.finished=1 AND Node.community=" + DbAdapter.cite(community) + " AND Node.type=66 AND Node.node=SOrder.node AND SOrder.status=" + status + " AND ((Conductor.member=" + DbAdapter.cite(member) + " AND Conductor.[zone] LIKE '%/'+CAST(AdminZone.id AS VARCHAR(127))+'/%' AND AdminZone.area LIKE '%/'+CAST(SOrder.area AS VARCHAR(127))+'/%') OR Node.rcreator=" + DbAdapter.cite(member) + ")" );
         */
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT (Node.node) FROM Node,SOrder,Conductor,AdminZone WHERE Node.finished=1 AND Node.community=" + DbAdapter.cite(community) + " AND Node.type=66 AND Node.node=SOrder.node AND SOrder.status=" + status + " AND ((Conductor.member=" + DbAdapter.cite(member) + " AND Conductor.[zone] LIKE '%/'+CAST(AdminZone.id AS VARCHAR(127))+'/%' AND AdminZone.area LIKE '%/'+CAST(SOrder.area AS VARCHAR(127))+'/%') OR Node.rcreator=" + DbAdapter.cite(member) + ")"); // ("SELECT
            // DISTINCT
            // (Node.node)
            // FROM
            // Node,SOrder,Waiter
            // WHERE
            // Node.node=SOrder.node
            // AND
            // AdminUsrRole.member="
            // +
            // DbAdapter.cite(member)
            // + "
            // AND
            // AdminUsrRole.[zone]
            // like
            // '%/'+CONVERT(varchar(10), SOrder.address)+'/%' AND SOrder.status=" + status);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration find(RV rv,int status,int pos,int pagesize) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT (Node.node) FROM Node,SOrder WHERE Node.node=SOrder.node AND rcreator=" + DbAdapter.cite(rv._strR) + " AND vcreator=" + DbAdapter.cite(rv._strV) + " AND SOrder.status=" + status);
            for(int i1 = 0;i1 < pos + pagesize && db.next();i1++)
            {
                if(i1 >= pos)
                {
                    vector.addElement(new Integer(db.getInt(1)));
                }
            }
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int count(java.util.Date start,java.util.Date end) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT (Node.node)) FROM Node,SOrder WHERE Node.node=SOrder.node ");
            if(start != null)
            {
                sql.append(" AND SOrder.signtime>=" + DbAdapter.cite(start));
            }
            if(end != null)
            {
                sql.append(" AND SOrder.signtime<" + DbAdapter.cite(end));
            }
            sql.append(" GROUP BY node.rcreator");
            return db.getInt(sql.toString());
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    /*
     * public static int count(String member,java.util.Date from ,java.util.Date to) { DbAdapter db = new DbAdapter(); try { //return db.getInt("SELECT Node.rcreator FROM Waiter WHERE Waiter.node " + this.node + " and language=" + this.language); } catch (SQLException ex) { ex.printStackTrace(); } finally { db.close(); } return 0; }
     */
    public static java.math.BigDecimal getReckon(int waiter,java.util.Date start,java.util.Date end) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        java.math.BigDecimal rechon = new BigDecimal(0d);
        StringBuilder sql = new StringBuilder("SELECT DISTINCT (Node.node),SOrder.language FROM Node,SOrder WHERE Node.node=SOrder.node AND SOrder.status=3 AND SOrder.waiter=" + waiter);
        if(start != null)
        {
            sql.append(" AND SOrder.signtime>=" + DbAdapter.cite(start));
        }
        if(end != null)
        {
            sql.append(" AND SOrder.signtime<" + DbAdapter.cite(end));
        }
        try
        {
            db.executeQuery(sql.toString());
            while(db.next())
            {
                rechon = rechon.add(tea.entity.node.SOrder.find(db.getInt(1),db.getInt(2)).getTotal());
            }
            return rechon;
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
    }

    public static void create(int node,int language,String address,Date time,int[] service,int[] amount,int[] aservice,int[] aamount,int idea,int status,String waiter,String clientSign,java.util.Date signTime,String waiterSign,String phone,String feedback,int exwaiter,int area) throws SQLException
    {
        StringBuilder sql = new StringBuilder("INSERT INTO SOrder (node,language,address,time,service1,amount1,service2,amount2,service3,amount3,service4,amount4,service5,amount5,aservice1,aamount1,aservice2,aamount2,aservice3,aamount3,idea,status,waiter,clientsign,signtime,waitersign,phone,feedback,exwaiter,area)VALUES(");
        sql.append(node).append(",");
        sql.append(language).append(",");
        sql.append(DbAdapter.cite(address)).append(",");
        sql.append(DbAdapter.cite(time)).append(",");
        for(int index = 0;index < service.length;index++)
        {
            sql.append(service[index] + "," + amount[index] + ",");
        }
        for(int index = 0;index < aservice.length;index++)
        {
            sql.append(aservice[index] + "," + aamount[index] + ",");
        }
        sql.append(idea).append(",");
        sql.append(status).append(",");
        sql.append(DbAdapter.cite(waiter)).append(",");
        sql.append(DbAdapter.cite(clientSign)).append(",");
        sql.append(DbAdapter.cite(signTime)).append(",");
        sql.append(DbAdapter.cite(waiterSign)).append(",");
        sql.append(DbAdapter.cite(phone)).append(",");
        sql.append(DbAdapter.cite(feedback)).append(",");
        sql.append(exwaiter).append(",");
        sql.append(area).append(")");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
    }

    public void set(String address,Date time,int[] service,int[] amount,int[] aservice,int[] aamount,int idea,int status,String waiter,String clientSign,java.util.Date signTime,String waiterSign,String phone,String feedback,int exwaiter,int invoice,int waiterFigure,int area) throws SQLException
    {
        // cash// 支付的现金 (此参数,现在没有用了)
        // subtract// 从易洁卡,扣除的余额 (此参数,现在没有用了)
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE SOrder SET address=").append(DbAdapter.cite(address)).append(",time=").append(DbAdapter.cite(time));
        for(int index = 0;index < service.length;index++)
        {
            sql.append(",service").append(index + 1).append("=").append(service[index]).append(",amount").append(index + 1).append("=").append(amount[index]);
        }
        for(int index = 0;index < aservice.length;index++)
        {
            sql.append(",aservice").append(index + 1).append("=").append(aservice[index]).append(",aamount").append(index + 1).append("=").append(aamount[index]);
        }
        sql.append(",idea=").append(idea);
        sql.append(",status=").append(status);
        sql.append(",waiter=").append(DbAdapter.cite(waiter));
        sql.append(",clientsign=").append(DbAdapter.cite(clientSign));
        sql.append(",signtime=").append(DbAdapter.cite(signTime));
        sql.append(",waitersign=").append(DbAdapter.cite(waiterSign));
        sql.append(",phone=").append(DbAdapter.cite(phone));
        sql.append(",feedback=").append(DbAdapter.cite(feedback));
        sql.append(",exwaiter=").append((exwaiter));
        sql.append(",cash=").append(cash);
        sql.append(",subtract=").append(subtract);
        sql.append(",invoice=").append(invoice);
        sql.append(",waiterfigure=").append(waiterFigure);
        sql.append(",area=").append(area);
        sql.append(" WHERE node=").append(node).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public boolean isExists() throws SQLException
    {
        return exists;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT address,time,service1,service2,service3,service4,service5,amount1,amount2,amount3,amount4,amount5,aservice1,aservice2,aservice3,aamount1,aamount2,aamount3,waiter,clientsign,waitersign,signtime,idea,phone,feedback,exwaiter,status,cash,subtract,invoice,waiterfigure,area,ptype,aptype FROM SOrder  WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                address = db.getVarchar(language,language,1);
                time = db.getDate(2);
                service[0] = db.getInt(3 + 0);
                service[1] = db.getInt(3 + 1);
                service[2] = db.getInt(3 + 2);
                service[3] = db.getInt(3 + 3);
                service[4] = db.getInt(3 + 4);
                amount[0] = db.getInt(3 + 5 + 0);
                amount[1] = db.getInt(3 + 5 + 1);
                amount[2] = db.getInt(3 + 5 + 2);
                amount[3] = db.getInt(3 + 5 + 3);
                amount[4] = db.getInt(3 + 5 + 4);
                for(int i = 0;i < 5;i++)
                {
                    Service s = Service.find(service[i],language);
                    if(s.isExists())
                    {
                        price[i] = s.getPrice().multiply(new BigDecimal(amount[i]));
                        total = total.add(price[i]);
                        point += s.getPoint() * amount[i];
                    }
                }
                aservice[0] = db.getInt(13 + 0);
                aservice[1] = db.getInt(13 + 1);
                aservice[2] = db.getInt(13 + 2);
                aamount[0] = db.getInt(13 + 3 + 0);
                aamount[1] = db.getInt(13 + 3 + 1);
                aamount[2] = db.getInt(13 + 3 + 2);
                for(int i = 0;i < 3;i++)
                {
                    Service s = Service.find(aservice[i],language);
                    if(s.isExists())
                    {
                        aprice[i] = s.getPrice().multiply(new BigDecimal(aamount[i]));
                        atotal = atotal.add(aprice[i]);
                        point += s.getPoint() * aamount[i];
                    }
                }
                waiter = db.getVarchar(1,1,19);
                clientSign = db.getVarchar(1,1,20);
                waiterSign = db.getVarchar(1,1,21);
                signTime = db.getDate(22);
                idea = db.getInt(23);
                phone = db.getString(24);
                feedback = db.getVarchar(1,1,25);
                exwaiter = db.getInt(26);
                this.status = db.getInt(27);
                cash = db.getBigDecimal(28,2);
                subtract = db.getBigDecimal(29,2);
                invoice = db.getInt(30);
                waiterFigure = db.getInt(31);
                area = db.getInt(32);
                ptype = db.getInt(33);
                aptype = db.getInt(34);
                // iD = CODE[address] + node;
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

    public static SOrder find(int _nNode,int _nLanguage) throws SQLException
    {
        SOrder objSOrder = (SOrder) _cache.get(_nNode + ":" + _nLanguage);
        if(objSOrder == null)
        {
            objSOrder = new SOrder(_nNode,_nLanguage);
            if(objSOrder.isExists())
            {
                _cache.put(_nNode + ":" + _nLanguage,objSOrder);
            }
        }
        return objSOrder;
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();

        SOrder obj = SOrder.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,66,h.language);
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
                value = String.valueOf(obj.getNode());
            } else if(itemname.equals("Subject"))
            {
                value = (node.getSubject(h.language));
            } else if(itemname.equals("phone"))
            {
                value = (tea.entity.member.Profile.find(node.getCreator()._strR).getTelephone(h.language));
            } else if(itemname.equals("area"))
            {
                value = (tea.entity.admin.Area.find(obj.getArea()).getName());
            } else if(itemname.equals("address"))
            {
                value = (obj.getAddress());
            } else if(itemname.equals("bespeak"))
            {
                value = (obj.getTime("yyyy-MM-dd hh:mm"));
            } else if(itemname.equals("total"))
            {
                value = (obj.getTotal().toString());
            } else if(itemname.equals("service"))
            {
                value = ("<include src=\"/jsp/type/sorder/ListingDetail_service.jsp?node=" + node._nNode + "\"/>");
            } else if(itemname.equals("exwaiter"))
            {
                if(obj.getExwaiter() == 0)
                {
                    value = ("");
                } else
                {
                    value = String.valueOf(obj.getExwaiter());
                }
            } else if(itemname.equals("idea"))
            {
                value = (IDEA_TYPE[obj.getIdea()]);
            } else if(itemname.equals("feedback"))
            {
                value = (obj.getFeedback());
            } else if(itemname.equals("signtime"))
            {
                if(obj.getSignTime() != null)
                {
                    value = (new java.text.SimpleDateFormat("yyyy-MM-dd").format(obj.getSignTime()));
                } else
                {
                    value = ("");
                }
            }
            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/sorder/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("SOrderID" + itemname);
            sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
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

    public void setAddress(String address)
    {
        this.address = address;
    }

    public void setTime(Date time)
    {
        this.time = time;
    }

    public void setSOrder(int[] service)
    {
        this.service = service;
    }

    public void setAmount(int[] amount)
    {
        this.amount = amount;
    }

    public void setAservice(int[] aservice)
    {
        this.aservice = aservice;
    }

    public void setAamount(int[] aamount)
    {
        this.aamount = aamount;
    }

    public void setIdea(int idea)
    {
        this.idea = idea;
    }

    public void setStatus(int status) throws SQLException
    {
        this.status = status;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SOrder SET status=" + status + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
    }

    public void setPtype(int ptype) throws SQLException
    {
        this.ptype = ptype;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SOrder SET ptype=" + ptype + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
    }

    public void setAptype(int aptype) throws SQLException
    {
        this.aptype = aptype;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SOrder SET aptype=" + aptype + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
    }

    public String getAddress()
    {
        return address;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTime(String pattern)
    {
        if(time == null)
        {
            return "";
        } else
        {
            return new java.text.SimpleDateFormat(pattern).format(time);
        }
    }

    public int[] getService()
    {
        return service;
    }

    public int[] getAmount()
    {
        return amount;
    }

    public BigDecimal[] getPrice()
    {
        return price;
    }

    public int[] getAservice()
    {
        return aservice;
    }

    public int[] getAamount()
    {
        return aamount;
    }

    public BigDecimal[] getAPrice()
    {
        return price;
    }

    public int getIdea()
    {
        return idea;
    }

    public BigDecimal getTotal()
    {
        return total;
    }

    public BigDecimal getAtotal()
    {
        return atotal;
    }

    public String getID()
    {
        return iD;
    }

    public int getStatus()
    {
        return status;
    }

    public String getWaiter()
    {
        return waiter;
    }

    public String getClientSign()
    {
        return clientSign;
    }

    public String getWaiterSign()
    {
        return waiterSign;
    }

    public Date getSignTime()
    {
        return signTime;
    }

    public String getPhone()
    {
        return phone;
    }

    public String getFeedback()
    {
        return feedback;
    }

    public int getExwaiter()
    {
        return exwaiter;
    }

    public BigDecimal getCash()
    {
        return cash;
    }

    public BigDecimal getSubtract()
    {
        return subtract;
    }

    public int getInvoice()
    {
        return invoice;
    }

    public int getWaiterFigure()
    {
        return waiterFigure;
    }

    public int getArea()
    {
        return area;
    }

    public int getPtype()
    {
        return ptype;
    }

    public int getAptype()
    {
        return aptype;
    }

    public int getPoint()
    {
        return point;
    }
}
