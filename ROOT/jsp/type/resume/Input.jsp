<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.resource.*" %><%!
public static java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMdd");
%><%request.setCharacterEncoding("UTF-8");

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(request.getMethod().equals("POST"))
{
  byte by[]=teasession.getBytesParameter("file");
  String content;
  if(by==null)
  {
    content=teasession.getParameter("content").trim();
    if(content.length()<1)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("&#25991;&#20214;&#19978;&#20256;&#25110;&#25991;&#20214;&#20869;&#23481;,&#24517;&#22635;&#19968;&#39033;.","UTF-8"));//文件上传或文件内容,必填一项.
      return;
    }
    by=content.getBytes("ISO-8859-1");
  }else
  {
    content=new String(by,"UTF-8");
    /*
    int index=content.indexOf("?>");
    if(index!=-1)
    {
      String line=content.substring(0,index);
      if(line.indexOf("UTF-8")!=-1||line.indexOf("utf-8")!=-1)
      {
        content=new String(by,"UTF-8");
      }
    }*/
  }
  System.out.println(content);

  java.io.ByteArrayInputStream bais=new java.io.ByteArrayInputStream(by);
  javax.xml.parsers.DocumentBuilderFactory dbf=javax.xml.parsers.DocumentBuilderFactory.newInstance();
  javax.xml.parsers.DocumentBuilder db=dbf.newDocumentBuilder();
  org.w3c.dom.Document doc=db.parse(bais);//application.getRealPath("/test.xml"));
  org.w3c.dom.Element e=doc.getDocumentElement();
  org.w3c.dom.NodeList nl=e.getChildNodes();

  System.out.println(nl.getLength());
  System.out.println(e.getNodeValue());
  for(int i=0;i<nl.getLength();i++)
  {
    String id=null;//广告ID
    String title=null;//广告名称
//    String raea=null;//人事范围
    java.util.Date begin=null;//开始时间
    java.util.Date end=null;//结束时间
    int count=0;//招聘人数
//    String personnel=null;//人事管员
    String instrument=null;//广告发部的平台1：总公司内部招聘平台2：总公司外部招聘平台
//    String subarea=null;//从广告相关空缺职位的属性中读取，多个空缺必须一致
//    String group=null;//从广告相关空缺职位的属性中读取的员工子组，通过逻辑判断生成
    String aptyp=null;
    String stext=null;
    org.w3c.dom.Node n=nl.item(i);
    if(n.getNodeType()==org.w3c.dom.Node.ELEMENT_NODE)
    {
      org.w3c.dom.NodeList nl_son=n.getChildNodes();

      for(int j=0;j<nl_son.getLength();j++)
      {
        org.w3c.dom.Node n_son=nl_son.item(j);
        if(n.getNodeType()==org.w3c.dom.Node.ELEMENT_NODE)
        {
          if("ID".equals(n_son.getNodeName()))
          {
            if(n_son.getFirstChild()!=null)
            id=n_son.getFirstChild().getNodeValue();
            else
            {
              response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("ID &#26080;&#25928;","GBK"));
              return;
            }
          }else
          if("TITLE".equals(n_son.getNodeName()))
          {
            if(n_son.getFirstChild()!=null)
            {
              title=new String(n_son.getFirstChild().getNodeValue().getBytes("GBK"),"ISO-8859-1");
            }else
            {
              response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("TITLE &#26080;&#25928;","GBK"));
              return;
            }
          }else
          if("APTYP".equals(n_son.getNodeName()))
          {
            if(n_son.getFirstChild()!=null)
            {
              aptyp=n_son.getFirstChild().getNodeValue();
            }else
            {
              response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("APTYP &#26080;&#25928;","GBK"));
              return;
            }
          }else/*
          if("PERSONEL_AREA".equals(n_son.getNodeName()))
          {
            raea=n_son.getFirstChild().getNodeValue();
          }else*/
          if("BEGIN_DATE".equals(n_son.getNodeName()))
          {
            if(n_son.getFirstChild()!=null)
            begin=sdf.parse(n_son.getFirstChild().getNodeValue());
            else
            {
              response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("BEGIN_DATE &#26080;&#25928;","GBK"));
              return;
            }
          }else
          if("END_DATE".equals(n_son.getNodeName()))
          {
            if(n_son.getFirstChild()!=null)
            end=sdf.parse(n_son.getFirstChild().getNodeValue());
            else
            {
              response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("END_DATE &#26080;&#25928;","GBK"));
              return;
            }
          }else
          if("HEAD_COUNT".equals(n_son.getNodeName()))
          {
            if(n_son.getFirstChild()!=null)
            count=Integer.parseInt(n_son.getFirstChild().getNodeValue());
            else
            {
              response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("HEAD_COUNT &#26080;&#25928;","GBK"));
              return;
            }
          }/*else
          if("PERSONNEL_OFFICER".equals(n_son.getNodeName()))
          {
            personnel=n_son.getFirstChild().getNodeValue();
          }*/else
          if("INSTRUMENT_ID".equals(n_son.getNodeName()))
          {
            if(n_son.getFirstChild()!=null)
            instrument=n_son.getFirstChild().getNodeValue();
            else
            {
              response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("INSTRUMENT_ID &#26080;&#25928;","GBK"));
              return;
            }
          }else
          if("STEXT".equals(n_son.getNodeName()))
          {
            if(n_son.getFirstChild()!=null)
            {
              stext=new String(n_son.getFirstChild().getNodeValue().getBytes("GBK"),"ISO-8859-1");
            }else
            stext="";
          }/*else
          if("PERSONEL_SUBAREA".equals(n_son.getNodeName()))
          {
            subarea=n_son.getFirstChild().getNodeValue();
          }else
          if("APPLICANT_GROUP".equals(n_son.getNodeName()))
          {
            group=n_son.getFirstChild().getNodeValue();
          }*/
          /*
          if(!"#text".equals(n_son.getNodeName()))
          {
            System.out.println(n_son.getFirstChild().getNodeValue());
          }*/
        }
      }
      int aptyp_id=Company.findByAptyp(aptyp);
      if(aptyp_id==0)
      {
        response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("&#27809;&#26377;&ldquo;"+aptyp+"&rdquo;&#25152;&#23545;&#24212;&#35813;&#20844;&#21496;.","GBK"));//没有“"+aptyp+"”所对应该公司.
        return;
      }
      int adocde_id=Job.findByAdcode(id);
      int node=0;
      if(adocde_id==0)
      {
        int father=15470;
        String community="cnoocjob";
        tea.entity.RV rv=new tea.entity.RV("webmaster",community);
        int options=1845493760;
        int options1=0;
        node=Node.create(father, 0, community, rv, 50, 0, false, options, options1, 1, null, null, 1, title, "", "", null, "", 0, null, "", "", "", "",null, begin,0,0,0,0,"","");
      }else
      {
        node=adocde_id;
      }
      Job job = new Job(node, 1);
      /*
      job.setName(title);
      job.setAdcode(id);
//      job.setPersonelarea(raea);
      job.setTxtHeadCount(count);
//      job.setPersonelofficer(personnel);
      job.setValidityDate(end);
      job.setInstrument(instrument);
//      job.setSubarea(subarea);
//      job.setSongroup(group);
//      Company company=Company.find(raea);
//      if(company._nNode!=0)
//      {
//        job.setSltOrgId(company._nNode);
//      }
      job.setSltOrgId(aptyp_id);
      job.set();
*/
      job.set(id,  count,  end,  instrument,  aptyp_id);

      Node obj=Node.find(node);
      obj.finished(node);
      obj.set(title,stext,1);
