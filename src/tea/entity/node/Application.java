package tea.entity.node;

import java.util.Date;
import tea.db.DbAdapter;
import tea.ui.*;
import tea.entity.*;
import java.util.Vector;
import tea.html.Text;
import java.text.SimpleDateFormat;
import tea.html.Anchor;
import tea.html.Button;
import tea.html.Cell;
import tea.html.DropDown1;
import tea.html.Form;
import tea.html.JavaScript;
import tea.html.Row;
import tea.html.Span;
import tea.html.Image;
import tea.html.Table;
import tea.ui.TeaSession;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

public class Application extends Entity
{
    private int _nNode;
    private String xm;
    private String xmpy;
    private Date csny;
    private String xl;
    private String xw;
    private String zw;
    private Date cjgzsj;
    private String xdw;
    private String xbw;
    private String xgw;
    private String phone;
    private String mobile;
    private String email;

    private Date cqrq;

    private static Cache _cache = new Cache(100);

    public void set(int i,String s1,String s2,Date date1,String s3,String s4,String s5,Date date2,String s6,String s7,String s8,String s9,String s10,String s11) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("AppEdit " + i + ", " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + DbAdapter.cite(date1) + ", " + DbAdapter.cite(s3) + ", " + DbAdapter.cite(s4) + ", " + DbAdapter.cite(s5) + ", " + DbAdapter.cite(date2) + ", " + DbAdapter.cite(s6) + ", " + DbAdapter.cite(s7) + ", " + DbAdapter.cite(s8) + ", " + DbAdapter.cite(s9) + ", " + DbAdapter.cite(s10) +
            // ", " + DbAdapter.cite(s11));
            db.executeUpdate("INSERT INTO Application(node,xm,xb,csny,xl,xw,zw,cjgzsj,xdw,xbm,xgw,phone,mobile,email)  VALUES (" + i + "," + DbAdapter.cite(s1) + "," + DbAdapter.cite(s2) + "," + DbAdapter.cite(date1) + "," + DbAdapter.cite(s3) + "," + DbAdapter.cite(s4) + "," + DbAdapter.cite(s5) + "," + DbAdapter.cite(date2) + "," + DbAdapter.cite(s6) + "," + DbAdapter.cite(s7) + "," + DbAdapter.cite(s8) + "," + DbAdapter.cite(s9) + "," + DbAdapter.cite(s10) + "," + DbAdapter.cite(s11) + ")");
        } finally
        {
            db.close();
        }
    }

    public Application(int i)
    {
        _nNode = i;
    }

    private void load(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT xm,xb,csny,xl,xw,zw,cjgzsj,xdw,xbm,xgw,phone,mobile,sqrq ,email FROM Application  WHERE node=" + _nNode);
            if(db.next())
            {
                xm = db.getVarchar(1,i,1);
                xmpy = db.getVarchar(1,i,2);
                csny = db.getDate(3);
                xl = db.getVarchar(1,i,4);
                ;
                xw = db.getVarchar(1,i,5);
                ;
                zw = db.getVarchar(1,i,6);
                cjgzsj = db.getDate(7);
                xdw = db.getVarchar(1,i,8);
                xbw = db.getVarchar(1,i,9);
                xgw = db.getVarchar(1,i,10);
                phone = db.getVarchar(1,i,11);
                mobile = db.getVarchar(1,i,12);
                cqrq = db.getDate(13);
                email = db.getString(14);
            }
        } finally
        {
            db.close();
        }
    }

    public String getxm(int i) throws SQLException
    {
        load(i);
        return xm;
    }

    public String getxb(int i) throws SQLException
    {
        load(i);
        return xmpy;
    }

    public Date getcsny(int i) throws SQLException
    {
        load(i);
        return csny;
    }

    public String getcsny(int i,String pattern) throws SQLException
    {
        load(i);
        if(csny == null)
        {
            return "";
        }
        return new java.text.SimpleDateFormat(pattern).format(csny);

    }

    public String getxl(int i) throws SQLException
    {
        load(i);
        return xl;
    }

    public String getxw(int i) throws SQLException
    {
        load(i);
        return xw;
    }

    public String getzw(int i) throws SQLException
    {
        load(i);
        return zw;
    }

    public Date getcjgzsj(int i) throws SQLException
    {
        load(i);
        return cjgzsj;
    }

    public String getcjgzsj(int i,String pattern) throws SQLException
    {
        load(i);
        if(cjgzsj == null)
        {
            return "";
        }
        return new java.text.SimpleDateFormat(pattern).format(cjgzsj);

    }

    public Date getcqrq(int i) throws SQLException
    {
        load(i);
        return cqrq;

    }

    public String getcqrq(int i,String pattern) throws SQLException
    {
        load(i);
        if(cqrq == null)
        {
            return "";
        }
        return new java.text.SimpleDateFormat(pattern).format(cqrq);

    }

    public String getxdw(int i) throws SQLException
    {
        load(i);
        return xdw;
    }

    public String getxbw(int i) throws SQLException
    {
        load(i);
        return xbw;
    }

    public String getxgw(int i) throws SQLException
    {
        load(i);
        return xgw;
    }

    public String getphone(int i) throws SQLException
    {
        load(i);
        return phone;
    }

    public String geteail(int i) throws SQLException
    {
        load(i);
        return email;
    }

    public String getmoile(int i) throws SQLException
    {
        load(i);
        return mobile;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Application WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
    }

    public static Application find(int i)
    {
        Application application = (Application) _cache.get(new Integer(i));
        if(application == null)
        {
            application = new Application(i);
            _cache.put(new Integer(i),application);
        }
        return application;
    }

    public static Vector find() throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node from Application");
            for(;db.next();vector.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return vector;
    }

    public static int count_s() throws SQLException
    {
        int c_s;
        DbAdapter db = new DbAdapter();
        try
        {
            c_s = db.getInt("SELECT count(node) from Application");
        } finally
        {
            db.close();
        }
        return c_s;
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        Application report = Application.find(node._nNode);
        Span span = null;
        ListingDetail detail = ListingDetail.find(listing,42,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("xm"))
            {
                value = (report.getxm(h.language));
            } else if(name.equals("xb"))
            {
                value = (report.getxb(h.language));
            } else if(name.equals("csny"))
            {
                value = (report.getcsny(h.language,"yyyy-MM-dd"));
            } else if(name.equals("xl"))
            {
                value = (report.getxl(h.language));
            } else if(name.equals("xw"))
            {
                value = (report.getxw(h.language));
            } else if(name.equals("zw"))
            {
                value = (report.getzw(h.language));
            } else if(name.equals("cjgzsj"))
            {
                value = (report.getcjgzsj(h.language,"yyyy-MM-dd"));
            } else if(name.equals("xdw"))
            {
                value = (report.getxdw(h.language));
            } else if(name.equals("xbm"))
            {
                value = (report.getxbw(h.language));
            } else if(name.equals("xgw"))
            {
                value = (report.getxgw(h.language));
            } else if(name.equals("phone"))
            {
                value = (report.getphone(h.language));
            } else if(name.equals("mobile"))
            {
                value = (report.getmoile(h.language));
            } else if(name.equals("sqrq"))
            {

                value = (report.getcqrq(h.language,"yyyy-MM-dd"));
            } else if(name.equals("email"))
            {
                value = (report.geteail(h.language));
            } else if(name.equals("file"))
            {
                value = (new Anchor("/tea/app/" + node._nNode + ".doc","文件").toString());
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/html/" + h.community + "/application/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("ApplicationID" + name);
            text.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
        }
        return text.toString();
    }

    public static Text getAppSearch(Http h,int i,tea.resource.Resource r) throws SQLException
    {
        Text text = new Text();
        Table table_h = new Table();
        table_h.setId("table_page");
        table_h.setWidth("80%");
        Row row_h = new Row();
        row_h.setId("row_page");
        Table table1 = new Table();
        table1.setId("stocktable");
        text.add(new JavaScript("function MM_jumpMenu(targ,selObj,restore){ eval(targ+\".location='\"+selObj.options[selObj.selectedIndex].value+\"'\");  if (restore) selObj.selectedIndex=0;}"));
        try
        {
            // TeaSession teasession = new TeaSession(request);
            HttpSession httpsession = h.request.getSession(); // request.getSession(true);
            Row row11 = new Row();
            row11.setId("head_table");
            row11.add(new Cell(r.getString(h.language,"xm"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"xb"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"csny"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"xl"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"xw"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"zw"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"cjgzsj"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"xdw"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"xbw"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"xgw"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"phone"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"mobile"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"email"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"sqrq"),"searchcellhead"));
            row11.add(new Cell(r.getString(h.language,"jianli"),"searchcellhead"));
            table1.add(row11);
            Vector v_stock = null;
            int c_stock = 0;
            if(h.get("Page") == null || httpsession.getAttribute("tea.stock" + i) == null)
            {
                v_stock = Application.find();
                c_stock = Application.count_s();
                httpsession.setAttribute("tea.app",v_stock);
                httpsession.setAttribute("tea.c_app",new Integer(c_stock));
            } else
            {
                c_stock = ((Integer) httpsession.getAttribute("tea.c_app")).intValue();
                v_stock = (Vector) httpsession.getAttribute("tea.app");
            }
            // Enumeration ggg=v_stock.elements();
            // int kkk=ddd.length();
            int Page = 0;
            if(h.get("Page") != null)
            {
                Page = Integer.parseInt(h.get("Page")) - 1;
            }
            Form form = new Form("foNew","POST","");
            DropDown1 dropdown = new DropDown1("media");
            for(int ii = 0;ii <= c_stock / 10 + 1;ii++)
            {
                dropdown.addOption("Node?node=" + h.node + "&AppSearch=1&Listing=" + i + "&Page=" + ii,String.valueOf(ii));
            }
            form.add(dropdown);
            row_h.add(new Cell(r.getString(h.language,"all") + "(" + c_stock + ")" + r.getString(h.language,"Records"),"searchcellhead"));
            row_h.add(new Cell(r.getString(h.language,"all") + "(" + c_stock / 10 + ")" + r.getString(h.language,"Pages"),"searchcellhead"));
            row_h.add(new Cell(r.getString(h.language,"The") + "(" + (Page == 0 ? 1 : Page) + ")" + r.getString(h.language,"Pages"),"searchcellhead"));
            row_h.add(new Cell(r.getString(h.language,"Turn&nbsp;to"),"searchcellhead"));
            Cell cellto = new Cell(form);
            cellto.setId("turnto");
            row_h.add(cellto);
            row_h.add(new Cell(r.getString(h.language,"page"),"searchcellhead"));
            table_h.add(row_h);
            text.add(table_h);
            for(int k3 = Page * 10;k3 < Page * 10 + 10;k3++)
            {
                int id = ((Integer) v_stock.elementAt(k3)).intValue();
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT xm,xb,csny,xl,xw,zw,cjgzsj,xdw,xbm,xgw,phone,mobile,email,sqrq FROM Application where node =" + id);
                    if(db.next())
                    {
                        Row row12 = new Row();
                        row12.add(new Cell(new Text((db.getVarchar(1,1,1))),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,2))),"searchcell"));
                        String date11 = ((new SimpleDateFormat("yyyy-MM-dd")).format(db.getDate(3)));
                        row12.add(new Cell(new Text(date11),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,4))),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,5))),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,6))),"searchcell"));
                        String date12 = ((new SimpleDateFormat("yyyy-MM-dd")).format(db.getDate(7)));
                        row12.add(new Cell(new Text(date12),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,8))),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,9))),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,10))),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,11))),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,12))),"searchcell"));
                        row12.add(new Cell(new Text((db.getVarchar(1,1,13))),"searchcell"));
                        String date13 = ((new SimpleDateFormat("yyyy-MM-dd")).format(db.getDate(14)));
                        row12.add(new Cell(new Text(date13),"searchcell"));
                        Cell cellj = new Cell();
                        cellj.add(new Button(1,"CB","CBEditNode",r.getString(1,"jianli"),"window.open('/tea/app/" + id + ".doc', '_blank');"));
                        row12.add(cellj);
                        table1.add(row12);
                    }
                } catch(Exception exception)
                {
                    exception.printStackTrace();
                } finally
                {
                    db.close();
                }
            }
        } catch(Exception exception)
        {
        }
        // text.add(new Text(stockid));
        text.add(table1);
        text.add(new Button(1,"CB","CBPlay",r.getString(1,"appout"),"window.open('/servlet/AppOut','_blank');"));
        text.add(table_h);
        return text;
    }
}
