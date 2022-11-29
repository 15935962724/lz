package tea.entity.node;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.node.ListingDetail;
import tea.entity.node.Node;
import tea.html.Text;
import tea.html.Anchor;
import tea.html.Span;
import java.util.*;
import java.sql.SQLException;

public class Book extends Entity
{
    public static final String BOOK_FORMAT[] =
            {"BookFormat0","BookFormat1","BookFormat2","BookFormat3","BookFormat4","BookFormat5","BookFormat6","BookFormat7","BookFormat8","BookFormat9","BookFormat10","BookFormat11","BookFormat12","BookFormat13","BookFormat14","BookFormat15","BookFormat16","BookFormat17"};
    public static final String BOOK_BINDING[] =
            {"BookBinding0","BookBinding1","BookBinding2","BookBinding3"};
    public static final String BOOK_SFC[] =
    	    {"1/16","1/32","16开","32开","A5","B5","大32开"};//格式
    private static Cache _cache = new Cache(100);
    private int _nNode;
    private String _strISBN;
    private int _nFormat;
    private int _nAmountWord;
    private int _nAmountPage;
    private int _nBinding;
    private BigDecimal _bdPrice;
    private Date _publishDate;
    private int _nReprint;
    private boolean exists;
    private boolean _blLoaded;
    private Date indate;
    private Date date2;
    private int inventory;
    private BigDecimal weight;
    private int num;
    private int type;
    private int docnode;//阅读文档
    private int specifications;//格式
    private Hashtable _htLayer;//indate,num,type,date2
    
    class Layer
    {
        public String _strSubTitle;
        public String _strPublisher;
        public String edition;
        public int transfer;
        public String authorMsg;
        public String chapterMsg;
        public String _strCIPI;
        public String _strCIPII;
        public String _strCIPIII;
        public String _strCIPIV;
        public String _strReader;
        public String _strCollection;
        public String _strAnnotation;
        public String smallpicture;
        public String bigpicture;
        public String keyword;//关键字
        Layer()
        {
        }
    }

    public String getEdition(int i) throws SQLException
    {
        return getLayer(i).edition;
    }

    public int getTransfer(int i) throws SQLException
    {
        return getLayer(i).transfer;
    }
    public String getAuthorMsg(int i) throws SQLException
    {
        return getLayer(i).authorMsg;
    }

    public String getChapterMsg(int i) throws SQLException
    {
        return getLayer(i).chapterMsg;
    }
    public String getCollection(int i) throws SQLException
    {
        return getLayer(i)._strCollection;
    }

    public String getSmallPicture(int i) throws SQLException
    {
        return getLayer(i).smallpicture;
    }

