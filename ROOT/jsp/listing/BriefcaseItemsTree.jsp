<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@ page import="tea.ui.*" %><%@ page import="java.util.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);



String listing=request.getParameter("listing");
String id=request.getParameter("id");
Resource r=new Resource("/tea/resource/Report");

String info=request.getParameter("info");
if(info==null)info="显示到...";

//http://127.0.0.1/jsp/listing/SelListing.jsp?community=radio&type=39

Community c=Community.find(teasession._strCommunity);

%><html>
<head>
<title><%=info%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">

function f_ex(obj)
{
  var div=obj.nextSibling.nextSibling;

  var flag=div.style.display=="none";
  
  div.style.display=flag?"":"none";
  
  obj.src="/tea/image/tree/tree_"+(flag?"minus":"plus")+".gif";
}
function f_submit()
{
  //return submitCheckbox(this.listings, '<%=r.getString(teasession._nLanguage, "InvalidSelect")%>');
  var n="",id="/";
  var ls=form1.listings;
  if(!ls.length)ls=new Array(ls);
  for(var i=0;i<ls.length;i++)
  {
    if(!ls[i].checked)continue;
    n+=ls[i].view+";　";
    id+=ls[i].value+"/";
  }
  window.returnValue=id+":"+n;
  window.close();
  return false;
}
function f_load()
{
  $('limg').style.display="none";
  var ls=form1.listings;
  if(!ls)return;
  if(!ls.length)ls=new Array(ls);
  for(var i=0;i<ls.length;i++)
  {
    if("<%=listing%>".indexOf("/"+ls[i].value+"/")!=-1)
    {
      ls[i].checked=true;
    }
  }
}
</script>
<style type="text/css">
.tree{padding-left:20px;}
</style>
</head>
<body onload="f_load()">
<div id="head6"><img height="6" src="about:blank" alt="" ></div>

<img id="limg" style="position:absolute;left:180px;top:160px;" src="/tea/mt/progress.gif"/>
<FORM name="form1" method="post" action="?" onSubmit="return f_submit()">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=id%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>手动列举:</td>
  </tr>
  <tr>
    <td id="tdid">

<%
out.flush();

StringBuilder sb=new StringBuilder();
HashMap hm=new HashMap();
StringBuilder sql = new StringBuilder();
sql.append("SELECT l.listing,l.node FROM Listing l INNER JOIN Node n ON l.node=n.node WHERE path LIKE '/"+c.getNode()+"/%' AND n.type<2 AND n.hidden=0 AND l.ectypal=0 AND(");
sql.append("(l.type=3 AND EXISTS(SELECT picknode FROM PickNode p WHERE l.listing=p.listing ").append("))");
sql.append("OR(l.pick=0 AND EXISTS(SELECT pickmanual FROM PickManual p WHERE l.listing=p.listing AND p.community IN(").append(DbAdapter.cite(teasession._strCommunity)).append(",");
sql.append(DbAdapter.cite("")).append(")");
sql.append(")))"); 



DbAdapter db = new DbAdapter();
try
{
  db.executeQuery(sql.toString());
  while(db.next())
  {
    int lid=db.getInt(1);
    int nid=db.getInt(2);
    if(!Node.find(nid).isCreator(teasession._rv)&&AccessMember.find(nid,teasession._rv._strV).getPurview()<1)continue;
    ArrayList al=(ArrayList)hm.get(new Integer(nid));
    if(al==null)
    {
      al=new ArrayList();
      sb.append(",").append(nid); 
    }
    al.add(new Integer(lid));
    hm.put(new Integer(nid),al);
  }
}finally
{
  db.close();
}



if(sb.length()<1)
{
  out.println("<script>alert('没有手动列举!!!');window.close();</script>");
}else
{
  String last="";
  int sint = 0;
 StringBuffer sp = new StringBuffer("/");

  Enumeration e=Node.find(" AND EXISTS(SELECT node FROM Node sn WHERE sn.node IN("+sb.substring(1)+") AND sn.path LIKE "+DbAdapter.concat("n.path","'%'")+") ORDER BY n.path",0,Integer.MAX_VALUE);
  while(e.hasMoreElements())
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    String p=Node.find(n.getFather()).getPath();
 
  
    if(p!=null&&!p.equals(last))
    {
      for(int i=last.split("/").length-p.split("/").length;i>-1;i--)
      {
    	 
        out.print("</div>");
        
      }
     
      out.print("<div class='tree'>");
      last=p;
    }

  // 
   out.print("<img src='/tea/image/tree/tree_minus.gif' onclick='f_ex(this)' id=img"+node+">");//onclick='f_ex(this)

   out.print("<span id = span"+node+">");
   
   out.print("<a href='###'><font color=Black>"+n.getSubject(teasession._nLanguage)+"</font><br/></a>");
	
   out.print("</span>");
  
    ArrayList al=(ArrayList)hm.get(new Integer(node));
 
    if(al!=null)
    {
    	
      out.print("<div class='tree'>");
      for(int i=0;i<al.size();i++)
      { 
        int lid=((Integer)al.get(i)).intValue();
        String name=Listing.find(lid).getName(teasession._nLanguage);
    
        
        out.print("<span id=id"+lid+" ");
      
        boolean f = false;
        if(AccessMember.find(node,teasession._rv).getListings()!=null && AccessMember.find(node,teasession._rv).getListings().indexOf("/"+lid+"/")!=-1)
       	{
        	sint++;	
        	
        	
       	}else
       	{
       		out.print(" style=display:none ");
       		f = true;
       	  
       	}
        out.print(">");
        
        if(f)
        {
        	out.print("<script>");
        	out.print("document.getElementById('img"+node+"').style.display='none';document.getElementById('span"+node+"').style.display='none';");
        	out.print("</script>");
        }	
        
      
        
        
        out.print("<label for='"+lid+"'>");
        out.print("<a href=/jsp/listing/BriefcaseItems.jsp?node="+node+"&listing="+lid+" target=function_fun >");
     
        out.print(name);
        out.print("</a>");
        out.print("</label>");
        out.print("<br/>");
        out.print("</span>");
        
      
      }
      out.print("</div>");
    }
    
    
   
    
   
  }
 
  /*
  String cccc = cp1.toString();
  for(int i=1;i<cp2.toString().split("/").length;i++)
  {
	  cccc = cccc.replaceAll("/"+cp2.toString().split("/")[i],"") ;
  }
  
  
  for(int i=1;i<cccc.split("/").length;i++)
  {
	
	  String  cid = cccc.split("/")[i];
	  out.print("<script>");
  	out.print("document.getElementById('img"+cid+"').style.display='none';document.getElementById('span"+cid+"').style.display='none';");
  	out.print("</script>");
  }
  */
  
  
 // System.out.println(sp.toString());
 /*
  if(sp.toString()!=null && sp.toString().length()>0 )
  {
	  for(int i=0;i<sp.toString().split("/").length;i++)
     {
		  String divnode = sp.toString().split("/")[i];
		  out.print("<script>if(document.getElementById('divid"+divnode+"')!=null)document.getElementById('divid"+divnode+"').style.display='none'; </script>");
		//  out.print("<script>if(document.getElementById('divid1"+divnode+"')!=null)document.getElementById('divid1"+divnode+"').style.display='none'; </script>");
    
		  
     }
	   
  }
  
  */
  if(sint ==0 )
  {
	  out.print("<script>if(document.getElementById('tdid')!=null) document.getElementById('tdid').style.display='none'; </script>");
  }
  
  
}
%> 

    </td>
  </tr>
</table>


</FORM>

</body>
</html>
