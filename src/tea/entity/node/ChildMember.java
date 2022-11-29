package tea.entity.node;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;

public class ChildMember {
	private String mid;
	private String member;// 用户名
	private String password;//密码
	private String fname;//姓名
	private int sex;//性别
	private String unitname;//	单位全称
	private String position;//	职务
	private Date birth;//	出生日期
	private String email;//	邮箱
	private String mobile;//	手机号
	private String qq;//	qq号
	private String phone;//	办公电话
	private Date time ;//注册时间
	private Date ltime1;//上次登录时间
	private int isclearPwd;//是否已清空密码
	private int membertype;//是否通过审核
	private int language;
	private boolean isExist;
	public static final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

	static Cache c=new Cache(100);

	public static ChildMember findChildMember(String member,int language)throws SQLException{
		if(member==null){
			member="";
		}
		ChildMember cm=(ChildMember) c.get(member);
		if(cm==null||(!cm.isExist())){
			cm=new ChildMember(member,language);
			c.put(member, cm);
		}
		return cm;
	}

	public ChildMember(String member,int language)throws SQLException{
		this.member=member;
		this.language=language;
		load();
	}
	public void load() throws SQLException{
		DbAdapter db=new DbAdapter();
		StringBuffer sb=new StringBuffer();
		sb.append("select p.profile,p.member,p.password,p.email,p.birth,p.mobile,p.sex,p.msnid,p.time,p.ltime1,p.isclearPwd,p.membertype from Profile p  where  p.member= "+db.cite(this.member));
		try{
			db.executeQuery(sb.toString());
			int i=1;
			if(db.next()){
				this.mid=db.getString(i++);
				this.member=db.getString(i++);
				this.password=db.getString(i++);
				this.email=db.getString(i++);
				this.birth=db.getDate(i++);
				this.mobile=db.getString(i++);
				this.sex=db.getInt(i++);
				this.qq=db.getString(i++);
				this.time=db.getDate(i++);
				this.ltime1=db.getDate(i++);
				this.isclearPwd=db.getInt(i++);
				this.membertype=db.getInt(i++);
				db.executeQuery("select  pl.firstname,pl.telephone,pl.unitname,pl.position from ProfileLayer pl where pl.member= "+db.cite(this.member)+" and pl.language="+ this.language);
				if(db.next()){
					int j=1;
					this.fname=db.getString(j++);
					this.phone=db.getString(j++);
					this.unitname=db.getString(j++);
					this.position=db.getString(j++);
				}

				this.isExist=true;
			}else{
				this.isExist=false;
			}
		}finally{
			db.close();
		}
	}


	public static int create(String member,String password,String community,String fname,int sex,String unitname,String position,Date birth,String email,String mobile,String qq,String phone,int language,Date time) throws SQLException{
		StringBuffer sb1=new StringBuffer();
		StringBuffer sb2=new StringBuffer();
		int newid=Seq.get();
		DbAdapter db=new DbAdapter();
		try{
		sb1.append("INSERT INTO Profile(profile,member,password,community,email,birth,mobile,sex,msnid,time,membertype)VALUES(").append(newid+","+db.cite(member)+",")
		.append(db.cite(password)+",")
		.append(db.cite(community)+",")
		.append(db.cite(email)+",")
		.append(db.cite(birth)+",")
		.append(db.cite(mobile)+",")
		.append(sex+",")
		.append(db.cite(qq)+",")
		.append(db.cite(time))
		.append(",5)");

		sb2.append("INSERT INTO ProfileLayer(member,language,firstname,telephone,unitname,position)VALUES(")
		.append(db.cite(member)+",")
		.append(language+",")
		.append(db.cite(fname)+",")
		.append(db.cite(phone)+",")
		.append(db.cite(unitname)+",")
		.append(db.cite(position))
		.append(")");
		db.executeUpdate(sb1.toString());
		db.executeUpdate(sb2.toString());
		}finally{
			db.close();
		}
		return newid;
	}
	public void set(String password,String community,String fname,int sex,String unitname,String position,Date birth,String email,String mobile,String qq,String phone,int language) throws SQLException{
		StringBuffer sb1=new StringBuffer();
		StringBuffer sb2=new StringBuffer();
		StringBuffer sb3=new StringBuffer();
		DbAdapter db=new DbAdapter();
		try{
		sb1.append("Update Profile set ").append("password="+db.cite(password)+",")
		//.append("community="+db.cite(community)+",")
		.append("email="+db.cite(email)+",")
		.append("birth="+db.cite(birth)+",").append("mobile="+db.cite(mobile)+",")
		.append("sex="+sex+",").append("code="+db.cite(this.member)+",").append("msnid="+db.cite(qq)).append(" where member="+db.cite(this.member));

		sb2.append("update ProfileLayer set ")
		.append("firstname="+db.cite(fname)+",").append("telephone="+db.cite(phone)+",")
		.append("unitname="+db.cite(unitname)+",").append("position="+db.cite(position)).append(" where member="+db.cite(this.member)).append(" and language="+language);
		db.executeUpdate(sb1.toString());
		db.executeQuery("select member from ProfileLayer where member="+db.cite(this.member)+" and language="+language);
		if(db.next()){
			db.executeUpdate(sb2.toString());
		}else{
			sb3.append("INSERT INTO ProfileLayer(member,language,firstname,telephone,unitname,position)VALUES(")
			.append(db.cite(member)+",")
			.append(language+",")
			.append(db.cite(fname)+",")
			.append(db.cite(phone)+",")
			.append(db.cite(unitname)+",")
			.append(db.cite(position))
			.append(")");
			db.executeUpdate(sb3.toString());
		}
		}finally{
			db.close();
			c.remove(member);
		}
	}

