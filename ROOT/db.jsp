<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.util.*" %><%@page import="java.text.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="java.io.*" %><%@page import="java.net.*" %><%@page import="tea.db.*" %>
<%@page import="java.sql.SQLException"%>

<%!

public void create(String sql) throws SQLException
{

	DbAdapter db = new DbAdapter(1);
	try
	{
		db.executeUpdate(sql);  
	}finally
	{
		db.close();	
	}

}

//获取元原始表的 多少个字段
public int count(String dbname) throws SQLException
{
	int c= 0;
	DbAdapter db = new DbAdapter();
	try
	{

		db.executeQuery(" select count(name) from syscolumns where id=(select id from sysobjects where name='"+dbname+"') 	 ");  
	if(db.next())
	{
		c = db.getInt(1);
	}

	}finally
	{
		db.close();	
	}
	return c;
	
}

//添加表字段

public String  create_table(String dbname)throws SQLException
{

	DbAdapter db = new DbAdapter();
	StringBuffer sql = new StringBuffer();
	sql.append("SELECT syscolumns.name,systypes.name,syscolumns.isnullable,syscolumns.length FROM syscolumns,systypes ");
	sql.append(" WHERE syscolumns.xusertype = systypes.xusertype AND syscolumns.id = object_id('"+dbname+"') ");

	StringBuffer sp = new StringBuffer();



	try 
	{
		
		sp.append("CREATE TABLE `"+dbname+"` ( ");
		db.executeQuery(sql.toString());
		for(int i =1;db.next();i++)
		{
		
			String name = db.getString(1);
			String nametype=db.getString(2);
			String isnullable=db.getString(3);
			String length =db.getString(4);
		

			
			if("nvarchar".equals(nametype))
			{
				nametype  = "varchar";
			}else if("ntext".equals(nametype))
			{
				nametype = "text";
			}else if("datetime".equals(nametype))
			{
				length = "0";
			}else if("image".equals(nametype))
			{
				nametype ="blob";
			}else if("money".equals(nametype))
			{
				nametype="double";
				length = "0";
				
			}
			
			sp.append(" `"+name+"`  "+nametype+"  ");
			
			if(!"0".equals(length))
			{
				sp.append("  ("+length+") ");
			}		
			
			if("0".equals(isnullable))
			{
				//不为null
				sp.append("  NOT NULL ");
			}else if("1".equals(isnullable))
			{
				sp.append("  default NULL ");
			}
			
			if(i!=this.count(dbname))
			{
				sp.append(",");
			}

		}
		sp.append(" ) ENGINE=InnoDB DEFAULT CHARSET=utf8;");
		
		
		
		this.create(sp.toString());
		
		
		
		
	}finally
	{
		db.close();	
	}
	
	return "1、用户表创建成功";
	
}

//添加条主键
public String create_key(String dbname)throws SQLException
{
	//获取原始库中 所以表
	 
	 
	 DbAdapter db = new DbAdapter();
	try
	{
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select syscolumns.name from syscolumns,sysobjects,sysindexes,sysindexkeys where syscolumns.id=object_id('"+dbname+"') ");
		sql.append(" and sysobjects.xtype='PK' AND sysobjects.parent_obj = syscolumns.id and sysindexes.id = syscolumns.id and sysobjects.name=sysindexes.name");
		sql.append(" and sysindexkeys.id=syscolumns.id and sysindexkeys.indid = sysindexes.indid and syscolumns.colid=sysindexkeys.colid");
		
		db.executeQuery(sql.toString());
		String s = "";
		while(db.next())
		{
			String name =db.getString(1);
			s =s+name+",";
			
		}
		
		 System.out.println("表索引："+s);
		 
		if(s!=null && s.length()>0){
			this.create(" Alter table "+dbname+" add primary key("+s.substring(0,s.length()-1)+"); ");
		}
			
	}finally
	{
		db.close();	
	}
	return "用户表主键创建成功";
}


//添加自增字段
public String create_change(String dbname)throws SQLException
{
	 
	 DbAdapter db = new DbAdapter();
	try
	{
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT name FROM syscolumns WHERE id = object_id('"+dbname+"') and COLUMNPROPERTY(id,name,'IsIdentity')=1");
		
		
		db.executeQuery(sql.toString());
		while(db.next())
		{
			String name =db.getString(1);
			
			
			if(!this.isPRI(dbname,name)) 
			{
				//如果没有主键，创建
				this.create(" Alter table "+dbname+" add primary key("+name+"); ");
				
			}
			this.create(" Alter table "+dbname+" change "+name+"  "+name+"  int  auto_increment  ");
		}
			
	}finally 
	{
		db.close();	
	}
	return "用户表字段自增创建成功";
}

