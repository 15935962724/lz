package tea.entity.yl.shop;

import java.io.InputStream;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.jdbc.object.RdbmsOperation;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shop.*;

/**
 * 医院表
 * @author guodh
 * */
public class ShopHospital {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private String name;		//医院名称
	private String area;		//省/市
	private String area_name;	//省/市名称
	private String htype;		//医院类型
	private String hgrader;	//医院等级
	private Date createtime;	//创建时间
	private int addflag;		//是否属于代理商 0 不属于 1属于
	private Date expirationDate; //截止日期，服务商代理医院的截止日期
	private int issign;  //20天以前有无未签收订单设置 0：不设置  1：设置（此字段的功能是，服务商下该医院的订单时，如果该医院20天之前有未签收的订单，则不可以下单并提示。如果没有，则正常下单。不设置的话则不判断，默认是设置的）
	
	//三期新加字段
	private float noreplywarn;  //未回款预警值
	private float noreplyalarm; //未回款报警值
	private int noinvoicewarn;  //未开票数量预警值
	private int noinvoicealarm; //未开票数量报警值
	
	private int isstoporder;//是否停止订货 0：否 ：1：是
	
	private int oldnoinvoice;  //未开票粒子数（初始值为-1）
	private Double oldnoreply;   //应收账款（初始值为-1）
	private Date timespot;     //未开票粒子数时间节点
	private Date timespot2;     //应收账款时间节点
	private int oldisinvoice;  //已开票粒子数  //3.9后加。小屈后提的。（初始值为-1）
	
	private Double oldnoreplynew; //最新应收账款
	private Date creplytime;//应收账款改变时间
	
	private int namefile;//医院名称变更附件

	private String h_code;// 医院编号

	private int upEmpower; // 是否有服务商 0,无  1,有
	private int vipEmpower; // 是否有vip 0,无  1,有

	private int productPuid;//商品厂商
	private int invoicePuid;//开票单位

	private int pid;//关联服务商公司id

	public static Map<String,String> shtype= new LinkedHashMap<String, String>();//类型
	public static Map<String,String> shmap = new LinkedHashMap<String, String>();//城市
	public static Map<String,String> shlv= new LinkedHashMap<String, String>();//等级

	public static String [] ShopHospitalField = {"","name","h_code","htype","hgrader","area"};

	private String hos_code;//CRM医院编码
	private String dep_code;//CRM科室编码
	private String hospiatl_name;//医院名称
	private String departments_name;//科室名称
	private int questionnum;//医院满意度数量   填一次自增   一季度清空一次   1 4 7 10 月1日清空为0   君安签收人 判断等于3不跳转  小于3跳转问卷调查
	private int fsaqxkz;//辐射安全许可证 文件id
	private int fsxypsyxkz;//放射性药品使用许可证 文件id
	private int fszlxkz;//放射诊疗许可证 文件id
	private int zfspb;//转让审批表 文件id
	private Date fsaqxkzrq;//辐射安全许可证 到期日
	private Date fsxypsyxkzrq;//放射性药品使用许可证 到期日
	private Date fszlxkzrq;//放射诊疗许可证 到期日
	private Date  zfspbrq;//转让审批表 到期日
	private String bq1;//bq前数字
	private int bq2;//bq后数字          bq = bq1  后面
	private float bqmci;// bq转换成mci值
	private String yjdhyy;//预警电话医院
	private String yjdhlz;//预警电话粒子平台
    private int approvalStatus;//审批状态  1审批中  2已拒绝 3已完成
    private int approvalProfile;//审批人   1发起人  2客服负责人  3质量管理员  4质量负责人  0无人审批
	private String  nobackreason;//拒绝原因
    public static String[] approvalRole = {"","医院资质提交人","客服负责人","质量管理员","质量负责人"};
    public static String[] approvalStatusType = {"","审批中","已拒绝","已完成"};
	public static String[] dqzjArr = {"辐射安全许可证","放射性药品使用许可证","放射诊疗许可证","转让审批表"};

