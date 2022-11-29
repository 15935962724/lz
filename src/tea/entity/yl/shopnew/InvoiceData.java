package tea.entity.yl.shopnew;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;
import tea.entity.yl.shop.ShopOrderData;

/**
 * 发票附加表
 * @author yt
 * */
public class InvoiceData {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int invoiceid;					//主表id
	private String orderid;		        	//订单id
	private int num;		        		//开票数量
	private float amount;				    //开票金额
	private int status;			            //状态 0:未开票  1：已审核 2:已开具 3:审核不通过 4:退票申请 中  5:同意退票 2：拒绝退票(同已开具发票)
	public static String[] STATUS={"未开票","已审核","已开具","审核不通过","退票申请中","同意退票","拒绝退票"};
	
	public InvoiceData(int id){
		this.id = id;
	}
	
	public static InvoiceData find(int id){
		InvoiceData invoice = (InvoiceData)c.get(id);
		if(invoice == null){
			ArrayList<InvoiceData> list = find(" AND id = " + id, 0, 1);
			invoice = list.size() < 1 ? new InvoiceData(id):list.get(0);
		}
		return invoice;
	}
	
	
	
	public static ArrayList<InvoiceData> find(String sql,int pos,int size){
		ArrayList<InvoiceData> list = new ArrayList<InvoiceData>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,invoiceid,orderid,num,amount,status from invoicedata where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				InvoiceData invoice = new InvoiceData(rs.getInt(i++));
				invoice.setInvoiceid(rs.getInt(i++));
				invoice.setOrderid(rs.getString(i++));
				invoice.setNum(rs.getInt(i++));
				invoice.setAmount(rs.getFloat(i++));
				invoice.setStatus(rs.getInt(i++));
				c.put(invoice.id, invoice);
				list.add(invoice);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	//查询有哪些orderid
	public static ArrayList<String> findOrderid(String sql,int pos,int size){
		ArrayList<String> list = new ArrayList<String>();
		DbAdapter db = new DbAdapter();
		String QSql = "select orderid from invoicedata where 1=1 group by orderid";
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				String oid = rs.getString(i++);
				
				list.add(oid);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	//根据订单查询总共与多少粒数
	public static int sumNum(String sql) throws SQLException{
		return DbAdapter.execute("select sum(num) from invoicedata where 1=1 " + sql);
	}
	//根据订单查询总共与多少金额
	public static float sumAmount(String sql) throws SQLException{
		return DbAdapter.execute("select sum(amount) from invoicedata where 1=1 " + sql);
	}
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from invoicedata where 1=1 " + sql);
	}
	
	public static int sumamount(String sql) throws SQLException{
		return DbAdapter.execute("select sum(amount) from invoicedata where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into invoicedata(id,invoiceid,orderid,num,amount,status) values(" 
				+ (this.id = Seq.get()) + "," + this.invoiceid + "," + DbAdapter.cite(this.orderid) + "," + this.num + "," + this.amount + ","+this.status+")";
		}else{
			sql = "update invoicedata set invoiceid="+this.invoiceid+",orderid="+ DbAdapter.cite(this.orderid) +",num="+this.num+",amount="+this.amount+",status="+this.status + " where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from invoicedata where id= " + this.id);
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
			db.executeUpdate(this.id, "update invoicedata set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}

	/**
	 * 获取商品厂商
	 * @return
	 */
	public static int getPuid(int invoiceid){
		List<InvoiceData> invoiceDatalist = InvoiceData.find(" AND invoiceid = "+invoiceid,0,1);
		int phpuid = 0;
		try{
			InvoiceData invoiceData = invoiceDatalist.get(0);
			String phorderid = invoiceData.getOrderid();
			phpuid = ShopOrderData.findPuid(phorderid);
		}catch (Exception e){

		}
		return phpuid;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getInvoiceid() {
		return invoiceid;
	}

	public void setInvoiceid(int invoiceid) {
		this.invoiceid = invoiceid;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	
	
	

}
