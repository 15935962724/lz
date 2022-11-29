package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;
import tea.entity.member.Profile;

/**
 * 我的积分
 * */
public class ShopMyPoints {

	protected static Cache c = new Cache(50);

	private int id;
	private int member;
	private Date createTime; // 获取积分时间
	private int integral; // 积分
	private String orderId; // 订单编号
	public String content;// 积分来源
	public Date validTime;// 有效时间
	public int validIntegral;// 有效积分
	public final static String[] STATUS={"未知错误","操作成功","操作失败,您的积分不足"};

	public ShopMyPoints(int id) {
		this.id = id;
	}

	public static ShopMyPoints find(int id) {
		ShopMyPoints aHospital = (ShopMyPoints) c.get(id);
		if (aHospital == null) {
			ArrayList<ShopMyPoints> list = find(" AND id = " + id, 0, 1);
			aHospital = list.size() < 1 ? new ShopMyPoints(id) : list.get(0);
		}
		return aHospital;
	}

	private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND p."))
            sb.append(" inner join profile p on p.profile = sm.member");
        return sb.toString();
    }
	
	public static ArrayList<ShopMyPoints> find(String sql, int pos, int size) {
		ArrayList<ShopMyPoints> list = new ArrayList<ShopMyPoints>();
		DbAdapter db = new DbAdapter();
		String QSql = "select sm.id,sm.createtime,sm.integral,sm.orderid,sm.member,sm.content,sm.validTime,sm.validIntegral from shopMyPoints sm "+tab(sql)+" where 1=1 "
				+ sql;
		try {
			db.executeQuery(QSql, pos, size);
			while (db.next()) {
				int i = 1;
				ShopMyPoints h = new ShopMyPoints(db.getInt(i++));
				h.createTime = db.getDate(i++);
				h.integral = db.getInt(i++);
				h.orderId = db.getString(i++);
				h.member = db.getInt(i++);
				h.content = db.getString(i++);
				h.validTime = db.getDate(i++);
				h.validIntegral = db.getInt(i++);
				c.put(h.id, h);
				list.add(h);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static int count(String sql) throws SQLException {
		return DbAdapter.execute("select count(0) from shopMyPoints sm "+tab(sql)+" where 1=1 "
				+ sql);
	}

	public void set() throws SQLException {
		String sql = "";
		if (this.id < 1) {
			sql = "insert into shopMyPoints(id,createtime,integral,orderid,member,content,validTime,validIntegral) values("
					+ (this.id = Seq.get())
					+ ","
					+ DbAdapter.cite(this.createTime)
					+ ","
					+ this.integral
					+ ","
					+ DbAdapter.cite(this.orderId)
					+ ","
					+ this.member
					+ ","
					+ DbAdapter.cite(content)
					+ ","
					+ DbAdapter.cite(validTime) + "," + validIntegral + ")";
		} else {
			sql = "update shopMyPoints set createtime="
					+ DbAdapter.cite(this.createTime) + ",integral="
					+ this.integral + ",orderid="
					+ DbAdapter.cite(this.orderId) + ",member=" + this.member
					+ ",content=" + DbAdapter.cite(content) + ",validTime="
					+ DbAdapter.cite(validTime) + ",validIntegral="
					+ validIntegral + " where id=" + this.id;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		c.remove(this.id);
	}

	public static void delete(int id) {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id, "delete from shopMyPoints where id= " + id);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		c.remove(id);
	}

	public void set(String column, String value) {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update shopMyPoints set " + column + "="
					+ DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		c.remove(this.id);
	}
    /**粒子订单付款成功加积分*/
	public static void setPoints(String order_id, int member)
			throws SQLException {
		String content = "订单<a class='orderid' href='###' onclick='mt.show(\"/jsp/yl/shopweb/ShopOrderDatas2.jsp?order_id="+order_id+"\",2,\"订单明细\",500,350)'>"+order_id+"</a>";
		Profile p = Profile.find(member);
		if(p.membertype !=2){
			int integralrule = 0;
			/*ArrayList alist = ShopIntegralRules.find(" and item=0", 0, 1);
			if (alist.size() > 0) {
				integralrule = ((ShopIntegralRules) alist.get(0)).getIntegral();
			}*/
			integralrule = ShopIntegralRules.findByItem(0).getIntegral();
			ArrayList list = ShopOrderData.find(
					" and order_id=" + DbAdapter.cite(order_id), 0,
					Integer.MAX_VALUE);
			double totalprice=0;
			for (int i = 0; i < list.size(); i++) {
				ShopOrderData sd = (ShopOrderData) list.get(i);
				ShopProduct sProduct=ShopProduct.find(sd.getProductId());
				if (sProduct.isExist&&sProduct.category == ShopCategory.getCategory("lzCategory")) {
					totalprice+=sd.getAmount();
				}
			}
			int temp = (int) (totalprice / integralrule);
			if(temp>0)
			  creatPoint(member,content+"中获取积分"+temp,temp,order_id);
			if(totalprice>=10000){
				creatPoint(member,content +"满10000元,额外获得积分1000",1000,order_id);
			}
		}
		//
	}
	/**获取明年*/
	public static Date getNextYear(Calendar curr) {
		curr.set(Calendar.YEAR, curr.get(Calendar.YEAR) + 1);
		Date date = curr.getTime();
		return date;
	}
	/**获取昨天*/
	public static Date getLastDay(Calendar curr) {
		curr.set(Calendar.DATE, -1);
		Date date = curr.getTime();
		return date;
	}
	/**清除无效积分
	 * @throws SQLException */
	public static void clearIntegral(Calendar curr) throws SQLException{
		ArrayList<ShopMyPoints> list= find(" and validIntegral>0 and validTime>"+DbAdapter.cite(getLastDay(curr))+" and validTime<"+DbAdapter.cite(curr.getTime()), 0, Integer.MAX_VALUE);
		for (int i = 0; i < list.size(); i++) {
			ShopMyPoints smp=list.get(i);
			Profile p=Profile.find(smp.member);
			p.setIntegral(p.getIntegral()-smp.integral, smp.member);
		}
	}
    /**加减积分*/
	public static int creatPoint(int member, String content, int integral,String orderid) {
		int status=0;//0未知错误1成功2积分不够减
		try {
			Profile p = Profile.find(member);
            if(integral<0){
				if(p.getIntegral()<Math.abs(integral)){
					return 2;
				}else{
					ArrayList list= ShopMyPoints.find(" and validIntegral>0 and validTime>"+DbAdapter.cite(new Date())+" order by createTime asc", 0, Integer.MAX_VALUE);
					if(list.size()>0){
						int tempintegral=Math.abs(integral);
						for (int i = 0; i < list.size(); i++) {
							ShopMyPoints smp=(ShopMyPoints)list.get(i);
							if(smp.validIntegral>=tempintegral){
								smp.validIntegral=smp.validIntegral-tempintegral;
								i=list.size();
							}else{
								smp.validIntegral=0;
								tempintegral=tempintegral-smp.validIntegral;
							}
							smp.set();
						}
					}else{
						return 0;
					}
				}
			}
			ShopMyPoints smp = new ShopMyPoints(0);
			Calendar curr = Calendar.getInstance();
			smp.createTime = curr.getTime();
			smp.member = member;
			smp.integral = integral;
			smp.content = content;
			smp.orderId = orderid;
			smp.validTime = getNextYear(curr);
			smp.validIntegral = integral;
			smp.set();
			
			p.setIntegral(integral + p.getIntegral(), member);
			status=1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;
	}
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public int getIntegral() {
		return integral;
	}

	public void setIntegral(int integral) {
		this.integral = integral;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

}
