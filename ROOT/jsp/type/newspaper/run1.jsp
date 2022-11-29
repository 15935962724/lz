<%@page contentType="text/html;charset=gbk" %>
<%@ page language="java"   import="java.util.*"%>
<%@ page import="tea.entity.util.ReadFile"%>
<%@ page import="org.dom4j.Document"%>
<%@ page import="org.dom4j.DocumentException"%>
<%@ page import="org.dom4j.DocumentHelper"%>
<%@ page import="org.dom4j.Element"%>
<%@ page import="org.dom4j.io.SAXReader"%>
<%@ page import="org.dom4j.io.XMLWriter"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="javax.imageio.ImageReader"%>
<%@ page import="javax.imageio.stream.ImageInputStream"%>

<%@ page  import="java.text.SimpleDateFormat"  %>
<%@ page  import="tea.resource.Resource"  %>

<%@page  import="tea.entity.site.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.Entity" %>
<%@page import="tea.entity.subscribe.Pageinform"%>
<HTML>
<HEAD>
<TITLE> 热区 </TITLE>
<SCRIPT language=JAVASCRIPT src="./6L1.js"></SCRIPT>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>

<BODY>
已成功导入报纸信息 

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
 Cluster c = Cluster.getInstance();
int father=Integer.parseInt(teasession.getParameter("father"));
//byte filedata[]=teasession.getBytesParameter("File");
//byte picdata[]=teasession.getBytesParameter("Picture");

//byte filedata[]=ReadFile.readFile("d:\\newspaper\\zjrb\\2005-07-01\\050701\\050701.xml");
//byte picdata[]=ReadFile.readFile("d:\\newspaper\\zjrb\\2005-07-01\\050701\\050701.jpg");
//String newspath="d:\\newspaper\\zjrb";
Pageinform pfobj=Pageinform.find(Pageinform.getPfid(father,teasession._strCommunity));
String newspath=pfobj.getPagename();
File newsfile = new File(newspath);   

File[] datelist = newsfile.listFiles();
 int ii=1;
