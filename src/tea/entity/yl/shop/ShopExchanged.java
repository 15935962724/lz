package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import com.mysql.jdbc.Field;

import tea.SeqShop;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.MT;
import tea.entity.Seq;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shopnew.ChangeLiziData;
import util.Config;

/**
 * 退换货
 * @author guodh
 * */
public class ShopExchanged {

	protected static Cache c = new Cache(50);
	
	public int id;				
	public String orderId;	//订单编号
	public String exchanged_code;//退货单编号
	public int status;	//0/未处理完成、1已完成、2拒绝（后更改为，后台的退货管理中把拒绝按钮去掉，变为修改粒子数，然后短信通知订单管理员和代理商已修改，并短信说明需要代理商在7天内确认，如超过7天未确认，系统默认确认，如果不同意修改，则可线下电话联系管理员，上海出库管理员可再次修改粒子数，修改时向setExchangedrecord插入记录）
	public int product_id;//产品/套装id
	public int type;				//类型：1退货，2换货
	public int quantity;			//数量
	public String description;		//问题描述
	public String picture;	
	public Date time;//提交时间
	public int member;
	public String expressNo;        //快递单号
	public int pro_type;	//退单产品类型：1为粒子
	public int exchangednum;  //拒绝退货后，修改后的数量
	public int exchangedstatus;  //修改退货数量后，服务商确认状态   1：已确认 2：超过7天系统默认已确认
	public Date exchangedtime;  //服务商确认时间/系统默认确认时间
	
	public int puid;//厂商

	
	public ShopExchanged(int id){
		this.id = id;
	}
	
	public static ShopExchanged find(int id){
		ShopExchanged aShopPackage=null;
		ArrayList<ShopExchanged> list = find(" AND id = " + id, 0, 1);
		aShopPackage = list.size() < 1 ? new ShopExchanged(id):list.get(0);
		return aShopPackage;
	}
	
	public static ShopExchanged findByOidPid(String orderId,int product_id){
		ArrayList<ShopExchanged> list = find(" AND order_id = " + DbAdapter.cite(orderId)+" AND product_id="+product_id, 0, 1);
		ShopExchanged aShopPackage = list.size() < 1 ? new ShopExchanged(0):list.get(0);
		return aShopPackage;
	}
	public static ShopExchanged findByOrderId(String orderId){
		ArrayList<ShopExchanged> list = find(" AND order_id = " + DbAdapter.cite(orderId), 0, 1);
		ShopExchanged aShopPackage = list.size() < 1 ? new ShopExchanged(0):list.get(0);
		return aShopPackage;
	}
	/*public static ArrayList<ShopExchanged> find(String sql,int pos,int size){
		ArrayList<ShopExchanged> list = new ArrayList<ShopExchanged>();
		DbAdapter db = new DbAdapter();
		String QSql = "select se.id,se.order_id,se.exchanged_code,se.status,se.product_id,se.type,se.quantity,se.description,se.picture,se.member,se.time,se.expressNo,se.pro_type,se.exchangednum,se.exchangedstatus,exchangedtime from shopexchanged se "+tab(sql)+" where 1=1 " + sql;
		try {
			db.executeQuery(QSql, pos, size);
			while(db.next()){
				
				int i = 1;
				ShopExchanged sn = new ShopExchanged(db.getInt(i++));
				sn.orderId=db.getString(i++);
				sn.exchanged_code=db.getString(i++);
				sn.status=db.getInt(i++);
				sn.product_id=db.getInt(i++);
				sn.type=db.getInt(i++);
				sn.quantity=db.getInt(i++);
				sn.description=db.getString(i++);
				sn.picture=db.getString(i++);
				sn.member=db.getInt(i++);
				sn.time=db.getDate(i++);
				sn.expressNo=db.getString(i++);
				sn.pro_type = db.getInt(i++);
				sn.exchangednum = db.getInt(i++);
				sn.exchangedstatus = db.getInt(i++);
				sn.exchangedtime = db.getDate(i++);
				c.put(sn.id, sn);
			}
			db.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{

		}
		return list;
	}*/
	
