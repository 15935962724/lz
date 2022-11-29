package tea.entity.node;

import tea.db.*;
import tea.entity.*;
import tea.resource.*;
import tea.html.*;
import java.util.*;
import java.sql.SQLException;

public class Commodity extends Entity
{
    public static final String QUALITY[] =
            {"QualityNew","Used","Refurbished"};
    public static final int QUALITY_NEW = 0;
    public static final int QUALITY_USED = 1;
    public static final int QUALITY_REFURBISHED = 2;
    private int commodity;
    private String _strSKU;
    private String _strSerialNumber;
    private int _nQuality;
    private int _nInventory;
    private int _nMinQuantity;
    private int _nMaxQuantity;
    private int _nDelta;
    private int _nSupplier;
    private int _nWeight;
    private int _nVolume;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    private int goods;

    public String getSKU() throws SQLException
    {
        load();
        return _strSKU;
    }

    public int getSupplier() throws SQLException
    {
        load();
        return _nSupplier;
    }

    public void set(String sku,String serialnumber,int quality,int inventory,int minquantity,int maxquantity,int delta,int supplier,int weight,int volume,int goods) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeQuery("CommodityEdit " + commodity + ",
            // " + DbAdapter.cite(sku) + ", " + DbAdapter.cite(serialnumber) + ",
            // " + quality + ", " + inventory + ", " + minquantity + ", " + maxquantity + ",
            // " + delta + ", " + (supplier) + ", " + weight + ", " + volume + ", " + goods);
            db.executeQuery("SELECT commodity FROM Commodity WHERE commodity=" + commodity);
            if(db.next())
            {
                db.executeUpdate("UPDATE Commodity  SET sku=" + DbAdapter.cite(sku) + ", serialnumber=" + DbAdapter.cite(serialnumber) + ", quality=" + quality + ",inventory=" + inventory + ", minquantity=" + minquantity + ",maxquantity=" + maxquantity + ",delta=" + delta + ",supplier=" + (supplier) + ",weight=" + weight + ",volume=" + volume + ",goods=" + goods + " WHERE commodity=" + commodity);
            } else
            {
                db.executeUpdate("INSERT INTO Commodity (sku, serialnumber, quality, inventory, minquantity, maxquantity, delta, supplier, weight, volume,goods)VALUES (" + DbAdapter.cite(sku) + ", " + DbAdapter.cite(serialnumber) + ", " + quality + ", " + inventory + ", " + minquantity + ", " + maxquantity + ", " + delta + ", " + (supplier) + ", " + weight + ", " + volume + "," + goods + ")");
            }
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
        if(commodity != 0)
        {
            this._strSKU = sku;
            this._strSerialNumber = serialnumber;
            this._nQuality = quality;
            this._nInventory = inventory;
            this._nMinQuantity = minquantity;
            this._nMaxQuantity = maxquantity;
            this._nDelta = delta;
            this._nSupplier = supplier;
            this._nWeight = weight;
            this._nVolume = volume;
            this.goods = goods;
        } else
        {
            // _cache.remove(new Integer(commodity));
        }
    }

