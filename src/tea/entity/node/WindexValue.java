package tea.entity.node;

import java.sql.*;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.*;
import tea.entity.Cache;

public class WindexValue {
	/**
	 * 紫外线指数 等级 紫外线照射强度 对人体可能影响 建议采取的防护措施 　　

       0-2    1   最弱    安全 可以不采取措施 　　

       3-4    2     弱      正常 外出戴防护帽或太阳镜 　　

       5-6    3   中等    注意 除戴防护帽和太阳镜外涂擦防晒霜(防晒霜SPF指数应不低于15) 　　

       7-9    4     强      较强 在上午十点至下午四点时段避免外出活动，外出时应尽可能在遮荫处 　　

      >10    5   很强    有害 尽量不外出，必须外出时，要采取一定的防护措施 　　
	 */
	private static Cache c=new Cache(100);
	private int id;
	private String nindex;//哪种指数(紫外线/其他)
	private int index;//指数等级
	private String indexName;//  最弱 弱
	private String scope ;//范围 3-4
	private String safe;//对人体可能影响
	private String content;//防护措施
	private boolean isexist;
	
	public WindexValue(){}
	
	public WindexValue(String nindex,int index) throws SQLException{
		this.nindex=nindex;
		this.index=index;
		load();
	}
	
	public static WindexValue find(String nindex,int index) throws SQLException{
		WindexValue wv=(WindexValue)c.get(new String(nindex+"_"+index));
		if(wv==null){
			wv=new WindexValue(nindex,index);
			c.put(new String(nindex+"_"+index), wv);
		}
		return wv;
	}
	
	public void load() throws SQLException{
		DbAdapter db=new DbAdapter();
		String value="";
		try{
			db.executeQuery("select indexName,scope,safe,`content` from WindexValue where nindex="+DbAdapter.cite(nindex)+" and `index`="+index);
			if(db.next()){
				int i=1;
				indexName=db.getString(i++);
				scope=db.getString(i++);
				safe=db.getString(i++);
				content=db.getString(i++);
				isexist=true;
			}else{
				isexist=false;
			}
		}finally{
			db.close();
		}
	}
	
	public static int getMaxIndex(String nindex,String sql){
		DbAdapter db=new DbAdapter();
		int index=0;
		try{
			db.executeQuery("select max(`index`) from WindexValue where nindex="+DbAdapter.cite(nindex)+sql);
			if(db.next()){
				index=db.getInt(1);
			}
		}finally{
			db.close();
			return index;
		}
	}
	
	public static int countIndex(String nindex){
		DbAdapter db=new DbAdapter();
		int count=0;
		try{
			db.executeQuery("select count(`index`) from WindexValue where `index`<100 and nindex="+DbAdapter.cite(nindex));
			if(db.next()){
				count=db.getInt(1);
			}
		}finally{
			db.close();
			return count;
		}
	}
	
	
	public static Enumeration findWindexValue(String sql,int pos,int size) throws SQLException{
		DbAdapter db=new DbAdapter();
		Vector v=new Vector();
		try{
			db.executeQuery("select nindex,`index` from WindexValue where 1=1 "+sql,pos,size);
			while(db.next()){
				v.addElement(new String(db.getString(1)+"_"+db.getInt(2)));
			}
		}finally{
			db.close();
			return v.elements();
		}
	}
	
	public static void set(String nindex,int index,String indexName,String scope,String safe,String content) throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeQuery("select indexName from WindexValue where nindex="+DbAdapter.cite(nindex)+" and `index`="+index);
			if(db.next()){
				db.executeUpdate("update WindexValue set indexName="+DbAdapter.cite(indexName)+",scope="+DbAdapter.cite(scope)+",safe="+DbAdapter.cite(safe)+",`content`="+DbAdapter.cite(content)+" where nindex="+DbAdapter.cite(nindex)+" and `index`="+index);
				c.remove(new String(nindex+"_"+index));
			}else{
				db.executeUpdate("insert into WindexValue(nindex,`index`,indexName,scope,safe,`content`) values ("+DbAdapter.cite(nindex)+","+index+","+DbAdapter.cite(indexName)+","+DbAdapter.cite(scope)+","+DbAdapter.cite(safe)+","+DbAdapter.cite(content)+")");
			}
		}finally{
			db.close();
		}
	}
	
	public static void delete(String nindex,int index) throws SQLException{
		DbAdapter db=new DbAdapter();
		try{
			db.executeUpdate("delete from WindexValue where   nindex="+DbAdapter.cite(nindex)+" and `index`="+index);
		}finally{
			c.remove(new String(nindex+"_"+index));
			db.close();
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNindex() {
		return nindex;
	}

	public void setNindex(String nindex) {
		this.nindex = nindex;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public String getIndexName() {
		if(indexName==null){
			return "";
		}
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public String getScope() {
		if(scope==null){
			return "";
		}
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	public String getSafe() {
		if(safe==null){
			return "";
		}
		return safe;
	}

	public void setSafe(String safe) {
		this.safe = safe;
	}

	public String getContent() {
		if(content==null){
			return "";
		}
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public boolean isExist(){
		return isexist;
	}
	
	
	
	
}