//      obj.setHidden(2);//设置职位为未发布
      tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
      try
      {
        dbadapter.executeUpdate("UPDATE SET hidden=2 WHERE node="+node);
      }finally
      {
        dbadapter.close();
      }
      System.out.println(node+":"+title);
    }
  }

//  response.sendRedirect("/jsp/info/Succeed.jsp?info="+java.net.URLEncoder.encode("完成.","GBK"));
  response.sendRedirect("/jsp/type/job/yjobSap.jsp?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Job");


%><HTML>
<HEAD>
<link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
<link href="/tea/CssJs/cnoocjob.css" rel="stylesheet" type="text/css">
</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage,"1167453838140")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <br />
<form name="form1" action="<%=request.getRequestURI()%>" method="post" enctype="multipart/form-data">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"1167453870359")%><!--上传文件-->:</td>
    <td><input name="file" type="file" onchange="form1.content.disabled=this.value.replace(' ','').replace('　','').length>0;" size="40"></td>
    </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"1167453980171")%><!--或--></td>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"1167453938593")%><!--文件内容-->:</td>
    <td><textarea name="content" cols="50"  rows="5" id="content" onkeyup="this.onchange();" onkeydown="this.onchange();" onchange="form1.file.disabled=this.value.replace(' ','').replace('　','').length>0;"></textarea></td>
    </tr>
	<tr>
	  <td colspan="2" align="center">
	  <input name="submit" type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
          <input name="reset" type="reset" value="<%=r.getString(teasession._nLanguage,"Reset")%>">
          <!--查看-->
          <input type="button" value="<%=r.getString(teasession._nLanguage,"1167444621250")%>" onclick="window.open('/jsp/type/job/yjobSap.jsp?node=<%=teasession._nNode%>','_self');"/>
    </table>
</form>

  <div id="head6"><img height="6" src="about:blank"></div>
  <br />

</body>
</html>