    public String getBigPicture(int i) throws SQLException
    {
        return getLayer(i).bigpicture;
    }
    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nNode,"UPDATE book SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        _cache.remove(_nNode);
    }

    public void set(String isbn,int format,int amountword,int amountpage,int binding,BigDecimal price,Date publishdate,int reprint,int language,String subtitle,String publisher,String cipi,String cipii,String cipiii,String cipiv,String reader,String collection,String annotation,String smallpicture,String bigpicture,int inventory,BigDecimal weight,int num,int type,int specifications,String keyword,int docnode,String edition,int transfer,String authorMsg,String chapterMsg) throws SQLException
    {
        StringBuilder s2 = new StringBuilder();
        s2.append("UPDATE BookLayer SET subtitle=").append(DbAdapter.cite(subtitle));
        s2.append(",publisher=").append(DbAdapter.cite(publisher));
        s2.append(",cipi=").append(DbAdapter.cite(cipi));
        s2.append(",cipii=").append(DbAdapter.cite(cipii));
        s2.append(",cipiii=").append(DbAdapter.cite(cipiii));
        s2.append(",cipiv=").append(DbAdapter.cite(cipiv));
        s2.append(",reader=").append(DbAdapter.cite(reader));
        s2.append(",collection=").append(DbAdapter.cite(collection));
        s2.append(",annotation=").append(DbAdapter.cite(annotation));
        s2.append(",edition=").append(DbAdapter.cite(edition));
        s2.append(",transfer=").append(transfer);
        s2.append(",authorMsg=").append(DbAdapter.cite(authorMsg));
        s2.append(",chapterMsg=").append(DbAdapter.cite(chapterMsg));
        
        if(smallpicture != null)
        {
            s2.append(",smallpicture=").append(DbAdapter.cite(smallpicture));
        }
        if(bigpicture != null)
        {
            s2.append(",bigpicture=").append(DbAdapter.cite(bigpicture));
        }
        s2.append(",keyword=").append(DbAdapter.cite(keyword));
        s2.append(" WHERE node=").append(_nNode).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Book SET isbn=" + DbAdapter.cite(isbn) + ",format=" + format + ",amountword=" + amountword + ",amountpage=" + amountpage + ",binding=" + binding + ",price=" + price + ",publishdate=" + DbAdapter.cite(publishdate) + ",reprint=" + reprint +",inventory=" + inventory +",weight=" + weight +",num=" + num +",type=" + type +",specifications=" + specifications + ",docnode=" + docnode +" WHERE node=" + _nNode);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Book (node, isbn, format, amountword, amountpage, binding, price, publishdate, reprint,inventory,weight,num,type,specifications,docnode)VALUES(" + _nNode + ", " + DbAdapter.cite(isbn) + ", " + format + ", " + amountword + ", " + amountpage + ", " + binding + ", " + price + ", " + DbAdapter.cite(publishdate) + ", " + reprint + ", "+ inventory+ ", "+weight+ ", "+num+ ", "+type+ ", "+specifications+", "+docnode+")");
            }
            db.executeQuery("SELECT node FROM BookLayer WHERE node=" + _nNode + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate(s2.toString());
            } else
            {
                db.executeUpdate("INSERT INTO BookLayer (node, language, subtitle, publisher, cipi, cipii, cipiii, cipiv, reader, collection, annotation,smallpicture,bigpicture,keyword,edition,transfer,authorMsg,chapterMsg)VALUES (" + _nNode + ", " + language + ", " + DbAdapter.cite(subtitle) + ", " + DbAdapter.cite(publisher) + ", " + DbAdapter.cite(cipi) + ", " + DbAdapter.cite(cipii) + ", " + DbAdapter.cite(cipiii) + ", " + DbAdapter.cite(cipiv) + ", " + DbAdapter.cite(reader) + ", " + DbAdapter.cite(collection) + ", "
                                 + DbAdapter.cite(annotation) + "," + DbAdapter.cite(smallpicture) + "," + DbAdapter.cite(bigpicture) + ", " + DbAdapter.cite(keyword)+ ", " + DbAdapter.cite(edition)+ ", " +transfer+ ", " + DbAdapter.cite(authorMsg)+ ", " + DbAdapter.cite(chapterMsg) +")");
            }
        } finally
        {
            db.close();
        }
        _strISBN = isbn;
        _nFormat = format;
        _nAmountWord = amountword;
        _nAmountPage = amountpage;
        _nBinding = binding;
        _bdPrice = price;
        _publishDate = publishdate;
        _nReprint = reprint;
        this.inventory=inventory;
        this.weight=weight;
        this.num=num;
        this.type=type;
        this.specifications=specifications;
        _htLayer.clear();
    }

    public Date getPublishDate() throws SQLException
    {
        load();
        return _publishDate;
    }

    private Book(int i)
    {
        _nNode = i;
        _blLoaded = false;
        _htLayer = new Hashtable();
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node  FROM BookLayer  WHERE node=" + _nNode + " AND language=" + i);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public int getFormat() throws SQLException
    {
        load();
        return _nFormat;
    }

    public int getAmountWord() throws SQLException
    {
        load();
        return _nAmountWord;
    }

    public String getCIPIV(int i) throws SQLException
    {
        return getLayer(i)._strCIPIV;
    }

    public String getISBN() throws SQLException
    {
        load();
        return _strISBN;
    }

    public String getReader(int i) throws SQLException
    {
        return getLayer(i)._strReader;
    }

    public BigDecimal getPrice() throws SQLException
    {
        load();
        return _bdPrice;
    }
    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT b.node FROM Book b" + tab(sql) + " WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }
    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND bl."))
            sb.append(" INNER JOIN NodeLayer bl ON bl.node=b.node");
        if(sql.contains(" AND bc."))
            sb.append(" INNER JOIN BookCategory bc ON bc.node=b.node");
        return sb.toString();
    }
    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT isbn, format, amountword, amountpage, binding, price, publishdate, reprint,indate,num,type,date2,inventory,weight,docnode  FROM Book WHERE node=" + _nNode);
                if(db.next())
                {
                    _strISBN = db.getString(1);
                    _nFormat = db.getInt(2);
                    _nAmountWord = db.getInt(3);
                    _nAmountPage = db.getInt(4);
                    _nBinding = db.getInt(5);
                    _bdPrice = db.getBigDecimal(6,2);
                    _publishDate = db.getDate(7);
                    _nReprint = db.getInt(8);
                    indate=db.getDate(9);
                    num=db.getInt(10);
                    type=db.getInt(11);
                    date2=db.getDate(12);
                    inventory=db.getInt(13);
                    weight=db.getBigDecimal(14, 2);
                    docnode=db.getInt(15);
                    exists = true;
                } else
                {
                    exists = false;
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public int getAmountPage() throws SQLException
    {
        load();
        return _nAmountPage;
    }

    public int getReprint() throws SQLException
    {
        load();
        return _nReprint;
    }

    public String getCIPIII(int i) throws SQLException
    {
        return getLayer(i)._strCIPIII;
    }

    public boolean isExists() throws SQLException
    {
        load();
        return exists;
    }
    public int getDocnode()throws SQLException {
    	load();
		return docnode;
	}

    public int getBinding() throws SQLException
    {
        load();
        return _nBinding;
    }

    public String getCIPII(int i) throws SQLException
    {
        return getLayer(i)._strCIPII;
    }

    public String getCIPI(int i) throws SQLException
    {
        return getLayer(i)._strCIPI;
    }

    public String getPublisher(int i) throws SQLException
    {
        return getLayer(i)._strPublisher;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = Node.getLanguage(_nNode,i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT subtitle, publisher, cipi, cipii, cipiii, cipiv,  reader, collection, annotation,smallpicture,bigpicture,keyword,edition,transfer,authorMsg,chapterMsg  FROM BookLayer  WHERE node=" + _nNode + " AND language=" + j);
                if(db.next())
                {
                    layer._strSubTitle = db.getVarchar(j,i,1);
                    layer._strPublisher = db.getVarchar(j,i,2);
                    layer._strCIPI = db.getVarchar(j,i,3);
                    layer._strCIPII = db.getVarchar(j,i,4);
                    layer._strCIPIII = db.getVarchar(j,i,5);
                    layer._strCIPIV = db.getVarchar(j,i,6);
                    layer._strReader = db.getVarchar(j,i,7);
                    layer._strCollection = db.getVarchar(j,i,8);
                    layer._strAnnotation = db.getVarchar(j,i,9);
                    layer.smallpicture = db.getString(10);
                    layer.bigpicture = db.getString(11);
                    layer.keyword=db.getString(12);
                    layer.edition = db.getString(13);
                    layer.transfer=db.getInt(14);
                    layer.authorMsg=db.getString(15);
                    layer.chapterMsg = db.getString(16);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }


    public static Book find(int i)
    {
        Book book = (Book) _cache.get(new Integer(i));
        if(book == null)
        {
            book = new Book(i);
            _cache.put(new Integer(i),book);
        }
        return book;
    }

    public String getSubTitle(int i) throws SQLException
    {
        return getLayer(i)._strSubTitle;
    }
    public String getKeyword(int i) throws SQLException
    {
        return getLayer(i).keyword;
    }

    public String getAnnotation(int i) throws SQLException
    {
        return getLayer(i)._strAnnotation;
    }

    public static String getDetail(Node node,int language,int listing,String target) throws SQLException
    {
        tea.resource.Resource r = new tea.resource.Resource();
        Span span = null;
        StringBuilder sb = new StringBuilder();
        // Node obj = Node.find(node);
        Book obj = Book.find(node._nNode);
        ListingDetail detail = ListingDetail.find(listing,12,language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("subject"))
            {
                value = (node.getSubject(language));
            } else if(itemname.equals("isbn"))
            {
                value = (obj.getISBN());
            }
            /*
             * else if (itemname.equals("text")) { if ((obj.getOptions() & 0x40) == 0) { value=(tea.html.Text.toHTML(obj.getText(iLanguage))); } else { value=(obj.getText(iLanguage)); } // value=(Node.find(node).getText(iLanguage)); }
             */
            else if(itemname.equals("format"))
            {
                value = (r.getString(language,Book.BOOK_FORMAT[obj.getFormat()]));
            } else if(itemname.equals("binding"))
            {
                value = (r.getString(language,Book.BOOK_BINDING[obj.getBinding()]));
            } else if(itemname.equals("amountword"))
            {
                value = String.valueOf(obj.getAmountWord());
            } else if(itemname.equals("amountpage"))
            {
                value = String.valueOf(obj.getAmountPage());
            } else if(itemname.equals("price"))
            {
                value = (obj.getPrice().toString());
            } else if(itemname.equals("publishdate"))
            {
                value = (obj.getPublisher(language));
            } else if(itemname.equals("reprint"))
            {
                value = String.valueOf(obj.getReprint());
            } else if(itemname.equals("subtitle"))
            {
                value = (obj.getSubTitle(language));
            } else if(itemname.equals("publisher"))
            {
                value = (obj.getPublisher(language));
            } else if(itemname.equals("cipi"))
            {
                value = (obj.getCIPI(language));
            } else if(itemname.equals("cipii"))
            {
                value = (obj.getCIPII(language));
            } else if(itemname.equals("cipiiv"))
            {
                value = (obj.getCIPIV(language));
            } else if(itemname.equals("reader"))
            {
                value = (obj.getReader(language));
            } else if(itemname.equals("collection"))
            {
                value = (obj.getCollection(language));
            } else if(itemname.equals("annotation"))
            {
                value = (obj.getAnnotation(language));
            } else if(itemname.equals("smallpicture"))
            {
                value = (new tea.html.Image(obj.getSmallPicture(language)).toString());
            } else if(itemname.equals("bigpicture"))
            {
                value = (new tea.html.Image(obj.getBigPicture(language)).toString());
            }
            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/servlet/Book?node=" + node._nNode + "&language=" + language,value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("BookID" + itemname);
            sb.append(detail.getBeforeItem(itemname)).append(span).append(detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

	public Date getIndate() {
		return indate;
	}

	public void setIndate(Date indate) {
		this.indate = indate;
	}

	public Date getDate2() {
		return date2;
	}

	public void setDate2(Date date2) {
		this.date2 = date2;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getSpecifications() {
		return specifications;
	}

	public void setSpecifications(int specifications) {
		this.specifications = specifications;
	}

	public int getInventory() {
		return inventory;
	}

	public void setInventory(int inventory) {
		this.inventory = inventory;
	}

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}

	

	public void setDocnode(int docnode) {
		this.docnode = docnode;
	}
    
}