	static {
		shmap.put("请选择省（自治区/直辖市）","");
		shmap.put("北京市","7180");
		shmap.put("天津市","7182");
		shmap.put("河北省","7184");
		shmap.put("山西省","7186");
		shmap.put("内蒙古自治区","7188");
		shmap.put("辽宁省","7190");
		shmap.put("吉林省","7192");
		shmap.put("黑龙江省","7194");
		shmap.put("上海市","7196");
		shmap.put("江苏省","7198");
		shmap.put("浙江省","7200");
		shmap.put("安徽省","7202");
		shmap.put("福建省","7204");
		shmap.put("江西省","7206");
		shmap.put("山东省","7208");
		shmap.put("河南省","7210");
		shmap.put("湖北省","7212");
		shmap.put("湖南省","7214");
		shmap.put("广东省","7216");
		shmap.put("广西壮族自治区","7218");
		shmap.put("海南省","7220");
		shmap.put("重庆市","7222");
		shmap.put("四川省","7224");
		shmap.put("贵州省","7226");
		shmap.put("云南省","7228");
		shmap.put("西藏自治区","7230");
		shmap.put("陕西省","7232");
		shmap.put("甘肃省","7234");
		shmap.put("青海省","7236");
		shmap.put("宁夏回族自治区","7238");
		shmap.put("新疆维吾尔族自治区","7240");
		shmap.put("新疆生产建设兵团","21508");

		shtype.put("请选择医院类别","");
		shtype.put("综合医院","综合医院");
		shtype.put("乡镇卫生院","乡镇卫生院");
		shtype.put("医学专科研究所","医学专科研究所");
		shtype.put("急救中心","急救中心");
		shtype.put("疗养院","疗养院");
		shtype.put("妇幼保健院","妇幼保健院");
		shtype.put("专科医院","专科医院");
		shtype.put("门诊部","门诊部");
		shtype.put("中西医结合医院","中西医结合医院");
		shtype.put("街道卫生院","街道卫生院");
		shtype.put("护理院(站)","护理院(站)");
		shtype.put("专科疾病防治所(站、中心)","专科疾病防治所(站、中心)");
		shtype.put("专科疾病防治院","专科疾病防治院");
		shtype.put("妇幼保健所","妇幼保健所");
		shtype.put("民族医院","民族医院");
		shtype.put("社区卫生服务中心","社区卫生服务中心");
		shtype.put("其他卫生事业机构","其他卫生事业机构");


		shlv.put("请选择医院等级","");
		shlv.put("二级","二级");
		shlv.put("二级二级","二级二级");
		shlv.put("二级甲等","二级甲等");
		shlv.put("二级乙等","二级乙等");
		shlv.put("二级丙等","二级丙等");
		shlv.put("二级未评","二级未评");
		shlv.put("二级其他","二级其他");
		shlv.put("三级甲等","三级甲等");
		shlv.put("三级乙等","三级乙等");
		shlv.put("三级未评","三级未评");
		shlv.put("三级其他","三级其他");
		shlv.put("三级未定等","三级未定等");

	}




	public ShopHospital(int id){
		this.id = id;
	}
	
	public static ShopHospital find(int id){
		ShopHospital aHospital = (ShopHospital)c.get(id);
		if(aHospital == null){
			ArrayList<ShopHospital> list = find(" AND id = " + id, 0, 1);
			aHospital = list.size() < 1 ? new ShopHospital(id):list.get(0);
		}
		return aHospital;
	}

	public static ShopHospital find(String name){
		ShopHospital aHospital = (ShopHospital)c.get(0);
		if(aHospital == null){
			ArrayList<ShopHospital> list = find(" AND name = " + Database.cite(name), 0, 1);
			aHospital = list.size() < 1 ? new ShopHospital(0):list.get(0);
		}
		return aHospital;
	}

	/**
	 * 根据医院和商品厂商查询开票单位
	 * @param productPuid
	 * @param hosid
	 * @return
	 */
	public static ShopHospital findPuid(int productPuid,int hosid){
		ShopHospital aHospital = (ShopHospital)c.get(0);
		if(aHospital == null){
			ArrayList<ShopHospital> list = find(" AND id = " + hosid+" AND productPuid = "+productPuid, 0, 1);
			aHospital = list.size() < 1 ? new ShopHospital(0):list.get(0);
		}
		return aHospital;
	}
	
	/**
	 * 查询医院多少天内资质将要到期
	 * @param id	医院ID
	 * @param day	天数
	 * @return shophospital
	 * */
	public static ShopHospital find(int id,int day){
		ShopHospital aHospital = new ShopHospital(0);
		ArrayList<ShopHospital> list = find(" AND id = " + id + " and expirationDate is not null and datediff(d,getdate(),expirationDate) >0 and datediff(d,getdate(),expirationDate) < " + day, 0, 1);
		aHospital = list.size() < 1 ? new ShopHospital(0):list.get(0);
		return aHospital;
	}
	
	/**
	 * 查询医院资质是否到期
	 * @param id	医院ID
	 * @return shophospital
	 * */
	public static ShopHospital findcheck(int id){
		ShopHospital aHospital = new ShopHospital(0);
		ArrayList<ShopHospital> list = find(" AND id = " + id + " and expirationDate is not null and datediff(d,getdate(),expirationDate) <0 ", 0, 1);
		aHospital = list.size() < 1 ? new ShopHospital(0):list.get(0);
		return aHospital;
	}
	
