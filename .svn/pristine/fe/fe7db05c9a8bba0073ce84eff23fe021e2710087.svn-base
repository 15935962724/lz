package tea.entity.node;

import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.ui.Utils;

public class Subject {
	protected static Cache cache=new Cache(100);
	private int sid;
	private int node;
	private int language;
	private boolean exists;
	private String unit;//课题单位
	private String members;//课题组成员
	
	public Subject(){}
	public Subject(int node,int language) throws SQLException{
		this.node=node;
		this.language=language;
		load();
	}
	
	public static Subject find(int node,int language) throws SQLException{
		Subject subject=(Subject)cache.get(new String(node+"-"+language));
		if(subject==null){
			subject = new Subject(node,language);
			cache.put(new String(node+"-"+language), subject);
		}
		return subject;
	}
	private  void load() throws SQLException{
		
		String sql="SELECT sid,unit,members FROM Subject WHERE node="+node+" AND language="+language;
		DbAdapter db=new DbAdapter();
		try{
			db.executeQuery(sql);
			if(db.next()){
				int i=1;
				this.sid=db.getInt(i++);
				this.unit=db.getString(i++);
				this.members=db.getString(i++);
				this.exists=true;
			}else{
				this.exists=false;
			}
		}finally{
			db.close();
		}
	} 
	public void set() throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeQuery("SELECT * FROM Subject WHERE node="+node+" AND language="+language);
			if(db.next()){
				cache.remove(new String(this.node+"-"+this.language));
				db.executeUpdate("UPDATE Subject SET  unit="+DbAdapter.cite(this.unit)+", members="+DbAdapter.cite(this.members)+" WHERE node="+node +" AND  language="+language);
				this.exists=true;
			}else{
				db.executeUpdate("INSERT INTO Subject(node,language,unit,members) VALUES("+this.node+","+this.language+","+DbAdapter.cite(this.unit)+","+DbAdapter.cite(this.members)+")");
				this.exists=true;
			}
		}finally{
			db.close();
			
		}
	}
	
	public void delete() throws SQLException{
		String mssql="DELETE FROM Subject WHERE node= "+this.node+" AND language="+this.language;
		DbAdapter db=new DbAdapter();
		try{
		db.executeUpdate(mssql);
		}finally{
			cache.remove(new String(this.node+"-"+this.language));
			db.close();
		}
	}
	
	public static int count(String sql) throws SQLException{
		String mssql="SELECT COUNT(*) FROM Subject WHERE 1=1 "+sql;
		return DbAdapter.execute(mssql);
	}
	
	public static Enumeration findSubjects(String sql,int page,int size) throws SQLException{
		String mssql="SELECT node,language FROM Subject WHERE 1=1 "+sql;
		DbAdapter db=new DbAdapter();
		Vector v=new Vector();
		db.executeQuery(mssql, page, size);
		try{
			while(db.next()){
				v.addElement(new String(db.getInt(1)+"-"+db.getInt(2)));
			}
		}finally{
			db.close();
		}
		return v.elements();
	}
	
	public static String  getDetail(Node node,int listing,String target,Http h) throws SQLException{
		StringBuffer sb=new StringBuffer();
		Subject subject=Subject.find(node._nNode, h.language);
		String title=node.getSubject(h.language);
		ListingDetail detail=ListingDetail.find(listing, 109, h.language);
		Iterator it=detail.keys();
		while(it.hasNext()){
			String name=(String)it.next(),value=null;
			int type=detail.getIstype(name);
			if(type==0){
				continue;
			}
			String url="/"+(h.status==1?"xhtml":"html")+"/"+h.community+"/Subject/"+node._nNode+"-"+h.language+".htm";
			String bt=detail.getBeforeItem(name),at=detail.getAfterItem(name);
			if("name".equals(name)){
				value=title;
			}else if("keywords".equals(name)){
				value=node.getKeywords(h.language);
			}else if("abstract".equals(name)){
				value=node.getDescription(h.language);
			}else if("unit".equals(name)){
				value=subject.getUnit();
			}else if("team".equals(name)){
				value=subject.getMembers();
			}else if("mainbody".equals(name)){
				value=node.getText(h.language);
			}else if("attachment".equals(name)){
				StringBuffer filesf=new StringBuffer();
				String file=node.getFile(h.language);
				if(file!=null&&file.length()>1){
					String[] files=file.split("[|]");
					for(int i=1;i<files.length;i++){
						filesf.append("<span class='filesf'>").append(Utils.f(files[i])).append("</span>");
					}
					value=filesf.toString();
				}
			}
			
			
			if(value==null){
				value="";
			}
			if(type==2&&value.length()==0){
				continue;
			}
			
			value=detail.getOptionsToHtml(name, node, value);
			if(detail.getAnchor(name)!=0){
				value="<a href='"+url+"' target='"+target+"' title='"+title.replace('"', '\'')+"' >"+value+"</a>";
			}
			sb.append(bt).append("<span id='SubjectID"+name+"' >").append(value).append("</span>").append(at);
		}
		return sb.toString();
	}
	
	public boolean isExists(){
		return exists;
	}
	public int getLanguage() {
		return language;
	}

	public void setLanguage(int language) {
		this.language = language;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public int getNode() {
		return node;
	}
	public void setNode(int node) {
		this.node = node;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getMembers() {
		return members;
	}
	public void setMembers(String members) {
		this.members = members;
	}
}