	public static ArrayList<ShopExchanged> find(String sql,int pos,int size){
		ArrayList<ShopExchanged> list = new ArrayList<ShopExchanged>();
		DbAdapter db = new DbAdapter();
		String QSql = "select se.id,se.order_id,se.exchanged_code,se.status,se.product_id,se.type,se.quantity,se.description,se.picture,se.member,se.time,se.expressNo,se.pro_type,se.exchangednum,se.exchangedstatus,exchangedtime,se.puid from shopexchanged se "+tab(sql)+" where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				
				int i = 1;
				ShopExchanged sn = new ShopExchanged(rs.getInt(i++));
				sn.orderId=rs.getString(i++);
				sn.exchanged_code=rs.getString(i++);
				sn.status=rs.getInt(i++);
				sn.product_id=rs.getInt(i++);
				sn.type=rs.getInt(i++);
				sn.quantity=rs.getInt(i++);
				sn.description=rs.getString(i++);
				sn.picture=rs.getString(i++);
				sn.member=rs.getInt(i++);
				sn.time=db.getDate(i++);
				sn.expressNo=rs.getString(i++);
				sn.pro_type = rs.getInt(i++);
				sn.exchangednum = rs.getInt(i++);
				sn.exchangedstatus = rs.getInt(i++);
				sn.exchangedtime = db.getDate(i++);
				sn.puid = db.getInt(i++);
				c.put(sn.id, sn);
				list.add(sn);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public static ArrayList<ShopExchanged> find2(String sql,int pos,int size){
		ArrayList<ShopExchanged> list = new ArrayList<ShopExchanged>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,order_id,exchanged_code,status,product_id,type,quantity,description,picture,member,time,expressNo,pro_type,exchangednum,exchangedstatus,exchangedtime,puid from shopexchanged se where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				
				int i = 1;
				ShopExchanged sn = new ShopExchanged(rs.getInt(i++));
				sn.orderId=rs.getString(i++);
				sn.exchanged_code=rs.getString(i++);
				sn.status=rs.getInt(i++);
				sn.product_id=rs.getInt(i++);
				sn.type=rs.getInt(i++);
				sn.quantity=rs.getInt(i++);
				sn.description=rs.getString(i++);
				sn.picture=rs.getString(i++);
				sn.member=rs.getInt(i++);
				sn.time=db.getDate(i++);
				sn.expressNo=rs.getString(i++);
				sn.pro_type = rs.getInt(i++);
				sn.exchangednum = rs.getInt(i++);
				sn.exchangedstatus = rs.getInt(i++);
				sn.exchangedtime = db.getDate(i++);
				sn.puid = db.getInt(i++);
				c.put(sn.id, sn);
				list.add(sn);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
			Filex.logs("ytexe2.txt", sql+":"+list.size());
		}
		return list;
	}
	
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from shopexchanged se "+tab(sql)+" where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shopexchanged(id,order_id,exchanged_code,status,product_id,type,quantity,description,picture,member,time,expressNo,pro_type,exchangednum,exchangedstatus,exchangedtime,puid) values(" 
				+ (this.id = Seq.get()) + "," + DbAdapter.cite(orderId) + "," + DbAdapter.cite(this.exchanged_code) + "," + status+ "," + product_id + "," + type + "," + quantity + "," + DbAdapter.cite(description) + "," + DbAdapter.cite(picture)+ "," + member+ "," + DbAdapter.cite(time)+ "," + DbAdapter.cite(expressNo) + "," + pro_type +","+exchangednum+ ","+exchangedstatus+","+DbAdapter.cite(exchangedtime)+","+puid+")";
		}else{
			sql = "update shopexchanged set order_id="+DbAdapter.cite(orderId)+",exchanged_code="+DbAdapter.cite(this.exchanged_code)+",status="+status+",product_id="+product_id+",type="+type+",quantity="+quantity+",description="+DbAdapter.cite(description)+",picture=" + DbAdapter.cite(picture)+",member=" + member+",time=" + DbAdapter.cite(time)+",expressNo="+DbAdapter.cite(expressNo)+ ",pro_type= " +pro_type+ ",exchangednum="+exchangednum+",exchangedstatus="+exchangedstatus+",exchangedtime="+DbAdapter.cite(exchangedtime)+",puid="+puid+" where id=" + id;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public void delete(){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id,"delete from shopexchanged where id= " + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public void set(String column,String value){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update shopexchanged set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND sod."))
            sb.append(" INNER JOIN ShopOrderDispatch sod ON sod.order_id=se.order_id");
        return sb.toString();
    }
	//自动确认修改（超过7天还未确认的)
	public static void yesupdate() {
		try {
			Timer timer = new Timer();
			timer.schedule(new TimerTask() {
				public void run() {
					try {
						//查询出已被修改数量的，服务商未确认的
						List<ShopExchanged> lstex=ShopExchanged.find(" and status=2 and exchangednum>=0 and (exchangedstatus is null or exchangedstatus=0)", 0, Integer.MAX_VALUE);
						for(int i=0;i<lstex.size();i++){
							ShopExchanged exchanged=lstex.get(i);
							int eid=exchanged.id;
							SetExchangedRecord record=SetExchangedRecord.findtop(" and datediff(HH,createdate,getdate())>=168 and exchangeid="+eid+" order by createdate desc ");
							if(record.getId()>0){
								exchanged.exchangedstatus=2;
								exchanged.exchangedtime=new Date();
								exchanged.set();
								//发送短信
								Profile p=Profile.find(exchanged.member);
								String mobiles=p.mobile;
								
								ShopOrder so=ShopOrder.findByOrderId(exchanged.orderId);
								int mypuid = ShopOrderData.findPuid(so.getOrderId());
								String mobstr = "";
							if(mypuid==Config.getInt("junan")){
								mobstr = "0574-86230301";
							}else if(mypuid==Config.getInt("xinke")){
								mobstr = "021-54424243";
							}else if(mypuid==Config.getInt("gaoke")){
								mobstr = "010-69358206";
							}
								String content="申请退货的订单号为"+exchanged.orderId+"的订单，退货单"+exchanged.exchanged_code+"退货数量已由"+exchanged.quantity+"被修改为"+exchanged.exchangednum+"。已超过7天内未确认，系统默认确认。如有疑问请与管理员联系，电话："+mobstr+"。";
								
								SMSMessage.create("Home", "", mobiles, 1, content);
								//积分和负数订单
								if(exchanged.type==1){
									//ShopOrder so = ShopOrder.findByOrderId(exchanged.orderId);
									//退货减积分
									try{
										ShopOrderData sod = ShopOrderData.find(" AND order_id = "+Database.cite(exchanged.orderId)+" and product_id = "+exchanged.product_id, 0, 1).get(0);
										double prices = sod.getUnit() * exchanged.exchangednum;
										int status= ShopMyPoints.creatPoint(exchanged.member,"退货减积分"+(int)prices,(-(int)prices), null);
									}catch(Exception e){
										
									}

									if(exchanged.exchangednum!=0){
//退货增加负数数量和负数金额的订单，同时记录当前时间
										//增加shoporder表记录
										ShopOrder neworder=ShopOrder.find(0);
										neworder.setOrderId("PO"+SeqShop.get());
										neworder.setMember(exchanged.member);
										neworder.setCreateDate(new Date());//当前确认时间
										neworder.setStatus(7);
										neworder.setReturntime(new Date());
										neworder.setOldorderid(exchanged.orderId);
										neworder.setLzCategory(so.isLzCategory());
										neworder.set();
										//增加shoporderdata表记录
										List<ShopOrderData> lstolddata=ShopOrderData.find(" and order_id = "+Database.cite(exchanged.orderId), 0, Integer.MAX_VALUE);
										if(lstolddata.size()>0){
											ShopOrderData olddata=lstolddata.get(0);//每个订单只有一种产品，所以只取一个
											double danjia=so.getAmount()/olddata.getQuantity();
											//neworder.setAmount(-(danjia*sec.quantity));//设置订单的amount
											neworder.set("amount", String.valueOf(-(danjia*exchanged.exchangednum)));
											neworder.set("noinvoicenum", String.valueOf(-exchanged.exchangednum));//未开票数量也为负数
											ShopOrderData newdata=ShopOrderData.find(0);
											newdata.setOrderId(neworder.getOrderId());
											newdata.setProductId(olddata.getProductId());
											newdata.setUnit(olddata.getUnit());
											newdata.setQuantity(-exchanged.exchangednum);//负数的退货数量
											newdata.setAmount(-(olddata.getUnit()*exchanged.exchangednum));//负数的退货金额
											newdata.setCalibrationDate(olddata.getCalibrationDate());
											newdata.setActivity(olddata.getActivity());
											newdata.setAgent_price_s(olddata.getAgent_price_s());
											newdata.setAgent_price(olddata.getAgent_price());
											newdata.setAgent_amount(-(olddata.getAgent_price()*exchanged.exchangednum));//负数的开票金额
											newdata.set();
										}
										//增加ShopOrderDispatch表记录
										ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(neworder.getOrderId());
										ShopOrderDispatch sodold = ShopOrderDispatch.findByOrderId(exchanged.orderId);
										//添加收货人地址信息
										sod.setA_consignees(MT.f(sodold.getA_consignees()));
										sod.setA_address(MT.f(sodold.getA_address()));
										sod.setA_mobile(MT.f(sodold.getA_mobile()));
										sod.setA_hospital_id(sodold.getA_hospital_id());
										sod.setA_telphone(MT.f(sodold.getA_telphone()));
										sod.setA_zipcode(MT.f(sodold.getA_zipcode()));

										sod.setA_hospital(MT.f(sodold.getA_hospital())); 		//医院
										sod.setA_department(MT.f(sodold.getA_department()));	//科室
										sod.set();
									}
									//退货导致未开票粒子数减少
									ShopOrderDispatch orderdispatch=ShopOrderDispatch.findByOrderId(exchanged.orderId);
									ChangeLiziData.jiannoinvoice(orderdispatch.getA_hospital_id(), exchanged.exchangednum, new Date(), exchanged.member, exchanged.id);

								}


							}
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

			}, 0, 1 * 60 * 60 * 1000);// 1小时扫描一次

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
}
