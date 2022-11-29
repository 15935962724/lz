package tea.entity.custom.jjh;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.member.Educate;
import tea.entity.member.Profile;
import tea.entity.node.ListingDetail;
import tea.entity.node.Node;
import tea.entity.node.Resume;
import tea.entity.site.Occupation;
import tea.entity.util.Card;
import tea.html.Anchor;
import tea.html.Span;
import tea.resource.Common;
import tea.ui.TeaSession;

/*
 * 金融教育发展基金会   志愿者管理　
 * */
public class Volunteer {
	protected static Cache c=new Cache(50);
	public static final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	public static String[] nations=new String[]{"汉族","壮族","满族","回族","苗族","维吾尔族","土家族","彝族","蒙古族","藏族","布依族","侗族","瑶族","朝鲜族","白族","哈尼族","哈萨克族","黎族","傣族","畲族","傈僳族",
		"仡佬族","东乡族","高山族","拉祜族","水族","佤族","纳西族",
		"羌族","土族","仫佬族","锡伯族","柯尔克孜族","达斡尔族","景颇族",
		"毛南族","撒拉族","布朗族","塔吉克族","阿昌族","普米族","鄂温克族",
		"怒族","京族","基诺族","德昂族","保安族","俄罗斯族","裕固族",
		"乌兹别克族","门巴族","鄂伦春族","独龙族","塔塔尔族","赫哲族","珞巴族 "};
	private int vid;//id
	private int node;//node
	private String vname;//姓名
	private int vsex;//性别
	private int vnation;//民族
	private int vprovince;//省份
	private int vtype;//志愿者身份类型
	private String vnum;//身份证号
	private String vuwork;//所在单位
	private String vphone;//联系电话
	private Date vtime;//注册时间
	private int recycle;//已删除

	public Volunteer(int vid){
		this.vid=vid;
	}
	public Volunteer(int vid,int node,String vname,int vsex,int vnation,int vprovince,int vtype,String vnum,String vuwork,String vphone,Date vtime){
		this.vid=vid;
		this.node=node;
		this.vname=vname;
		this.vsex=vsex;
		this.vnation=vnation;
		this.vprovince=vprovince;
		this.vtype=vtype;
		this.vnum=vnum;
		this.vuwork=vuwork;
		this.vphone=vphone;
		this.vtime=vtime;
	}

	public static Volunteer getVolunteer(int vid) throws SQLException{
		Volunteer v=(Volunteer) c.get(vid);
		if(v==null){
			List list=findVolunteer(" AND vid="+vid,0,Integer.MAX_VALUE);
			if(list.size()>0){
				v=(Volunteer) list.get(0);
			}else{
				v=new Volunteer(vid);
			}
		}
		return v;
	}

	public static List findVolunteer(String sql,int page,int size) throws SQLException{
		List list=new ArrayList();
			DbAdapter db=new DbAdapter();
			try{
				ResultSet rs=db.executeQuery("SELECT vid,vname,vsex,vnation,vprovince,vtype,vnum,vuwork,vphone,vtime,node FROM hvolunteer WHERE 1=1 AND recycle<>9 "+sql, page, size);
				while(rs.next()){
					int i=1;
					int vid =rs.getInt(i++);
					String vname=rs.getString(i++);
					int vsex =rs.getInt(i++);
					int vnation =rs.getInt(i++);
					int vprovince =rs.getInt(i++);
					int vtype =rs.getInt(i++);
					String vnum=rs.getString(i++);
					String vuwork=rs.getString(i++);
					String vphone=rs.getString(i++);
					Date time=rs.getDate(i++);
					int node=rs.getInt(i++);
					Volunteer v=new Volunteer(vid,node,vname,vsex,vnation,vprovince,vtype,vnum,vuwork,vphone,time);
					list.add(v);
					c.put(vid,v);
				}
				rs.close();
			}finally{
				db.close();
			}

		return list;
	}
	public static Volunteer findVolunteer(int node) throws SQLException{
			Volunteer v;
			DbAdapter db=new DbAdapter();
			try{
				ResultSet rs=db.executeQuery("SELECT vid,vname,vsex,vnation,vprovince,vtype,vnum,vuwork,vphone,vtime,node FROM hvolunteer WHERE 1=1 AND recycle<>9 AND node = "+node,0,5);
				if(rs.next()){
					int i=1;
					int vid =rs.getInt(i++);
					String vname=rs.getString(i++);
					int vsex =rs.getInt(i++);
					int vnation =rs.getInt(i++);
					int vprovince =rs.getInt(i++);
					int vtype =rs.getInt(i++);
					String vnum=rs.getString(i++);
					String vuwork=rs.getString(i++);
					String vphone=rs.getString(i++);
					Date time=rs.getDate(i++);
					int nodes=rs.getInt(i++);
					v=new Volunteer(vid,nodes,vname,vsex,vnation,vprovince,vtype,vnum,vuwork,vphone,time);
				}else{
					v=new Volunteer(0);
				}
				rs.close();
			}finally{
				db.close();
			}

		return v;
	}
	public static int countVolunteer(String sql) throws SQLException{
		return DbAdapter.execute("SELECT COUNT(*) FROM hvolunteer WHERE 1=1  AND recycle<>9 "+sql);
	}