//创建索引
public String create_pk(String dbname)throws SQLException
{
	
	StringBuffer sql = new StringBuffer();
	//AS [表名],AS [索引名称],AS [列名]
	sql.append("SELECT tab.name ,idx.name ,col.name FROM sys.indexes idx");
	sql.append(" JOIN sys.index_columns idxCol ON (idx.object_id = idxCol.object_id  AND idx.index_id = idxCol.index_id )");
	sql.append(" JOIN sys.tables tab ON (idx.object_id = tab.object_id)");
    sql.append(" JOIN sys.columns col ON (idx.object_id = col.object_id AND idxCol.column_id = col.column_id)");
    sql.append( "and tab.name = '"+dbname+"'  order by tab.name asc");


	DbAdapter db = new DbAdapter();
	try
	{
		db.executeQuery(sql.toString());
		while(db.next())
		{
			String tab_name = db.getString(1);
			String idx_name = db.getString(2);
			String col_name = db.getString(3);
			System.out.println(tab_name+"-"+idx_name+"-"+col_name);
			
			//创建普通索引
			String pkstr  =this.getmysqlPK(dbname,idx_name,col_name);
			int pkint = this.isPK(dbname,idx_name,col_name);
			if(pkint==0)
			{
				
				if(pkstr!=null && pkstr.length()>0)
				{
					this.create(" alter table "+dbname+" add index "+idx_name+" ("+pkstr+") ;");
				}else
				{
					this.create(" alter table "+dbname+" add index "+idx_name+" ("+col_name+") ;");
				}
				
				
			}else if(pkint==1)//唯一主键聚合
			{
				if(pkstr!=null && pkstr.length()>0)
				{
					this.create(" alter table "+dbname+" add unique "+idx_name+" ("+pkstr+") ;");
				}else
				{
					this.create(" alter table "+dbname+" add unique "+idx_name+" ("+col_name+") ;");
				}
				
			}else if(pkint==2)//唯一
			{
				if(pkstr!=null && pkstr.length()>0)
				{
					this.create(" alter table "+dbname+" add primary key "+idx_name+" ("+pkstr+") ;");
				}else
				{
					
					this.create(" alter table "+dbname+" add  primary key "+idx_name+" ("+col_name+") ;");
				}
				
			}

		}
		
	}finally
	{
		db.close();
	}
	
	return "索引创建完成";
}
//获取索引是否为主键唯一
public int isPK(String dbname,String pkname,String lname) throws SQLException
{
	StringBuffer sql = new StringBuffer();
	//--a.id  --AS 表名  AS 索引名称  AS 列名 AS 主键 AS 聚集  AS 唯一
	sql.append("SELECT TOP 100 PERCENT   ");
	sql.append(" CASE WHEN b.keyno = 1 THEN c.name ELSE c.name END ,  ");
	sql.append(" CASE WHEN b.keyno = 1 THEN a.name ELSE a.name END, d.name,  ");
	sql.append(" CASE WHEN p.id IS NULL  ");
	sql.append(" THEN '' ELSE '√' END , CASE INDEXPROPERTY(c.id, a.name, 'IsClustered')  ");
	sql.append(" WHEN 1 THEN '√' WHEN 0 THEN '' END , ");
	sql.append(" CASE INDEXPROPERTY(c.id,  ");
	sql.append(" a.name, 'IsUnique') WHEN 1 THEN '√' WHEN 0 THEN '' END ");
	sql.append(" FROM dbo.sysindexes a INNER JOIN  ");
	sql.append(" dbo.sysindexkeys b ON a.id = b.id AND a.indid = b.indid INNER JOIN  ");
	sql.append(" dbo.syscolumns d ON b.id = d.id AND b.colid = d.colid INNER JOIN  ");
	sql.append(" dbo.sysobjects c ON a.id = c.id AND c.xtype = 'U' LEFT OUTER JOIN  ");
	sql.append("dbo.sysobjects e ON e.name = a.name AND e.xtype = 'UQ' LEFT OUTER JOIN  ");
	sql.append(" dbo.sysobjects p ON p.name = a.name AND p.xtype = 'PK'  ");
	sql.append("WHERE (OBJECTPROPERTY(a.id, N'IsUserTable') = 1) AND (OBJECTPROPERTY(a.id,  ");
	sql.append(" N'IsMSShipped') = 0) AND (INDEXPROPERTY(a.id, a.name, 'IsAutoStatistics') = 0)  ");
	sql.append(" and c.name  = '"+dbname+"' ");
	sql.append(" ORDER BY c.name, a.name, b.keyno	 ");
	int f = 0;
	

	DbAdapter db = new DbAdapter();
	try
	{
		db.executeQuery(sql.toString());
		while(db.next())
		{
			String tab_name = db.getString(1);
			String idx_name = db.getString(2);
			String l_name = db.getString(3);
			String p = db.getString(4);
			String p2 = db.getString(5);
			String p3 = db.getString(6);
			
			if(pkname.equals(idx_name)&&lname.equals(l_name))//
			{
				if(p!=null &&p.length()>0 && p2!=null&&p2.length()>0 && p3!=null&&p3.length()>0)
				{
					f = 1;//唯一主键聚合
				}else if(p3!=null&&p3.length()>0) 
				{
					f = 2;//唯一
				}
			}
			
			
		}
		
	}finally
	{
		db.close();
	}
	
	return f;
	
}

//读取 mysql 数据库表的 索引 ，判断是否重名