	public void setValue(String name ,String value)throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeUpdate("update profile set "+name+" = "+db.cite(value)+" where member="+db.cite(this.member));
		}finally{
			db.close();
			c.remove(member);
		}
	}

	public void setPwd(String name ,String value)throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeUpdate("update profile set "+name+" = "+db.cite(value)+",isclearPwd=0  where member="+db.cite(this.member));
		}finally{
			db.close();
			c.remove(member);
		}
	}

	public boolean clearPwd()throws SQLException{
		DbAdapter db=new DbAdapter();
		boolean thing=false;
		try{
			db.executeUpdate("update profile set password ='', isclearPwd=1 where member="+db.cite(this.member));
			thing=true;
		}finally{
			db.close();
			c.remove(member);
		}
		return thing;
	}


	public static void delete(String member,String community)throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeQuery("select count(*) from ProfileLayer where member="+db.cite(member));
			if(db.next()){
				db.executeUpdate("delete from ProfileLayer where member="+db.cite(member));
			}
			db.executeUpdate("delete from Profile where member="+db.cite(member));
		}finally{
			db.close();
			c.remove(member);
		}
	}
	//未审核 5 通过的3  未通过的9
	public boolean audit(int type,String member,Date time)throws SQLException{
		DbAdapter db=new DbAdapter();
		boolean thing=false;
		try{
			db.executeUpdate("update profile set membertype ="+type+", verifgmember="+db.cite(member)+", verifgtime="+db.cite(time)+" where member="+db.cite(this.member));
			thing=true;
		}finally{
			db.close();
			c.remove(this.member);
		}
		return thing;
	}
	public boolean getMembertype(){
		return this.membertype==3||this.membertype==1;
	}
	public String getMembertypes(){
		if(membertype==3){
			return "审核已通过";
		}else if(membertype==9){
			return "审核未通过";
		}else {
			return "审核中";

		}
	}

	public static boolean isExistChild(String member)throws SQLException{
		DbAdapter db=new DbAdapter();
		boolean thing=false;
		try{
			db.executeQuery("select member from Profile where member="+db.cite(member));
			if(db.next()){
				thing= true;
			}
		}finally{
			db.close();
		}
		return thing;
	}

	public static Enumeration find(String community,String sql,int page ,int size)throws SQLException{
		DbAdapter db=new DbAdapter();
		Vector  v=new Vector();
		try{
			db.executeQuery("select member from Profile where community ="+db.cite(community)+sql, page, size);
			while(db.next()){
				v.addElement(db.getString(1));
			}
		}finally{
			db.close();
		}
		return v.elements();
	}

	public static int  count(String community,String sql)throws SQLException{
		DbAdapter db=new DbAdapter();
		int count=0;
		try{
			db.executeQuery("select count(member) from Profile where community ="+db.cite(community)+sql);
			if(db.next()){
				count=db.getInt(1);
			}
		}finally{
			db.close();
		}
		return count;
	}

	public boolean isExist(){
		return this.isExist;
	}
	public boolean isclearPwd(){
		return isclearPwd==1;
	}

	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMember() {
		return member;
	}
	public void setMember(String member) {
		this.member = member;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFname() {
		if(fname!=null){
			return fname;
		}else{
			return "";
		}
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public boolean getSex() {
		return sex==1;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getUnitname() {
		if(unitname!=null){
			return unitname;
		}else{
			return "";
		}
	}
	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}
	public String getPosition() {
		if(position!=null){
			return position;
		}else{
			return "";
		}
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getBirth() {
		if(birth!=null){
			return sdf2.format(birth);
		}else{
			return "";
		}
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getTime() {
		if(time!=null){
			return sdf2.format(time);
		}else{
			return "";
		}
	}
	public void setTime(Date time) {
		this.time = time;
	}

	public String getLtime1() {
		if(ltime1!=null){
			return sdf2.format(ltime1);
		}else{
			return "";
		}
	}
	public void setLtime1(Date time) {
		this.ltime1 = time;
	}

	public String getEmail() {
		if(email!=null){
			return email;
		}else{
			return "";
		}
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		if(mobile!=null){
			return mobile;
		}else{
			return "";
		}
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getQq() {
		if(qq!=null){
			return qq;
		}else{
			return "";
		}
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getPhone() {
		if(phone!=null){
			return phone;
		}else{
			return "";
		}
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}


}