    public static int create(String sku,String serialnumber,int quality,int inventory,int minquantity,int maxquantity,int delta,int supplier,int weight,int volume,int goods) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Commodity SET sku=" + DbAdapter.cite(sku) + ", serialnumber=" + DbAdapter.cite(serialnumber) + ", quality=" + quality + ",inventory=" + inventory + ", minquantity=" + minquantity + ",maxquantity=" + maxquantity + ",delta=" + delta + ",supplier=" + (supplier) + ",weight=" + weight + ",volume=" + volume + ",goods=" + goods + " WHERE commodity=0");
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Commodity (sku, serialnumber, quality, inventory, minquantity, maxquantity, delta, supplier, weight, volume,goods)	VALUES (" + DbAdapter.cite(sku) + ", " + DbAdapter.cite(serialnumber) + ", " + quality + ", " + inventory + ", " + minquantity + ", " + maxquantity + ", " + delta + ", " + (supplier) + ", " + weight + ", " + volume + "," + goods + ")");
            }
            return db.getInt("SELECT MAX(commodity) FROM Commodity");
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Commodity WHERE commodity=" + commodity);
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }

    }

    // 通过goods找信息
    public Commodity(int goods,String a) throws SQLException
    {
        this.goods = goods;
        load_goods();
    }

    public static Commodity find_goods(int goods) throws SQLException
    {
        return new Commodity(goods,"");
    }

    private void load_goods() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT sku, serialnumber, quality, inventory, minquantity, maxquantity, delta, supplier, weight, volume,goods,commodity FROM Commodity  WHERE goods="
                                + goods);
                if(db.next())
                {
                    _strSKU = db.getString(1);
                    _strSerialNumber = db.getString(2);
                    _nQuality = db.getInt(3);
                    _nInventory = db.getInt(4);
                    _nMinQuantity = db.getInt(5);
                    _nMaxQuantity = db.getInt(6);
                    _nDelta = db.getInt(7);
                    _nSupplier = db.getInt(8);
                    _nWeight = db.getInt(9);
                    _nVolume = db.getInt(10);
                    goods = db.getInt(11);
                    commodity = db.getInt(12);
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    private Commodity(int i)
    {
        commodity = i;
        _blLoaded = false;
    }

    public int getInventory() throws SQLException
    {
        load();
        return _nInventory;
    }

    public int getDefaultQuantity() throws SQLException
    {
        load();
        int i = 1;
        if(_nMinQuantity != 0)
        {
            i = _nMinQuantity;
        }
        return i;
    }

    public int getMinQuantity() throws SQLException
    {
        load();
        return _nMinQuantity;
    }

    public int getDelta() throws SQLException
    {
        load();
        return _nDelta;
    }

    public int getWeight() throws SQLException
    {
        load();
        return _nWeight;
    }

    public int getVolume() throws SQLException
    {
        load();
        return _nVolume;
    }

    // ��ѯ��ݿ��е�Commodity��,���ֱ��ȫ�ֱ���ֵ
    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT sku, serialnumber, quality, inventory, minquantity, maxquantity, delta, supplier, weight, volume,goods FROM Commodity  WHERE commodity=" + commodity);
                if(db.next())
                {
                    _strSKU = db.getString(1);
                    _strSerialNumber = db.getString(2);
                    _nQuality = db.getInt(3);
                    _nInventory = db.getInt(4);
                    _nMinQuantity = db.getInt(5);
                    _nMaxQuantity = db.getInt(6);
                    _nDelta = db.getInt(7);
                    _nSupplier = db.getInt(8);
                    _nWeight = db.getInt(9);
                    _nVolume = db.getInt(10);
                    goods = db.getInt(11);
                }
            } catch(Exception exception1)
            {
                throw new SQLException(exception1.toString());
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public String getSerialNumber() throws SQLException
    {
        load();
        return _strSerialNumber;
    }

    public boolean isValidQuantity(int i) throws SQLException
    {
        load();
        return i >= _nMinQuantity && (_nMaxQuantity == 0 || i <= _nMaxQuantity) && (_nDelta == 0 || (i - _nMinQuantity) % _nDelta == 0);
    }

    public int getMaxQuantity() throws SQLException
    {
        load();
        return _nMaxQuantity;
    }

    public int getQuality() throws SQLException
    {
        load();
        return _nQuality;
    }

    public static Commodity find(int i)
    {
        Commodity commodity = (Commodity) _cache.get(new Integer(i));
        if(commodity == null)
        {
            commodity = new Commodity(i);
            _cache.put(new Integer(i),commodity);
        }
        return commodity;
    }

    public static Commodity find(int node,int supplier)
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT commodity FROM Commodity WHERE goods=" + node + " AND supplier=" + supplier);
            if(db.next())
            {
                id = db.getInt(1);
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        return find(id);
    }

    public static Enumeration findByGoods(int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT commodity FROM Commodity WHERE Commodity.goods=" + node);
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

    // 通过goods查找供应商
    public static int findSupplierByGoods(int goods) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT supplier FROM Commodity WHERE Commodity.goods="
                                  + goods);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }
//一个供货商只能添加一个商品 和一个价格
	public static boolean isSupplier(int supplier,int goods)throws SQLException
	{
		boolean f = false;
		DbAdapter db = new DbAdapter();
	  try
	  {
		  db.executeQuery("SELECT supplier FROM Commodity WHERE supplier="+supplier+" AND goods="+ goods);
		  while(db.next())
		  {
			  f=true;
		  }
	  } finally
	  {
		  db.close();
	  }
	  return f;

	}

    public static int getCommodity(int supplier,int goods) throws SQLException
    {
        int f = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT commodity FROM Commodity WHERE supplier=" + supplier + " AND goods=" + goods);
            while(db.next())
            {
                f = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return f;

    }
    /*
     * public static tea.html.Text getDetail(Node node, int listing, int language, String target, String path) { tea.html.Text text = new tea.html.Text(); Span span = null; try { tea.resource.Resource r = new tea.resource.Resource(); Commodity obj = Commodity.find(node.commodity); java.util.Enumeration listingDetailEnumeration = ListingDetail.find(listing, 4, language); while (listingDetailEnumeration.hasMoreElements()) { ListingDetail detail = (ListingDetail)
     * listingDetailEnumeration.nextElement(); if (detail.getItemName().equals("subject")) { value=(node.getSubject(language)); } else if (detail.getItemName().equals("supplier")) { value=(obj.getSupplier()); } else if (detail.getItemName().equals("sku")) { value=(obj.getSKU()); } else if (detail.getItemName().equals("serialNumber")) { value=(obj.getSerialNumber()); } else if (detail.getItemName().equals("goods")) {
     * value=(obj.getGoods()); } else if (detail.getItemName().equals("quality")) { value=(obj.getQuality()); } else if (detail.getItemName().equals("inventory")) { value=(obj.getInventory()); } else if (detail.getItemName().equals("minQuantity")) { value=(obj.getMinQuantity()); } else if (detail.getItemName().equals("maxQuantity")) { value=(obj.getMaxQuantity()); } else if (detail.getItemName().equals("delta")) {
     * value=(obj.getDelta()); } else if (detail.getItemName().equals("weight")) { value=(obj.getWeight()); } else if (detail.getItemName().equals("volume")) { value=(obj.getVolume()); } else { continue; } if (detail.getAnchor() != 0) { Anchor anchor = new Anchor(path + "/servlet/Node?Node=" + node.commodity, value); anchor.setTarget(target); span = new Span(anchor); } else { span = new Span(value); } span.setId("BuyID" +
     * detail.getItemName()); text.add(new tea.html.Text(detail.getBeforeItem() + span + detail.getAfterItem())); } java.util.Enumeration enumer = BuyPrice.find(node.commodity); int currency; while (enumer.hasMoreElements()) { currency = ((Integer) enumer.nextElement()).intValue(); BuyPrice bp = BuyPrice.find(node.commodity, currency); listingDetailEnumeration = ListingDetail.find(listing, 4, language); while (listingDetailEnumeration.hasMoreElements()) { ListingDetail detail = (ListingDetail)
     * listingDetailEnumeration.nextElement(); if (detail.getItemName().equals("atsc")) { ListingDetail quantity = ListingDetail.find(listing, 4, "quantity", language); //������ if (quantity.exists()) { String id = "Quantity"+"N"+node.commodity +"C"+currency+"L"+listing; value=(quantity.getBeforeItem() + new tea.html.TextField(id, "1", 4).toString() + quantity.getAfterItem() + new tea.html.Button("ShoppingCart", r.getString(language, "CBAddToShoppingCart"),
     * "if(submitInteger(document.all['" + id + "'],'"+r.getString(language,"InvalidQuantity")+"'))window.open('/servlet/OfferBuy?Node=" + node.commodity + "&Price=" + bp.getPrice() + "&Currency=" + currency + "&Quantity='+parseInt(document.all['" + id + "'].value),'','height=170px,width=370px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');")); } else { value=(new tea.html.Button("ShoppingCart", r.getString(language,
     * "CBAddToShoppingCart"), "window.open('/servlet/OfferBuy?Node=" + node.commodity + "&Price=" + bp.getPrice() + "&Currency=" + currency + "&Quantity=1','','height=100,width=100,left=10000,top=10000');").toString()); } } else if (detail.getItemName().equals("currency")) { value=(Common.CURRENCY[currency]); } else if (detail.getItemName().equals("supply")) { value=(String.valueOf(bp.getSupply())); } else if (detail.getItemName().equals("list")) {
     * value=(String.valueOf(bp.getList())); } else if (detail.getItemName().equals("ourPrice")) { value=(String.valueOf(bp.getPrice())); } else if (detail.getItemName().equals("point")) { value=(String.valueOf(bp.getPoint())); } else if (detail.getItemName().equals("convertCurrency")) { value=(bp.getConvertCurrency()); } else { continue; } if (detail.getAnchor() != 0) { Anchor anchor = new Anchor(path + "/servlet/Node?Node=" + node.commodity,
     * value); anchor.setTarget(target); span = new Span(anchor); } else { span = new Span(value); } span.setId("BuyID" + detail.getItemName()); text.add(new tea.html.Text(detail.getBeforeItem() + span + detail.getAfterItem())); } } } catch (Exception ex) { ex.printStackTrace(); } return text; }
     */

    public int getGoods() throws SQLException
    {
        load();
        return goods;
    }

    public int getCommodity() throws SQLException
    {
        load_goods();
        return commodity;

    }


}