	public static ArrayList<ShopHospital> find(String sql,int pos,int size){
		ArrayList<ShopHospital> list = new ArrayList<ShopHospital>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,name,area,area_name,htype,hgrader,createtime,addflag,expirationDate,issign,noreplywarn,noreplyalarm,noinvoicewarn,noinvoicealarm,isstoporder,oldnoinvoice,oldnoreply,timespot,timespot2,oldisinvoice,oldnoreplynew,creplytime,namefile,h_code,upEmpower,vipEmpower,invoicePuid,productPuid,pid,hos_code,dep_code,hospiatl_name,departments_name,questionnum,fsaqxkz,fsaqxkzrq,fsxypsyxkz,fsxypsyxkzrq,fszlxkz,fszlxkzrq,zfspb,zfspbrq,bq1,bq2,bqmci,yjdhyy,yjdhlz,approvalProfile,approvalStatus,nobackreason from shopHospital where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopHospital h = new ShopHospital(rs.getInt(i++));
				h.setName(rs.getString(i++));
				h.setArea(rs.getString(i++));
				h.setArea_name(rs.getString(i++));
				h.setHtype(rs.getString(i++));
				h.setHgrader(rs.getString(i++));
				h.setCreatetime(rs.getDate(i++));
				h.setAddflag(rs.getInt(i++));
				h.setExpirationDate(rs.getDate(i++));
				h.setIssign(rs.getInt(i++));
				h.setNoreplywarn(rs.getInt(i++));
				h.setNoreplyalarm(rs.getInt(i++));
				h.setNoinvoicewarn(rs.getInt(i++));
				h.setNoinvoicealarm(rs.getInt(i++));
				h.setIsstoporder(rs.getInt(i++));
				h.setOldnoinvoice(rs.getInt(i++));
				h.setOldnoreply(rs.getDouble(i++));
				h.setTimespot(db.getDate(i++));
				h.setTimespot2(db.getDate(i++));
				h.setOldisinvoice(rs.getInt(i++));
				h.setOldnoreplynew(rs.getDouble(i++));
				h.setCreplytime(db.getDate(i++));
				h.setNamefile(rs.getInt(i++));
				h.setH_code(rs.getString(i++));
				h.setUpEmpower(rs.getInt(i++));
				h.setVipEmpower(rs.getInt(i++));
				h.setInvoicePuid(rs.getInt(i++));
				h.setProductPuid(rs.getInt(i++));
				h.setPid(rs.getInt(i++));
				h.setHos_code(rs.getString(i++));
				h.setDep_code(rs.getString(i++));
				h.setHospiatl_name(rs.getString(i++));
				h.setDepartments_name(rs.getString(i++));
				h.setQuestionnum(rs.getInt(i++));
				h.setFsaqxkz(rs.getInt(i++));
				h.setFsaqxkzrq(db.getDate(i++));
				h.setFsxypsyxkz(rs.getInt(i++));
				h.setFsxypsyxkzrq(db.getDate(i++));
				h.setFszlxkz(rs.getInt(i++));
				h.setFszlxkzrq(db.getDate(i++));
				h.setZfspb(rs.getInt(i++));
				h.setZfspbrq(db.getDate(i++));
				h.setBq1(rs.getString(i++));
				h.setBq2(rs.getInt(i++));
				h.setBqmci(rs.getFloat(i++));
				h.setYjdhyy(rs.getString(i++));
				h.setYjdhlz(rs.getString(i++));
				h.setApprovalProfile(rs.getInt(i++));
                h.setApprovalStatus(rs.getInt(i++));
                h.setNobackreason(rs.getString(i++));
				c.put(h.id, h);
				list.add(h);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from shophospital where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shophospital(id,name,area,area_name,htype,hgrader,createtime,addflag,expirationDate,issign,noreplywarn,noreplyalarm,noinvoicewarn,noinvoicealarm,isstoporder,oldnoinvoice,oldnoreply,timespot,timespot2,oldisinvoice,oldnoreplynew,creplytime,namefile,h_code,upEmpower,vipEmpower,invoicePuid,productPuid,pid,hos_code,dep_code,hospiatl_name,departments_name,questionnum,fsaqxkz,fsaqxkzrq,fsxypsyxkz,fsxypsyxkzrq,fszlxkz,fszlxkzrq,zfspb,zfspbrq,yjdhyy,yjdhlz,bq1,bq2,bqmci,approvalStatus,approvalProfile,nobackreason) values(" + (this.id = Seq.get()) + "," + DbAdapter.cite(this.name) + "," + DbAdapter.cite(this.area) + "," + DbAdapter.cite(this.area_name) + "," + DbAdapter.cite(this.htype) + "," + DbAdapter.cite(this.hgrader) + "," + DbAdapter.cite(this.createtime) + ","+addflag+ "," + DbAdapter.cite(this.expirationDate)+","+issign+","+this.noreplywarn+","+this.noreplyalarm+","+this.noinvoicewarn+","+this.noinvoicealarm+","+this.isstoporder+","+this.oldnoinvoice+","+this.oldnoreply+","+DbAdapter.cite(this.timespot)+","+DbAdapter.cite(this.timespot2)+","+oldisinvoice+","+oldnoreplynew+","+DbAdapter.cite(creplytime)+","+namefile+","+DbAdapter.cite(h_code)+","+upEmpower+","+vipEmpower+","+invoicePuid+","+productPuid+","+pid+","+Database.cite(hos_code)+","+Database.cite(dep_code)+","+Database.cite(hospiatl_name)+","+Database.cite(departments_name)+","+questionnum+","+fsaqxkz+","+Database.cite(fsaqxkzrq)+","+fsxypsyxkz+","+Database.cite(fsxypsyxkzrq)+","+fszlxkz+","+Database.cite(fszlxkzrq)+","+zfspb+","+Database.cite(zfspbrq)+","+Database.cite(yjdhyy)+","+Database.cite(yjdhlz)+","+Database.cite(bq1)+","+bq2+","+bqmci+","+approvalStatus+","+approvalProfile+","+Database.cite(nobackreason)+")";
		}else{
			sql = "update shophospital set name =" + DbAdapter.cite(this.name) + ",area = " + DbAdapter.cite(this.area) + ",area_name = " + DbAdapter.cite(this.area_name) + ",htype = " + DbAdapter.cite(this.htype) + ",hgrader = " + DbAdapter.cite(this.hgrader) + ",createtime = " + DbAdapter.cite(this.getCreatetime()) + ",addflag="+addflag + ",expirationDate = " + DbAdapter.cite(this.expirationDate)+",issign="+issign+",noreplywarn="+this.noreplywarn+",noreplyalarm="+this.noreplyalarm+",noinvoicewarn="+this.noinvoicewarn+",noinvoicealarm="+this.noinvoicealarm+",isstoporder="+this.isstoporder+",oldnoinvoice="+this.oldnoinvoice+",oldnoreply="+this.oldnoreply+",timespot="+DbAdapter.cite(this.timespot)+",timespot2="+DbAdapter.cite(this.timespot2)+",oldisinvoice="+this.oldisinvoice+",oldnoreplynew="+this.oldnoreplynew+",creplytime="+DbAdapter.cite(this.creplytime)+",namefile="+namefile+",h_code="+DbAdapter.cite(h_code)+",upEmpower="+upEmpower+",vipEmpower="+vipEmpower+",invoicePuid="+invoicePuid+",productPuid="+productPuid+",pid="+pid+",hos_code="+Database.cite(hos_code)+",dep_code="+Database.cite(dep_code)+",hospiatl_name="+Database.cite(hospiatl_name)+",departments_name="+Database.cite(departments_name)+",questionnum="+questionnum+",fsaqxkz="+fsaqxkz+", fsaqxkzrq="+Database.cite(fsaqxkzrq)+",fsxypsyxkz="+fsxypsyxkz+",fsxypsyxkzrq="+Database.cite(fsxypsyxkzrq)+",fszlxkz="+fszlxkz+",fszlxkzrq="+Database.cite(fszlxkzrq)+", zfspb="+zfspb+",zfspbrq="+Database.cite(zfspbrq)+",yjdhyy="+Database.cite(yjdhyy)+",yjdhlz="+Database.cite(yjdhlz)+",bq1="+Database.cite(bq1)+",bq2="+bq2+",bqmci="+bqmci+",approvalStatus="+approvalStatus+",approvalProfile="+approvalProfile+",nobackreason="+Database.cite(nobackreason)+" where id=" + this.id;
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
	
	public static void delete(int id){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id,"delete from shophospital where id= " + id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(id);
	}
	
	public void set(String column,String value){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update shophospital set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public void set(String field,Object value) throws SQLException
    {
        String str = null;
        if(value instanceof String)
        {
            str = DbAdapter.cite((String) value);
        } else if(value instanceof Date)
        {
            str = DbAdapter.cite((Date) value);
        } else if(value instanceof Boolean)
        {
            str = DbAdapter.cite(((Boolean) value).booleanValue());
        } else if(value != null)
        {
            str = DbAdapter.cite(value.toString());
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(this.id, "update shophospital set " + field + "=" + str + " where id=" + this.id);
        } finally
        {
            db.close();
        }
        c.remove(this.id);
    }
	
	//查找达到未完成开票粒子数预警值的医院
	public static List<Integer> findnoinvoicewarn() {
		List<Integer> lsthid=new ArrayList<Integer>();
		try {
			//先查找设置了未完成开票粒子数预警值的医院
			List<ShopHospital> lsth=ShopHospital.find(" and noinvoicewarn > 0 ", 0, Integer.MAX_VALUE);
			for(int i=0;i<lsth.size();i++){
				//遍历医院
				ShopHospital hospital=lsth.get(i);
				int hid=hospital.getId();
				//查找当前医院的订单的未开票数量
				int nonum=ShopOrder.sumnoinvoiquantity(" and status in(3,4,7) and order_id in( select order_id from shoporderdispatch where a_hospital_id="+hid+") and (isclear=0 or isclear is null)");
				ShopHospital hh=lsth.get(i);
				int nowarn=hh.getNoinvoicewarn();
				if(nonum>nowarn){
					lsthid.add(hid);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			return lsthid;
		}
		
		
	
	}
	
	
	
	//查找达到未完成开票粒子数报警值的医院
	public static List<Integer> findnoinvoicealarm() {
		List<Integer> lsthid=new ArrayList<Integer>();
		try {
			//先查找设置了未完成开票粒子数报警值的医院
			List<ShopHospital> lsth=ShopHospital.find(" and noinvoicealarm > 0 ", 0, Integer.MAX_VALUE);
			for(int i=0;i<lsth.size();i++){
				//遍历医院
				ShopHospital hospital=lsth.get(i);
				int hid=hospital.getId();
				//查找当前医院的订单的未开票数量
				int nonum=ShopOrder.sumnoinvoiquantity(" and status in(3,4,7) and order_id in( select order_id from shoporderdispatch where a_hospital_id="+hid+") and (isclear=0 or isclear is null)");
				ShopHospital hh=lsth.get(i);
				int noalarm=hh.getNoinvoicealarm();
				if(nonum>noalarm){
					lsthid.add(hid);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally{
			return lsthid;
		}
		
		
	
	}
	
	
	
	//查找达到未回款金额预警值的医院
	public static List<Integer> findnoreplywarn() {
		List<Integer> lsthid=new ArrayList<Integer>();
		try {
			//先查找设置了未回款金额预警值的医院
			List<ShopHospital> lsth=ShopHospital.find(" and noreplywarn > 0 ", 0, Integer.MAX_VALUE);
			for(int i=0;i<lsth.size();i++){
				//遍历医院
				ShopHospital hospital=lsth.get(i);
				int hid=hospital.getId();
				//已回款粒子数
				int num=ShopOrder.summatchnum(" and status in (3,4,7) and order_id in( select order_id from shoporderdispatch where a_hospital_id="+hid+") and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3))");
				//订单总粒数
				int totalnum=ShopOrderData.sumquantity(" and order_id in(select order_id from shoporder where status in (3,4,7) and order_id in( select order_id from shoporderdispatch where a_hospital_id="+hid+")and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3)))");
				int nonum=totalnum-num;//未回款粒子数
				float price=0;
				List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id in(select order_id from shoporderdispatch where a_hospital_id="+hid+")", 0, 1);
				if(lstdata.size()>0){
					ShopOrderData data=lstdata.get(0);
					price=data.getAgent_price();
				}
				//未回款金额
				float noamount=price*nonum;
				//未回款金额预警值
				float nowarn=hospital.getNoreplywarn();
				if(noamount>nowarn){
					lsthid.add(hid);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally{
			return lsthid;
		}
		
		
	
	}
	
	//查找达到未回款金额报警值的医院
	public static List<Integer> findnoreplyalarm() {

		List<Integer> lsthid=new ArrayList<Integer>();
		try {
			//先查找设置了未回款金额预警值的医院
			List<ShopHospital> lsth=ShopHospital.find(" and noreplyalarm > 0 ", 0, Integer.MAX_VALUE);
			for(int i=0;i<lsth.size();i++){
				//遍历医院
				ShopHospital hospital=lsth.get(i);
				int hid=hospital.getId();
				//已回款粒子数
				int num=ShopOrder.summatchnum(" and status in (3,4,7) and order_id in( select order_id from shoporderdispatch where a_hospital_id="+hid+") and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3))");
				//订单总粒数
				int totalnum=ShopOrderData.sumquantity(" and order_id in(select order_id from shoporder where status in (3,4,7) and order_id in( select order_id from shoporderdispatch where a_hospital_id="+hid+")and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3)))");
				int nonum=totalnum-num;//未回款粒子数
				float price=0;
				List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id in(select order_id from shoporderdispatch where a_hospital_id="+hid+")", 0, 1);
				if(lstdata.size()>0){
					ShopOrderData data=lstdata.get(0);
					price=data.getAgent_price();
				}
				//未回款金额
				float noamount=price*nonum;
				//未回款金额报警值
				float noalarm=hospital.getNoreplyalarm();
				if(noamount>noalarm){
					lsthid.add(hid);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally{
			return lsthid;
		}
		
		
	
	
	}

	//季度初改变问卷填写次数
	public static void updateQuestion() throws SQLException {
		Date date = new Date();
		int month = date.getMonth();
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		int datenum=c.get(Calendar.DATE);
		if(datenum==1) {//月初
			Filex.logs("QuestionTask.txt","月初");
			if (month == 0 || month == 3 || month == 6 || month == 9) {//季度初月份  1.1   4.1   7.1   10.1
				Filex.logs("QuestionTask.txt","季度初，改变医院问卷次数");
				ArrayList<ShopHospital> shopHospitals = ShopHospital.find("", 0, Integer.MAX_VALUE);
				for (int i = 0; i < shopHospitals.size(); i++) {
					ShopHospital hospital = shopHospitals.get(i);
					hospital.setQuestionnum(0);
					hospital.set();
				}
			}
		}

	}

	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getHtype() {
		return htype;
	}

	public void setHtype(String htype) {
		this.htype = htype;
	}

	public String getHgrader() {
		return hgrader;
	}

	public void setHgrader(String hgrader) {
		this.hgrader = hgrader;
	}

	public String getArea_name() {
		return area_name;
	}

	public void setArea_name(String areaName) {
		area_name = areaName;
	}

	public int getAddflag() {
		return addflag;
	}

	public void setAddflag(int addflag) {
		this.addflag = addflag;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public int getIssign() {
		return issign;
	}

	public void setIssign(int issign) {
		this.issign = issign;
	}

	public float getNoreplywarn() {
		return noreplywarn;
	}

	public void setNoreplywarn(float noreplywarn) {
		this.noreplywarn = noreplywarn;
	}

	public float getNoreplyalarm() {
		return noreplyalarm;
	}

	public void setNoreplyalarm(float noreplyalarm) {
		this.noreplyalarm = noreplyalarm;
	}

	public int getNoinvoicewarn() {
		return noinvoicewarn;
	}

	public void setNoinvoicewarn(int noinvoicewarn) {
		this.noinvoicewarn = noinvoicewarn;
	}

	public int getNoinvoicealarm() {
		return noinvoicealarm;
	}

	public void setNoinvoicealarm(int noinvoicealarm) {
		this.noinvoicealarm = noinvoicealarm;
	}

	public int getIsstoporder() {
		return isstoporder;
	}

	public void setIsstoporder(int isstoporder) {
		this.isstoporder = isstoporder;
	}

	public int getOldnoinvoice() {
		return oldnoinvoice;
	}

	public void setOldnoinvoice(int oldnoinvoice) {
		this.oldnoinvoice = oldnoinvoice;
	}

	public Double getOldnoreply() {
		return oldnoreply;
	}

	public void setOldnoreply(Double oldnoreply) {
		this.oldnoreply = oldnoreply;
	}

	public Date getTimespot() {
		return timespot;
	}

	public void setTimespot(Date timespot) {
		this.timespot = timespot;
	}

	public Date getTimespot2() {
		return timespot2;
	}

	public void setTimespot2(Date timespot2) {
		this.timespot2 = timespot2;
	}

	public int getOldisinvoice() {
		return oldisinvoice;
	}

	public void setOldisinvoice(int oldisinvoice) {
		this.oldisinvoice = oldisinvoice;
	}
	
	public static String getDecimal(Double a){
		String result=new DecimalFormat("0.0").format(a);
		return result;
	}

	public Double getOldnoreplynew() {
		return oldnoreplynew;
	}

	public void setOldnoreplynew(Double oldnoreplynew) {
		this.oldnoreplynew = oldnoreplynew;
	}

	public Date getCreplytime() {
		return creplytime;
	}

	public void setCreplytime(Date creplytime) {
		this.creplytime = creplytime;
	}

	public int getNamefile() {
		return namefile;
	}

	public void setNamefile(int namefile) {
		this.namefile = namefile;
	}

	public String getH_code() {
		return h_code;
	}

	public void setH_code(String h_code) {
		this.h_code = h_code;
	}


	public int getUpEmpower() {
		return upEmpower;
	}

	public void setUpEmpower(int upEmpower) {
		this.upEmpower = upEmpower;
	}

	public int getVipEmpower() {
		return vipEmpower;
	}

	public void setVipEmpower(int vipEmpower) {
		this.vipEmpower = vipEmpower;
	}

	public int getInvoicePuid() {
		return invoicePuid;
	}

	public void setInvoicePuid(int invoicePuid) {
		this.invoicePuid = invoicePuid;
	}

	public int getProductPuid() {
		return productPuid;
	}

	public void setProductPuid(int productPuid) {
		this.productPuid = productPuid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getHos_code() {
		return hos_code;
	}

	public void setHos_code(String hos_code) {
		this.hos_code = hos_code;
	}

	public String getDep_code() {
		return dep_code;
	}

	public void setDep_code(String dep_code) {
		this.dep_code = dep_code;
	}

	public String getHospiatl_name() {
		return hospiatl_name;
	}

	public void setHospiatl_name(String hospiatl_name) {
		this.hospiatl_name = hospiatl_name;
	}

	public String getDepartments_name() {
		return departments_name;
	}

	public void setDepartments_name(String departments_name) {
		this.departments_name = departments_name;
	}

	public int getQuestionnum() {
		return questionnum;
	}

	public void setQuestionnum(int questionnum) {
		this.questionnum = questionnum;
	}

	public int getFsaqxkz() {
		return fsaqxkz;
	}

	public void setFsaqxkz(int fsaqxkz) {
		this.fsaqxkz = fsaqxkz;
	}

	public int getFsxypsyxkz() {
		return fsxypsyxkz;
	}

	public void setFsxypsyxkz(int fsxypsyxkz) {
		this.fsxypsyxkz = fsxypsyxkz;
	}

	public int getFszlxkz() {
		return fszlxkz;
	}

	public void setFszlxkz(int fszlxkz) {
		this.fszlxkz = fszlxkz;
	}

	public int getZfspb() {
		return zfspb;
	}

	public void setZfspb(int zfspb) {
		this.zfspb = zfspb;
	}

	public Date getFsaqxkzrq() {
		return fsaqxkzrq;
	}

	public void setFsaqxkzrq(Date fsaqxkzrq) {
		this.fsaqxkzrq = fsaqxkzrq;
	}

	public Date getFsxypsyxkzrq() {
		return fsxypsyxkzrq;
	}

	public void setFsxypsyxkzrq(Date fsxypsyxkzrq) {
		this.fsxypsyxkzrq = fsxypsyxkzrq;
	}

	public Date getFszlxkzrq() {
		return fszlxkzrq;
	}

	public void setFszlxkzrq(Date fszlxkzrq) {
		this.fszlxkzrq = fszlxkzrq;
	}

	public Date getZfspbrq() {
		return zfspbrq;
	}

	public void setZfspbrq(Date zfspbrq) {
		this.zfspbrq = zfspbrq;
	}

	public String getYjdhyy() {
		return yjdhyy;
	}

	public void setYjdhyy(String yjdhyy) {
		this.yjdhyy = yjdhyy;
	}

	public String getYjdhlz() {
		return yjdhlz;
	}

	public void setYjdhlz(String yjdhlz) {
		this.yjdhlz = yjdhlz;
	}

	public String getBq1() {
		return bq1;
	}

	public void setBq1(String bq1) {
		this.bq1 = bq1;
	}

	public int getBq2() {
		return bq2;
	}

	public void setBq2(int bq2) {
		this.bq2 = bq2;
	}

	public float getBqmci() {
		return bqmci;
	}

	public void setBqmci(float bqmci) {
		this.bqmci = bqmci;
	}

    public int getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(int approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public int getApprovalProfile() {
        return approvalProfile;
    }

    public void setApprovalProfile(int approvalProfile) {
        this.approvalProfile = approvalProfile;
    }

	public String getNobackreason() {
		return nobackreason;
	}

	public void setNobackreason(String nobackreason) {
		this.nobackreason = nobackreason;
	}

	/*
	 *
	 * 根据   数字   小数点后几位  得到Bq   根据bq得到mci返回
	 * */
	public static float bqChangeMci(String bq1, int bq2) { //bq1  后移 bq2数值
		boolean isxs = bq1.contains(".");//是否是小数
		String[] split = bq1.split("\\.");
		int isxs1 = 0;
		if (isxs) {
			isxs1 = split[1].length();//小数点后几位
			if (bq2 <= isxs1) {//小数点后的数字  位数 大于等于 后面拼接的数字  返回错误
				return -1;
			}
		}
		for (int i = isxs1; i < bq2; i++) {
			bq1 = bq1 + "0";
		}
		//此时得到的是  bq1 是 A+B个0之后的数字
		bq1 = bq1.replace(".", "");
		Long bq = Long.valueOf(bq1);//得到Bq值
		float mci2 = bq / 27000000f;//Bq除以27000 000 得到Mci
		String result = String.format("%.1f", mci2);//mci四舍五入取小数点后一位

		return Float.valueOf(result);
	}

	/*
	 *
	 * 根据   数字   小数点后几位  得到Bq
	 * */
	public static String bqChangeBq(String bq1, int bq2) { //bq1  后移 bq2数值
		boolean isxs = bq1.contains(".");//是否是小数
		String[] split = bq1.split("\\.");
		int isxs1 = 0;
		if (isxs) {
			isxs1 = split[1].length();//小数点后几位
			if (bq2 <= isxs1) {//小数点后的数字  位数 大于等于 后面拼接的数字  返回错误
				return "";
			}
		}
		for (int i = isxs1; i < bq2; i++) {
			bq1 = bq1 + "0";
		}
		//此时得到的是  bq1 是 A+B个0之后的数字
		bq1 = bq1.replace(".", "");
		Long bq = Long.valueOf(bq1);//得到Bq值

		return bq+"";
	}


	/**
	 * 根据   数字   小数点后几位  得到Bq
	 * @param bqStr
	 * @return
	 */
	public static float getMciByBq(String bqStr) { //bq1  后移 bq2数值
		Long bq = Long.valueOf(bqStr);//得到Bq值
		float mci2 = bq / 37000000f;//Bq除以27000 000 得到Mci
		String result = String.format("%.1f", mci2);//mci四舍五入取小数点后一位
		return Float.valueOf(result);
	}


	/*
	* 告知哪个许可证还有30日到期。
	* */
	public static void SendMessage(){
		Date date = new Date();
		List<String>list = new ArrayList<>();
		for (int i = 0; i <31 ; i++) {
			if(i>0&&i%5==0){
				list.add(subDay(MT.f(date), i));
			}
		}
		System.out.println(list.toString());

		try {
            ArrayList arrayList = SMSMessage.find(" AND time>" + Database.cite(MT.f(date)) + " AND subnumber=1 ", 0, Integer.MAX_VALUE);
			Filex.logs("zizhitixing"," AND time>" + Database.cite(MT.f(date)) + " AND subnumber=1  结果："+arrayList.size());
            if(arrayList.size()>0){//今天发过了
                return;
            }
            String[] dqzjArr = {"辐射安全许可证","放射性药品使用许可证","放射诊疗许可证","转让审批表"};
            String[] daoqiriqiArr = {"fsaqxkzrq","fsxypsyxkzrq","fszlxkzrq","zfspbrq"};

			for (int k = 0; k < list.size(); k++) {
                String  subDay = list.get(k);
                for (int i = 0; i < 4; i++) {
                    ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND "+daoqiriqiArr[i]+" =" + Database.cite(MT.f(subDay)), 0, Integer.MAX_VALUE);
                    Filex.logs("zizhitixing"," AND "+daoqiriqiArr[i]+" =" + Database.cite(MT.f(subDay))+"  结果："+shopHospitals.size());
                    for (int j = 0; j <shopHospitals.size() ; j++) {
                        ShopHospital hospital = shopHospitals.get(j);
                        Filex.logs("zizhitixing",hospital.getName()+" "+dqzjArr[i]);
                        if(hospital.getYjdhyy()!=null) {
                            Filex.logs("zizhitixing","hospital.getYjdhyy()!=null");
                            if(hospital.getYjdhyy().length()==11) {
                                Filex.logs("zizhitixing","手机号对的");
                                SMSMessage.sendExpireMessage("Home", "amdin", hospital.getYjdhyy(), 1, hospital.getName() + "的" + dqzjArr[i] + " 还有30天到期。", 1);
                            }
                        }
                    }
                }
            }


        } catch (SQLException e) {


		}


	}

	public static String subDay(String strdate,int day){
		Date date = new Date();
		String dateresult = null; // 返回的日期字符串
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		GregorianCalendar gc = new GregorianCalendar();
		try {
			date = df.parse(strdate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		gc.setTime(date);
		gc.add(5, day);
		gc.set(gc.get(GregorianCalendar.YEAR), gc.get(GregorianCalendar.MONTH), gc.get(GregorianCalendar.DATE));
		dateresult = df.format(gc.getTime());
		return dateresult;
	}


	public static boolean checkHospitalZZ(int id){
	    Boolean after = true;
        ArrayList<Date> list = new ArrayList<>();
        ShopHospital hospital = ShopHospital.find(id);
        list.add(hospital.getFsaqxkzrq());
        list.add(hospital.getFsxypsyxkzrq());
        list.add(hospital.getFszlxkzrq());
        list.add(hospital.getZfspbrq());

        for (int i = 0; i < list.size(); i++) {
            Date date = list.get(i);
            if(date!=null){
                if(!date.after(new Date())){
                    return false;
                }

            }
        }
        return after;


    }

	public static String showBq(String bq){
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < bq.length(); i++) {
			sb.append(bq.substring(i,i+1));
			if(i==0||i%3==0){
				sb.append(",");
			}
		}
		return sb.toString();

	}





}
