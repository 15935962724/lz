<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Date"%>
<%@page import ="java.sql.SQLException" %>
<%!

public String getAAA(int id ,String str) throws SQLException
{
	tea.db.DbAdapter dbss = new tea.db.DbAdapter(4);
	String s = null;
	try
	{
		dbss.executeQuery("SELECT stringvalue FROM TBL_ARTICLE_EXTENDATTR WHERE articleid = "+id+" and ename ="+dbss.cite(str));
		while(dbss.next())
		{
			s = dbss.getString(1);
		}
	}finally 
	{
		dbss.close();
	}
	return s;
}

%>
<%



TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}


/*
//统一把创建者修改成编辑 
DbAdapter db=new DbAdapter(); 
try
{
	db.executeQuery("select node from Node where  type = 39 ");
	int i = 1;
	while(db.next())
	{
		int nid = db.getInt(1);
		Node nobj = Node.find(nid);
		 Report robj = Report.find(nid);
		 if(robj.getEditmember(teasession._nLanguage)!=null && robj.getEditmember(teasession._nLanguage).length()>0)
		 {}else
		 {
			 robj.setEditmember(nobj.getCreator()._strR,teasession._nLanguage);
		 }
		 System.out.println(i+":node:"+nid+":"+nobj.getCreator()._strR);
		i++;
	}
}finally
{
	db.close();
}*/
 
//导入程序

DbAdapter db=new DbAdapter(4);