	public void delVolunteer() throws SQLException{
		this.setCol("recycle", "9");
	}
	public void setVolunteer() throws SQLException{
		DbAdapter db=new DbAdapter();
			try {
				if(getVid()<1){
					db.executeUpdate("INSERT INTO hvolunteer(node,vname,vsex,vnation,vprovince,vtype,vnum,vuwork,vphone,vtime,recycle) VALUES("+getNode()+","+db.cite(getVname())+","+getVsex()+","+getVnation()+","+getVprovince()+","+getVtype()+","+db.cite(getVnum())+","+db.cite(getVuwork())+","+db.cite(getVphone())+","+db.cite(getVtime())+",0);");
				}else{
					db.executeUpdate("UPDATE hvolunteer SET vname="+db.cite(getVname())+",vsex="+getVsex()+",vnation="+getVnation()+",vprovince="+getVprovince()+",vtype="+getVtype()+",vnum="+db.cite(getVnum())+",vuwork="+db.cite(getVuwork())+",vphone="+db.cite(getVphone())+",vtime="+db.cite(getVtime())+",recycle=0"+" WHERE vid="+getVid());
				}
			} finally{
				db.close();
				c.remove(getVid());
			}

	}

	public void setCol(String name,String value){
		DbAdapter db=new DbAdapter();
		try {
			db.executeUpdate("UPDATE hvolunteer SET "+name+" = "+value+" where vid="+getVid());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.close();
			c.remove(getVid());
		}

	}
	public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        Span span = null;
        StringBuilder content_sb = new StringBuilder();

        Volunteer v = Volunteer.findVolunteer(node._nNode);
        if(v.getVid()>0)
        {
            ListingDetail detail = ListingDetail.find(listing,96,h.language);;
            Iterator listingDetailEnumeration = detail.keys();
            while(listingDetailEnumeration.hasNext())
            {
                String itemname = (String) listingDetailEnumeration.next(),value = null;
                int istype = detail.getIstype(itemname);
                if(istype == 0)
                {
                    continue;
                }
                if(itemname.equals("vname"))
                {
                    value =v.getVname() ;
                } else if (itemname.equals("vprovince")){
                	if(v.getVprovince()==71){
    					value="台湾省";
    				}else if(v.getVprovince()==81){
    					value="香港特区";
    				}else if(v.getVprovince()==82){
    					value="澳门特区";
    				}else{
    					value=Card.find(v.getVprovince()).toString();
    				}
                } else if (itemname.equals("vsex")){
                	value=(v.getVsex()==0)?"男":"女";
                } else if (itemname.equals("vnation")){
                	value=nations[v.getVnation()-1];
                } else if (itemname.equals("vuwork")){
                	value=v.getVuwork();
                } else if (itemname.equals("vtime")){
                	if(v.getVtime()!=null){
                		value=sdf2.format(v.getVtime());
                	}else{
                		value="";
                	}
                } else if (itemname.equals("vtype")){
                	Voltype vt=Voltype.findVoltype(v.getVtype());
                	value=(vt.getVtname()==null)?"":vt.getVtname();
                }




                if(detail.getAnchor(itemname) != 0)
                {
                    Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/resume/" + node._nNode + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                } else
                {
                    span = new Span(value);
                }
                span.setId("ResumeID" + itemname);
                content_sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
            }
        }
        return content_sb.toString();
    }


	public int getVid() {
		return vid;
	}
	public void setVid(int vid) {
		this.vid = vid;
	}
	public String getVname() {
		return vname;
	}
	public void setVname(String vname) {
		this.vname = vname;
	}
	public int getVsex() {
		return vsex;
	}
	public void setVsex(int vsex) {
		this.vsex = vsex;
	}
	public int getVnation() {
		return vnation;
	}
	public void setVnation(int vnation) {
		this.vnation = vnation;
	}
	public int getVprovince() {
		return vprovince;
	}
	public void setVprovince(int vprovince) {
		this.vprovince = vprovince;
	}
	public int getVtype() {
		return vtype;
	}
	public void setVtype(int vtype) {
		this.vtype = vtype;
	}
	public String getVnum() {
		return vnum;
	}
	public void setVnum(String vnum) {
		this.vnum = vnum;
	}
	public String getVuwork() {
		return vuwork;
	}
	public void setVuwork(String vuwork) {
		this.vuwork = vuwork;
	}
	public String getVphone() {
		return vphone;
	}
	public void setVphone(String vphone) {
		this.vphone = vphone;
	}
	public Date getVtime() {
		return vtime;
	}
	public void setVtime(Date vtime) {
		this.vtime = vtime;
	}
	public int getNode() {
		return node;
	}
	public void setNode(int node) {
		this.node = node;
	}
}
