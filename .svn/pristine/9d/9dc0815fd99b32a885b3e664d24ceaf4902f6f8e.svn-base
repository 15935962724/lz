package tea.entity.node;

import java.math.*;
import java.sql.*;
import java.util.Date;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.bpicture.*;
import tea.html.*;

//40
public class Picture extends Entity
{
    private static Cache _cache = new Cache(100);
    private int _nNode;
    private String _nName;
    private String _nAuthor;
    private Date _nDate;
    private int _nClass;
    private String _nAddress;
    private String _nNote;
    private String _nsave;
    private String _nCode;
    private int width;
    private int height;
    /***
     * 2008年11月11日14:20:56 唐嗣达
     * 2008年11月18日12:29:44唐嗣达
     * 添加新的属性和字段
     * ***/
    private BigDecimal price; //图片的价格
    private int pictype; //图片是不是参与买卖 0 不参与， 1  参与
    private String mainWords;
	public String copyright;//版权人

    public void set(int i,String s2,String s4,String s5,String s6,String s7,Date time,String s8,int width,int height,BigDecimal price,int pictype,int times) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node   FROM Picture   WHERE node=" + i);
            if(db.next())
            {
                db.executeUpdate("UPDATE Picture SET author=" + DbAdapter.cite(s2) + ",time=" + DbAdapter.cite(time) + ",class=" + DbAdapter.cite(s4) + ",  address=" + DbAdapter.cite(s5) + ",   note=" + DbAdapter.cite(s6) + ",savepic=" + DbAdapter.cite(s7) + ",code=" + DbAdapter.cite(s8) + ",width=" + width + ",height=" + height + ",price=" + price + ",pictype=" + pictype + " WHERE node=" + i);
            } else
            {
                db.executeUpdate("INSERT INTO Picture (node,author,time,class,address,note,savepic,code,width,height,price,pictype)VALUES(" + i + "," + DbAdapter.cite(s2) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(s4) + "," + DbAdapter.cite(s5) + "," + DbAdapter.cite(s6) + "," + DbAdapter.cite(s7) + "," + DbAdapter.cite(s8) + "," + width + "," + height + "," + price + "," + pictype + ")");
                if(pictype == 1 || pictype == 2)
                {
                    String classific = "";
                    if(width > height)
                    {
                        classific = "/1/";
                    } else if(width < height)
                    {
                        classific = "/2/";
                    } else if(width == height)
                    {
                        classific = "/3/";
                    }
                    Node nodes = Node.find(i);
                    Baudit.set(0,i,"",nodes.getCommunity(),"",0,nodes.getTime(),0,null,0,times,0,0,nodes.getCreator().toString(),classific,0,0);

                } else
                {

                }
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(i));
    }


    public void setname(int i,String author,String classes,String address,String note,String savepic,Date time,String code,int width,int height,BigDecimal price,int pictype,int times,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Picture WHERE node=" + i);
            if(db.next())
            {
                db.executeUpdate(i,"UPDATE Picture SET author=" + DbAdapter.cite(author) + ",time=" + DbAdapter.cite(time) + ",class=" + DbAdapter.cite(classes) + ",  address=" + DbAdapter.cite(address) + ",   note=" + DbAdapter.cite(note) + ",savepic=" + DbAdapter.cite(savepic) + ",code=" + DbAdapter.cite(code) + ",width=" + width + ",height=" + height + ",price=" + price + ",pictype=" + pictype + " WHERE node=" + i);
            } else
            {
                db.executeUpdate(i,"INSERT INTO Picture(node,author,time,class,address,note,savepic,code,width,height,price,pictype,name)VALUES(" + i + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(classes) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(note) + "," + DbAdapter.cite(savepic) + "," + DbAdapter.cite(code) + "," + width + "," + height + "," + price + "," + pictype + "," + db.cite(name) + ")");

                if(pictype == 1 || pictype == 2)
                {
                    String classific = "";
                    if(width > height)
                    {
                        classific = "/1/";
                    } else if(width < height)
                    {
                        classific = "/2/";
                    } else if(width == height)
                    {
                        classific = "/3/";
                    }

                    Node nodes = Node.find(i);
                    Baudit.set(0,i,"",nodes.getCommunity(),"",0,nodes.getTime(),0,null,0,times,0,0,nodes.getCreator().toString(),classific,0,0);
                } else
                {

                }
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(i));
    }


    public Picture(int i) throws SQLException
    {
        _nNode = i;
        load(i);
    }

    private void load(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT author,time,class,address,note,savepic,code,width,height,price,pictype,name,mainwords FROM Picture WHERE node=" + _nNode);
            if(db.next())
            {
                _nAuthor = db.getVarchar(1,i,1);
                _nDate = db.getDate(2);
                _nClass = (db.getInt(3));
                _nAddress = db.getVarchar(1,i,4);
                _nNote = db.getText(1,i,5);
                _nsave = db.getVarchar(1,i,6);
                _nCode = db.getVarchar(1,i,7);
                width = db.getInt(8);
                height = db.getInt(9);
                price = db.getBigDecimal(10,2);
                pictype = db.getInt(11);
                _nName = db.getString(12);
                mainWords = db.getString(13);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(i));
    }

    public int getPictype(int i) throws SQLException
    {
        return pictype;
    }

    public String getCode(int i) throws SQLException
    {

        return _nCode;
    }

    public String getAuthor(int i) throws SQLException
    {

        return _nAuthor;
    }

    public Date getDate(int i) throws SQLException
    {

        return _nDate;
    }

    public String getDateToString(int i) throws SQLException
    {
        return sdf.format(_nDate);
    }

    public int getClass(int i) throws SQLException
    {
        return _nClass;
    }

    public String getAddress(int i) throws SQLException
    {

        return _nAddress;
    }

    public String getNote(int i) throws SQLException
    {

        return _nNote;
    }

    public String getSave(int i) throws SQLException
    {

        return _nsave;
    }

    public boolean fileexist(int i,String s) throws SQLException
    {
        int node = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Picture  WHERE name like '" + s + "'");
            if(db.next())
            {
                node = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        if(node == i || node == 0)
        {
            return false;
        } else
        {
            return true;
        }
    }

    public boolean fileexist(String s) throws SQLException
    {
        int node = 0;
        boolean r = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Picture  WHERE code like '" + s + "'");
            if(db.next())
            {
                r = true;
            }
        } finally
        {
            db.close();
        }
        return r;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Picture WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
    }

    public static Picture find(int i) throws SQLException
    {
        Picture Picture = (Picture) _cache.get(new Integer(i));
        if(Picture == null)
        {
            Picture = new Picture(i);
            _cache.put(new Integer(i),Picture);
        } else
        {
            Picture = new Picture(i);
            _cache.put(new Integer(i),Picture);
        }
        return Picture;
    }

    public String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        int _nNode = node._nNode;
        Span span = null;
        String subject = node.getSubject(h.language);
        String pic = "/res/" + node.getCommunity() + "/picture/" + _nNode + ".jpg";
        ListingDetail detail = ListingDetail.find(listing,40,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("index"))
            {
                value = String.valueOf(_nNode);
            } else if(name.equals("name"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("author"))
            {
                value = (this.getAuthor(h.language));
            } else if(name.equals("time"))
            {
                value = (this.getDateToString(h.language));
            } else if(name.equals("text"))
            {
                value = (node.getText2(h.language));
            } else if(name.equals("address"))
            {
                value = (this.getAddress(h.language));
            } else if(name.equals("classes"))
            {
                if(this.getClass(h.language) != 0)
                {
                    Classes classes = new Classes(this.getClass(h.language));
                    value = (classes.getName());
                } else
                {
                    value = (null);
                }
            } else if(name.equals("savepic"))
            {
                value = (this.getSave(h.language));
            } else if(name.equals("picture"))
            {
                tea.html.Image img = new tea.html.Image(pic);
                img.setAlt(subject);
                value = (img.toString());
            } else if(name.equals("small"))
            {
                StringBuffer strs = new StringBuffer();
                if(node.getCommunity().equals("bigpic"))
                {
                    value = "<a href='/jsp/bpicture/ImageInfo.jsp?nodes=" + _nNode + "'>" + (new tea.html.Image("/res/" + node.getCommunity() + "/picture/small/" + _nNode + ".jpg").toString()) + "</a>";
                } else
                {
                    value = (new tea.html.Image("/res/" + node.getCommunity() + "/picture/small/" + _nNode + ".jpg").toString());
                }

            } else if(name.equals("note"))
            {
                value = (this.getNote(h.language));
            } else if(name.equals("size"))
            {
                if(width > 0 && height > 0)
                {
                    value = width + " X " + height;
                }
            } else if(name.equals("price"))
            {
                StringBuffer strs = new StringBuffer();

                if(node.getCommunity().equals("bigpic"))
                {
                    strs.append(" <a href='/jsp/bpicture/buyer/AddShopping.jsp?act=add&node=" + node._nNode + "&nexturl=/servlet/Node?node=2198116');'>放入购物车</a>");
                    strs.append(" <a href=\"/jsp/bpicture/buyer/CalPrice.jsp?nodes=" + node._nNode + "\">价格计算</a>");
                    strs.append(" <a href=# id=" + node._nNode + " onclick='c_jax(" + node._nNode + ");'>加入收藏</a>");
                }
                value = (this.getPrice(h.language).toString()) + strs.toString();
            }

            switch(detail.getAnchor(name))
            {
            case 1:
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/picture/" + _nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
                break;
            case 2:
                Anchor anchor2 = new Anchor("###",value);

                //anchor2.setOnClick("window.open('" + pic + "','','width=" + (width + 20) + "px,height=" + (height + 27) + "px');");
                anchor2.setOnClick("mt.img('" + pic + "')");
                span = new Span(anchor2);
                break;
            default:
                span = new Span(value);
            }
            span.setId("PictureID" + name);
            htm.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return htm.toString();
    }

    public int getWidth(int i)
    {
        return width;
    }

    public int getHeight(int i)
    {
        return height;
    }

    public BigDecimal getPrice(int i) throws SQLException
    {
        return price;
    }

    public String get_nName()
    {
        return _nName;
    }

    public String getMainWords()
    {
        return mainWords;
    }

    public static void setPrice(int node,BigDecimal price) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" UPdate picture set price =" + price + " where node =" + node);
        } finally
        {
            db.close();
        }
    }

    public static void setMainWords(int node,String mainWords) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" UPdate picture set mainwords =" + db.cite(mainWords) + " where node =" + node);
        } finally
        {
            db.close();
        }

    }

}