try
{
  db.executeQuery(" select columnid,maintitle,vicetitle,summary,keyword,source,content,author,publishtime,createdate,lastupdated,dirname,editor,articletype,id from TBL_ARTICLE where createdate > TO_DATE('2010-07-24','YYYY-MM-DD') ");
  int i =1;
  while(db.next())
  {
	  int node = 540;//父亲节点
	  
	  int columnid=db.getInt(1);//新闻栏目表的id
	  
	  String maintitle=db.getString(2);//主题
	  
	 
	  String vicetitle = db.getString(3);//副标题
	  
	  String summary =db.getString(4);//摘要
	  String keyword=db.getString(5);//关键字
	  String source = db.getString(6);//来源
	  

	  String content =db.getText(7);//内容
	  
	  String author = db.getString(8);//作者
	  Date publishtime = db.getDate(9);//发布时间、
	  Date createdate = db.getDate(10);//创建时间
	  Date lastupdate = db.getDate(11);//最后更新时间
	  
	  System.out.println(createdate);
	  
	  String dirname =db.getString(12);//新闻路径
	  
	  String editor = db.getString(13);//编辑
	  
	  int articletype = db.getInt(14);//类型  0 无     1    原创    2  转载    3  翻译 
	  
	  int arid = db.getInt(15);
	  
	  //副标题
	  String vtpic = "";
	  if(vicetitle!=null && vicetitle.length()>0&&vicetitle.indexOf("pic")!=-1)//说明是图片
	  {
		  vtpic=dirname+"images/"+vicetitle; 
		  vicetitle = "";
	  }
	  String _no = "";//图片编号
	  //作者
	  if(author!=null&&author.length()>0)
	  {}else
	  {
		  author= this.getAAA(arid,"_author");
		  if(author!=null && author.length()>0){}
		  else{
			  author =   this.getAAA(arid,"_sheying");//摄影的 记者
			  if(this.getAAA(arid,"_time")!=null && this.getAAA(arid,"_time").length()>0)
			  {
			  	publishtime = Node.sdf2.parse(this.getAAA(arid,"_time"));//摄影时间 
			  }
			  _no = this.getAAA(arid,"_no");//图片编号 
		  }
	  }
		//来源
		if(source!=null && source.length()>0)
		{
			if(source.indexOf("pic")!=-1)
			{
				source = dirname+"images/"+source;
			}else if(source.indexOf(".flv")!=-1)
			{
				source = dirname+"images/"+source;
			}
		}
		
		String p1 = this.getAAA(arid,"_bigpic");//大图
		String p2 = this.getAAA(arid,"_pic");//中图
		String p3 = this.getAAA(arid,"_smallpic");//小图
		String picfile = null;
		
		if(p1!=null && p1.length()>0)
		{
			picfile= dirname+"images/"+p1;
		}else if(p2!=null && p2.length()>0)
		{
			picfile=dirname+"images/"+p2;
		}else if(p3!=null && p3.length()>0)
		{
			picfile=dirname+"images/"+p3; 
		}
		//编辑
		if(this.getAAA(arid,"_articleeditor")!=null && this.getAAA(arid,"_articleeditor").length()>0 )
		{
			editor = this.getAAA(arid,"_articleeditor");
		}
		
		//注释 当成内容来显示
		if(content!=null&&content.length()>0)
		{
			content = content.replaceAll("\"<HTML>","");
			content = content.replaceAll("<HEAD>","");
			content = content.replaceAll("<META NAME=\"GENERATOR\" Content=\"Microsoft DHTML Editing Control\">","");
			content = content.replaceAll("<TITLE></TITLE>","");
			content = content.replaceAll("</HEAD>","");
			content = content.replaceAll("<BODY>","");
			content = content.replaceAll("</BODY>","");
			content = content.replaceAll("</HTML>\"","");
		}
		//摘要首页摘要：
		
		String zy = this.getAAA(arid,"_zy");
		
	  

	  
	  
		// System.out.println(i+":"+zuozhe+"::"+laiyuan+"::::::::::"+picfile);

	 String sss=null;
  
	  for(int is=1;is<dirname.split("/").length;is++)
	  {
		  String cp = dirname.split("/")[is];
		  
		  if(is==dirname.split("/").length-1)//类别
		  {
			//添加类别 
				
			  java.util.Enumeration e = Node.find(" and type =1 and node in (select node from NodeLayer where  subject = "+DbAdapter.cite(cp)+") and path like '%/540/%' ",0,Integer.MAX_VALUE);
			  if(!e.hasMoreElements())
			  { 

				  node = Node.create(node, 10, teasession._strCommunity,teasession._rv , 1,false, 1308655680, 0, 1, null, null, new Date(),  0,  node,  2, 0, null, null, 1, cp,  
						  null, null, null, null, null,0, null, null, null,  null ,null, null, null);
				  Category cobj = Category.find(node);
				  cobj.set(39,0,0,null);
				  Node.find(node).finished(node);
				  
			  } 
			  while(e.hasMoreElements())
			  {
				  int nid = ((Integer)e.nextElement()).intValue();
				  node = nid;
			  }
 
		  }else //finished  
		  {
			  //添加文件夹
			    
			  java.util.Enumeration e = Node.find(" and type =0 and node in (select node from NodeLayer where  subject = "+DbAdapter.cite(cp)+") and path like '%/540/%' ",0,Integer.MAX_VALUE);
			  if(!e.hasMoreElements())
			  { 

				 node = Node.create(node, 120, teasession._strCommunity,teasession._rv , 0,false, 1308655680, 0, 1, null, null, new Date(),  0,  node,  2, 0, 
						 null, null, 1, cp,  null, null, null, null,null, 0, null, null, null,  null ,null, null, null);
				  Node.find(node).finished(node);
			  }
			  while(e.hasMoreElements())
			  {
				  int nid = ((Integer)e.nextElement()).intValue();
				  node = nid;
			  }

		  }
		  
		  sss=cp;
	  }

	  
	  //node 新闻的父亲节点
	  
	        Node nobj = Node.find(node);
	       
	   
            Category category = Category.find(node);
            int type = nobj.getType();
            boolean isnew=false;
            if(type == 1)
            {
                type = category.getCategory();
            }
            
            int sequence = Node.getMaxSequence(node) + 10;
            long options = nobj.getOptions();
            int options1 = nobj.getOptions1();
            String community = nobj.getCommunity();
           
            int defautllangauge = nobj.getDefaultLanguage();
            Category cat = Category.find(node); //39
            teasession._nNode = Node.create(node,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,
            options,options1,defautllangauge,null,null,
            		createdate,nobj.getStyle(),nobj.getRoot(),nobj.getKstyle(),nobj.getKroot(),"",null,
            		teasession._nLanguage,maintitle,keyword,content,
            		null,"",null,0,null,"","","","",null,null);
            Node.find( teasession._nNode).finished( teasession._nNode);
             
            //更新时间
            Node.find(teasession._nNode).setUpdatetime(lastupdate);
           
         
	  		int media = 0;
            String mn =source;
            if(mn != null && mn.length() > 0)
            { 
            	 Enumeration e2 = Media.find(teasession._strCommunity,39," AND ml.name=" + DbAdapter.cite(mn),0,1);
                  media = e2.hasMoreElements() ? ((Integer) e2.nextElement()).intValue() : Media.create(teasession._strCommunity,39,teasession._nLanguage,mn,null);
            }
            
            if(author != null)
            {
                int rsum = Report.getAutherSum(author);
                if(!ReportMember.isExists(author))
                {
                    ReportMember.set(0,author,rsum,teasession._strCommunity);
                }
            }
	 		 
            
            Report.create(teasession._nNode,media,0,publishtime,1,picfile,null,vicetitle,author,zy,null,0);
            
            Report.find(teasession._nNode).setEditmember(author,teasession._nLanguage);
            //摘要放到 新闻语录
             Report.find(teasession._nNode).setNewquotaSource(summary,""); 
            //副标题图片
            //vtpic
            Report.find(teasession._nNode).setFile("subheadfilename",vtpic,teasession._nLanguage);
            
            //编辑
            //editor
            Report.find(teasession._nNode).setEditmember(editor,teasession._nLanguage);
            
            //稿件类别
            //articletype
            Report.find(teasession._nNode).setManuscripttype(articletype);
            
            
            //图片编号 用地址字段

             Report.find(teasession._nNode).setFile("address",_no,teasession._nLanguage);
            System.out.println(i+":"+teasession._nNode+"----"+maintitle+"--来源:"+source+"--作者:"+author+"--编辑:"+editor+"--副标题图片:"+vtpic+"--文章图片:"+picfile+"--arid:"+arid);
           
           
	        i++; 
  }
}finally
{
  db.close();
}

%>





