package tea.entity.order;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.Cache;

public class OrderDedail {
	protected static Cache c = new Cache(50);
	// 数据库表字段:id 描述:记录编号
	protected Integer id = null;

	// 数据库表字段:sale_order_id 描述:订单Id
	protected Integer saleOrderId = null;

	// 数据库表字段:sale_order_code
	// 描述:订单编号（'O'+年[4]+月[2]+日[2]+小时[2]+分钟[2]+秒[2]+随机数[3]）
	protected String saleOrderCode = null;
	// 数据库表字段:goods_code 描述:商品编码
	protected String goodsCode = null;
	public int node;
	// 数据库表字段:goods_title 描述:商品名称
	protected String goodsTitle = null;

	// 数据库表字段:goods_bar_code 描述:商品条码
	protected String goodsBarCode = null;

	// 数据库表字段:goods_sort 描述:商品分类
	protected Integer goodsSort = null;
	// 数据库表字段:num 描述:商品数量
	protected Integer num = null;

	// 数据库表字段:money 描述:小计金额
	protected BigDecimal money;

	public OrderDedail()
    {
        
    }
	public OrderDedail(int id)
    {
        this.id = id;
    }

    public static OrderDedail find(int id) throws SQLException
    {
    	OrderDedail t = (OrderDedail) c.get(id);
        if(t == null)
        {
        	List<OrderDedail> al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new OrderDedail(id) : (OrderDedail) al.get(0);
        }
        return t;
    }

    public static List<OrderDedail> findByOrderId(int saleOrderId) throws SQLException
    {
        return find(" AND saleOrderId=" + saleOrderId + " ORDER BY id",0,200);
    }

    public static List<OrderDedail> find(String sql,int pos,int size) throws SQLException
    {
    	List<OrderDedail> list = new ArrayList<OrderDedail>();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT id,saleOrderId,saleOrderCode,node,goodsCode,goodsTitle,goodsSort,num,money FROM SaleOrderDedail  WHERE 1=1 "
					+ sql,pos,size);
			while (db.next()) {
				OrderDedail t = new OrderDedail();
				int z = 1;
				t.id = db.getInt(z++);
				t.saleOrderId = db.getInt(z++);
				t.saleOrderCode = db.getString(z++);
				t.node = db.getInt(z++);
				t.goodsCode = db.getString(z++);
				t.goodsTitle = db.getString(z++);
				t.goodsSort = db.getInt(z++);
				t.num = db.getInt(z++);
				t.money = db.getBigDecimal(z++, 2);
				list.add(t);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(node) FROM SaleOrderDedail WHERE 1=1" + sql);
    }

    public int set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(id < 1)
            {
                db.executeUpdate("INSERT INTO SaleOrderDedail(saleOrderId,saleOrderCode,node,goodsCode,goodsTitle,goodsSort,num,money)VALUES(" + saleOrderId + "," + DbAdapter.cite(saleOrderCode)+ "," +node + "," + DbAdapter.cite(goodsCode) + "," + DbAdapter.cite(goodsTitle) +","+goodsSort+","+num+ "," + money + ")");
                id = db.getInt("SELECT MAX(id) FROM SaleOrderDedail WHERE saleOrderId=" + saleOrderId);
            } else
                db.executeUpdate("UPDATE SaleOrderDedail SET saleOrderId=" + saleOrderId+ ",saleOrderCode=" + DbAdapter.cite(saleOrderCode)+ ",node=" +node+ ",goodsCode=" + DbAdapter.cite(goodsCode)+ ",goodsTitle=" + DbAdapter.cite(goodsTitle)+",goodsSort=" + goodsSort+",num=" + num+",money=" + money + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
        return id;
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM SaleOrderDedail WHERE id=" + id);
        c.remove(id);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE SaleOrderDedail SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        c.remove(id);
    }
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSaleOrderId() {
		return saleOrderId;
	}
	public void setSaleOrderId(Integer saleOrderId) {
		this.saleOrderId = saleOrderId;
	}
	public String getSaleOrderCode() {
		return saleOrderCode;
	}
	public void setSaleOrderCode(String saleOrderCode) {
		this.saleOrderCode = saleOrderCode;
	}
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getGoodsTitle() {
		return goodsTitle;
	}
	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}
	public String getGoodsBarCode() {
		return goodsBarCode;
	}
	public void setGoodsBarCode(String goodsBarCode) {
		this.goodsBarCode = goodsBarCode;
	}
	public Integer getGoodsSort() {
		return goodsSort;
	}
	public void setGoodsSort(Integer goodsSort) {
		this.goodsSort = goodsSort;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public BigDecimal getMoney() {
		return money;
	}
	public void setMoney(BigDecimal money) {
		this.money = money;
	}
    
}