for(int i = 0;i < datelist.length;i++) {   
 if (datelist[i].isDirectory()&& Entity.isValidDate(datelist[i].getName())){ //是否是目录   
  	
  	 tea.entity.node.Node fathernode= tea.entity.node.Node.find(father);
   int datenode=ReadFile.find(teasession._strCommunity,datelist[i].getName(),father);
    
  	 if (datenode==0)
  	 {datenode=tea.entity.node.Node.create(father,ii++,teasession._strCommunity,teasession._rv,0,
    		false,fathernode.getOptions(),0,fathernode.getDefaultLanguage(),
    		fathernode.getStartTime(),fathernode.getStopTime(),tea.entity.Entity.sdf.parse(datelist[i].getName()),fathernode.getStyle(),
    		0,0,0,"","",1,datelist[i].getName(),
    		datelist[i].getName(),datelist[i].getName(),null,"",1,
	    		null,"","","","",null,null) ;
  	tea.entity.node.Node node1=tea.entity.node.Node.find(datenode);
  	 node1.set(node1.isMostly(),node1.isMostly1(),node1.isMostly2(),"/");
  	 tea.entity.node.Node.find(datenode).finished(datenode);
  	 out.println("出版日期:"+datelist[i].getName()+"<br>");
  	 }
  	File[] editionlist = datelist[i].listFiles();
  	int jj=1;
  	     for(int j = 0;j < editionlist.length;j++) 
  	     { 	    	 
  	    	 if (editionlist[j].isDirectory())
  	    	{
  	    		
  	    		 File[]  filelist = editionlist[j].listFiles();
  	    		for(int k = 0;k < filelist.length;k++) 
  	   	         { 
  	    		   if (filelist[k].getName().toLowerCase().contains(".xml"))
  	    		  {
  	    		    byte filedata[]=ReadFile.readFile(filelist[k].getAbsolutePath());
  	    		   // 
  	    		 String s=new String(filedata,"gbk");
  	    		// ArrayList list=new ArrayList();

  	    		 Document document = DocumentHelper.parseText(s);
  	    		Element banmian=document.getRootElement();
  	    		int sequence=0;
  	    		try{
  	    		sequence=Integer.parseInt(editionlist[j].getName());
  	    		}catch(Exception e)
  	    		{
  	    			//e.printStackTrace();
  	    		}
  	    		String seq=editionlist[j].getName();
  	    		if(seq.length()==1) seq="0"+seq;
  	    		String banming=banmian.element("大样").element("版名").getText();
  	    		
  	    		banming="第"+seq+"版:"+banming;
  	    		String picname=banmian.element("大样").element("版面图").element("真图").element("文件名").getText();
  	    		byte picdata[]=ReadFile.readFile(editionlist[j].getAbsolutePath()+"\\"+picname);
	    		   
  	    		String pdfname=banmian.element("大样").element("PDF").element("文件名").getTextTrim();
  	    		
  	    		
  	    		
  	    		int editionnode=ReadFile.find(teasession._strCommunity,banming,datenode);
                if(editionnode==0)
                {
                 editionnode=tea.entity.node.Node.create(datenode,sequence,teasession._strCommunity,teasession._rv,1,
  	    	    		false,fathernode.getOptions(),fathernode.getOptions1(),fathernode.getDefaultLanguage(),
  	    	    		fathernode.getStartTime(),fathernode.getStopTime(),new Date(),fathernode.getStyle(),
  	    	    		0,0,0,"","",1,banming,
  	    	    	    banming,banming,null,"",1,
  	    	    		null,"","","","",null,null) ;
                 
                 String path = "/" + c.getPath() + "/" + teasession._strCommunity + "/newspaper/";
                 File parent = new File(application.getRealPath(path));
                 parent.mkdirs();
                 
                 
                 String dir = String.valueOf(editionnode);
                 
                 path = "/" + c.getPath() + "/" + teasession._strCommunity + "/newspaper/" + dir + "/";
                 parent = new File(application.getRealPath(path));
                 parent.mkdirs();
      
                String picpath=application.getRealPath(path);

                 FileOutputStream fos = new FileOutputStream(picpath+"\\"+picname);
                                fos.write(picdata);
                                fos.close();
                                
                  String pdfpath=application.getRealPath(path);

                                
                  tea.entity.node.Node enode= tea.entity.node.Node.find(editionnode);
                  
                  tea.entity.node.Node.find(editionnode).finished(editionnode);
                  enode.setPicture(path+picname,1);
                  if(pdfname!=""&&pdfname.length()>0)
    	    		 {
                	  byte pdfdata[]=ReadFile.readFile(editionlist[j].getAbsolutePath()+"\\"+pdfname);
                   
                  FileOutputStream fos1 = new FileOutputStream(picpath+"\\"+pdfname);
                                                fos1.write(pdfdata);
                                                fos1.close();
                                                enode.setFileName(path+pdfname,1); 
    	    		 }       
                 
                  
                  if(sequence==1)
                  {tea.entity.node.Node node1=tea.entity.node.Node.find(datenode);
                	 node1.setPicture(path+picname,1);
                  }
                 out.println("&nbsp;&nbsp;&nbsp;"+editionlist[j].getName()+"版");
                }
  	    		File file = new File(editionlist[j].getAbsolutePath(),picname);
  	    		Iterator readers = ImageIO.getImageReadersByFormatName("jpg");
  	    		ImageReader reader = (ImageReader)readers.next();
  	    		ImageInputStream iis = ImageIO.createImageInputStream(file);
  	    		reader.setInput(iis, true);
  	    		int width=reader.getWidth(0);
  	    		int height=reader.getHeight(0);
               int  kkk=1;
  	    		for(Iterator iterator = banmian.elementIterator("小样");iterator.hasNext();)
  	    		{ Element node=(Element) iterator.next();
  	    		  Element title=node.element("标题");
  	    		  Element type=node.element("发布类型");
  	    		  
  	    		if(title.getTextTrim().length()>0){
  	    			
  	    		  Element content=node.element("内容");
  	     		  String coords="";
		  	      for(Iterator jterator = node.element("版面图映射").elementIterator("顶点")  ;jterator.hasNext();)
		  	    	  {
		  	    	      Element point=(Element) jterator.next();
		  	         	  StringTokenizer t = new StringTokenizer(point.getText(), ",", false);
		  	    	  int kk=0;
		  	    	   while(t.hasMoreTokens()){
		  	    	   String temp = t.nextToken();
		  	    	   temp=temp.substring(0,temp.length()-1);
		  	    	   float bl=Float.parseFloat(temp);
		  	    	   int coord=0;
			  	    	   if(kk==0)
			  	    	   {coord=(int)(3.5*bl);
			  	    	   kk++;
			  	    	   }else
			  	    	   {coord=(int)((float)height/width*3.5*bl);
			  	    	   kk--;
			  	    	   }
			  	    	   if(coords.length()==0) coords=coords+coord;
			  	    	   else coords=coords+","+coord;
		  	    	
		  	    	  }
		  	    	 }
		  	    	 
		  	    	int newsnode=ReadFile.find(teasession._strCommunity,title.getText().trim(),editionnode);
		  	    	if(newsnode==0)
		  	    	{
		  	    		
		  	    	  newsnode=tea.entity.node.Node.create(editionnode,kkk++,teasession._strCommunity,teasession._rv,39,
		  	    	    		false,fathernode.getOptions(),fathernode.getOptions1(),fathernode.getDefaultLanguage(),
		  	    	    		fathernode.getStartTime(),fathernode.getStopTime(),new Date(),fathernode.getStyle(),
		  	    	    		0,0,0,"","",
		  	    	    		1,title.getText().trim(),title.getText(), content.getText().replaceAll("\n","<br>"),null,"",1,
		  	    	    		null,"","","","",null,null) ;
		  	    	  tea.entity.node.Node news=tea.entity.node.Node.find(newsnode);
		  	    	  Element pic=node.element("附图");
		  	    	String path="";
		  	    	String picname1=null;
		  	      		if(pic!=null)
		  	      		{
		  	      		try{
			  	      		 picname1=pic.element("真图").element("文件名").getText();
			  	      		// System.out.println("picname:"+picname);
			  	      		 String dir = String.valueOf(newsnode);
			  	      		 
			                 path = "/" + c.getPath() + "/" + teasession._strCommunity + "/newspaper/" + dir + "/";
			                 File parent = new File(application.getRealPath(path));
			                 parent.mkdirs();
			     
		                         String picpath=application.getRealPath(path);
		     	                 FileOutputStream fos = new FileOutputStream(picpath+"\\"+picname1);
		     	                 byte picdata1[]=ReadFile.readFile(editionlist[j].getAbsolutePath()+"\\"+picname1);
				                 fos.write(picdata1);
				                 fos.close(); 
			             
			                 news.setPicture(path+picname1,1);
			                 if (picname1!=null)
			                 news.set(1,news.getSubject(1),"<img src=\""+path+picname1+"\" >"+news.getText(1));
			             }catch(Exception e)
			             {
			            	 e.printStackTrace();
			            	 System.out.println("找不到图片:"+application.getRealPath(path)+"\\"+picname1);
			             }
		                                
		  	      		}
		  	      if (picname1!=null)
		  	    	  picname1=path+picname1;
		  	       tea.entity.node.Node.find(newsnode).finished(newsnode);
		  	       java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yy-MM-dd");
                    tea.entity.node.Report.create(newsnode,0,0, sdf.parse(datelist[i].getName()),teasession._nLanguage,picname1,"","","","","",0);
                    tea.entity.node.Report.find(newsnode).set(coords,editionlist[j].getName());
                 
               	 out.println("&nbsp;&nbsp;&nbsp;&nbsp;"+title.getText());
		  	    	 out.println(coords+"<br>");}
  	    		}
  	    	
  	    		}
  	    		   
  	    		   
  	    		   }
  	   	         }
  	    		    
  	    		 out.println("<br>");
  	    	}
  	     
  	     }
  }
  
  }

   %>

</BODY>
</HTML>