public String getmysqlPK(String dbname,String keyname,String col_name)throws SQLException
{

		StringBuffer sp = new StringBuffer();
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("  show keys from   "+dbname + " where key_name = "+db.cite(keyname));
			System.out.println("  show keys from   "+dbname + " where key_name = "+db.cite(keyname));
			while(db.next())
			{
				
				String s1 = db.getString(1);
				String s2 = db.getString(2);
				String s3 = db.getString(3);
				String s4 = db.getString(4);
				String s5 = db.getString(5);
				String s6 = db.getString(6);
				
				
				//if(keyname.equals(s3))
				//{
					sp.append(s5+",");
				//}
				System.out.println(s5+"---");
				
				
			}
		}finally
		{
			db.close();
		}
		String sss=  sp.toString();
		if(sss!=null &&sss.length()>0)
		{
		
			String str = sss.substring((sss.length()-1),sss.length()).trim();
			
			if(str.indexOf(",")!=-1)
			{ 
				
				sss = sss.substring(0,(sss.length()-1));
			}
			
			sss = sss+","+col_name;
			
			this.create(" DROP INDEX "+keyname+" ON   "+dbname);
		}
		
		
		
		
		return sss;
}


//获取mysql主键

public boolean isPRI(String dbname,String lname)throws SQLException
{
	DbAdapter db = new DbAdapter(1);
	boolean f = false;
	try
	{
		db.executeQuery(" SHOW FIELDS FROM   "+dbname+" where Field = '"+lname+"' ");
		
		if(db.next())
		{
			
			String s1 = db.getString(1);
			String s2 = db.getString(2);
			String s3 = db.getString(3);
			String s4 = db.getString(4);
			String s5 = db.getString(5);
			String s6 = db.getString(6);
			
			 
			if("PRI".equals(s4))
			{
				f = true;
			}
			
			
		}
	}finally
	{
		db.close();
	}
	return f;

}

//获取mysql 已经存在的表
public boolean isMysqltableName(String tablename)throws	 SQLException
{
	DbAdapter db = new DbAdapter(1);
	boolean f= false;
	
	if(tablename!=null && tablename.length()>0)
	{
		tablename = tablename.toLowerCase();
	}
	 
	//System.out.println(tablename);
	 
	try
	{
		db.executeQuery(" SHOW TABLES WHERE tables_in_ednmysql =  "+db.cite(tablename));
		//System.out.println(" SHOW TABLES WHERE tables_in_ednmysql =  "+db.cite(tablename));
		
		if(db.next())
		{
			f = true;
		}
		/*
		for(int i=1;db.next();i++)
		{
			String dbname = db.getString(1);
			
			if(tablename.equals(dbname))
			{
				f = true;
			}
		}
		*/
		
	}finally
	{
		db.close();	
	}	
	return f;
}

//修改mysql的表字段text类型
public void updateType(String dbname,String field)throws	 SQLException
{
	DbAdapter db = new DbAdapter(1);
	
	try
	{
		db.executeUpdate(" ALTER TABLE "+dbname+" modify column "+field+" text ");
	
	
		 
	}finally
	{
		db.close();	
	}	

}



%> 
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link type="text/css" rel="stylesheet" href="/tea/community.css">
<script type="text/javascript" src="/tea/tea.js"></script>
</head>
<body>
<span id="show">等待....</span>
<% 

/*
//原始表
DbAdapter db = new DbAdapter();
try
{
	db.executeQuery(" SELECT name FROM sysobjects WHERE xtype='U'  ORDER BY name ");
	for(int i=1;db.next();i++)
	{
		String dbname = db.getString(1);
		System.out.println(i+":"+dbname);

		
		//导入数据结构
		if(isMysqltableName(dbname))
		{
			continue;
		}
		
	
		if(!"sysdiagrams".equals(dbname)){
			out.println(i+":"+dbname);	
			out.print("<br>");
			
			out.println(create_table(dbname));
			out.print("<br>");
			out.println(create_key(dbname));
			out.print("<br>");
			out.println(create_change(dbname));
			out.print("<br>");
			out.println(create_pk(dbname));
			out.print("<br><hr><br>");
			
			 out.write("<script>document.getElementById('show').innerHTML='"+i+"：表："+dbname+"'</script>");
				
				
			 out.flush(); 
		}
		
	}
	
}finally
{
	db.close();	
}
*/


DbAdapter db = new DbAdapter();
try
{
	db.executeQuery(" SHOW TABLES  ");
	for(int i=1;db.next();i++)
	{
		String dbname = db.getString(1);
		//System.out.println(i+":"+dbname);

		DbAdapter db2 = new DbAdapter();
		try
		{
				//修改字段
				db2.executeQuery("SHOW COLUMNS FROM "+dbname);
				while(db2.next())
				{
					String field = db2.getString(1);
					String type = db2.getString(2);
					
					if("tinytext".equals(type))
					{
						System.out.println(dbname+"--"+field+"--"+type);
						
						this.updateType(dbname,field);
						
						
						
						
					}
					
					
					
				}
			}finally
			{
				db2.close();	
			}

			
	}
	
}finally
{
	db.close();	
}



 
//out.print( this.create_pk("Node"));

 
//System.out.println(!isMysqltableName("AccessMember"));




%>
</body>

</html>