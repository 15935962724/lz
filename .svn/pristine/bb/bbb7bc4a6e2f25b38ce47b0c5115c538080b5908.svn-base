<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@ page import="tea.ui.*" %><%@ page import="java.util.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

int type=Integer.parseInt(request.getParameter("type"));

String listing=request.getParameter("listing");
String id=request.getParameter("id");
Resource r=new Resource("/tea/resource/Report");

String info=request.getParameter("info");
if(info==null)info="显示到...";

//http://127.0.0.1/jsp/listing/SelListing.jsp?community=radio&type=39
String uri=request.getRequestURI();
StringBuffer url=request.getRequestURL();
uri=url.substring(0,url.length()-uri.length()+1);
Community c=Community.find(teasession._strCommunity);

String txtnodes=request.getParameter("txtnodes");
int nodeid=0;
boolean thif=false;
if(txtnodes!=null&&txtnodes.trim().length()>0&&(!txtnodes.trim().equals(""))){
	String[] nodes=txtnodes.split(";");
	if(nodes.length==1){
		thif=true;
		nodeid=Integer.parseInt(nodes[0]);
	}
}
%><html>
<head>
<title><%=info%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">

function f_ex(obj)
{
  var div=obj.nextSibling.nextSibling;
 if(div.style.display=='none')
	 {
	 div.style.display==""
	 }else
		 {
		 div.style.display=="none"
		 }
  var flag=div.style.display;//=="none";
   div.style.display=flag?"":"none";
  obj.src="/tea/image/tree/tree_"+(flag?"minus":"plus")+".gif";

}
function fhidden(){
	var imv=form1.imghidden.value;
	if(imv!=null&&imv!=""){
		var imgs=imv.split(";");
		if(imgs.length>0){
			for(var i=0;i<imgs.length;i++){
					var img=document.getElementById("img"+imgs[i]);
					if(img!=null&&img.style.display!="none"){
						f_ex(img);
					}
			}
		}
	}
}
function f_submit()
{
  //return submitCheckbox(this.listings, '<%=r.getString(teasession._nLanguage, "InvalidSelect")%>');
  var name="",list="/",node="/";
  var ls=form1.listings;
  if(!ls.length)ls=new Array(ls);
  for(var i=0;i<ls.length;i++)
  {
    if(!ls[i].checked)
   {
    	var tmps="p"+ls[i].value;
    	var vt=document.getElementById(tmps).value;
    	if(vt=="true"){
    		node+=ls[i].value+"/";
    	}
    	   continue;

   }
    name+=ls[i].getAttribute('view')+";　";
    list+=ls[i].value+"/";
  }
  //window.returnValue=id+":"+n+"|"+txt;
  window.returnValue="{name:\""+name.replace(/"/g,"'")+"\",listing:'"+list+"',node:'"+node+"'}";
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
<body onLoad="f_load()">
<div id="head6"><img height="6" src="about:blank" alt="" ></div>

<img id="limg" style="position:absolute;left:180px;top:160px;" src="/tea/mt/progress.gif"/>
<FORM name="form1" method="post" action="?" onSubmit="return f_submit()">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="imghidden" value=""/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>请选择目标:</td>
  </tr>
  <tr>
    <td>
<div style="overflow: scroll;width:100%;height:300px;">
<%

out.flush();

StringBuilder sb=new StringBuilder();
HashMap hm=new HashMap();
StringBuilder sql = new StringBuilder();
sql.append("SELECT l.listing,l.node FROM Listing l INNER JOIN Node n ON l.node=n.node WHERE path LIKE '/"+c.getNode()+"/%' AND n.type<2 AND n.hidden=0 AND l.ectypal=0 AND(");
sql.append("(l.type=3 AND EXISTS(SELECT picknode FROM PickNode p WHERE l.listing=p.listing AND p.type IN(").append(type).append(",255)))");
sql.append("OR(l.pick=0 AND EXISTS(SELECT pickmanual FROM PickManual p WHERE l.listing=p.listing AND p.community IN(").append(DbAdapter.cite(teasession._strCommunity)).append(",").append(DbAdapter.cite("")).append(")").append(" AND p.type IN(").append(type).append(",255))))");

DbAdapter db = new DbAdapter();
try
{
  db.executeQuery(sql.toString());
  while(db.next())
  {
    int lid=db.getInt(1);
    int nid=db.getInt(2);
    if(!Node.find(nid).isCreator(teasession._rv)&&AccessMember.find(nid,teasession._rv._strV).getPurview()<1)
    {
    	continue;
    }
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



  Enumeration e=Node.find(" AND EXISTS(SELECT node FROM Node sn WHERE sn.node IN("+sb.substring(1)+") AND sn.path LIKE "+DbAdapter.concat("n.path","'%'")+") ORDER BY n.path",0,Integer.MAX_VALUE);
  int enu=0;
  //out.println(" AND EXISTS(SELECT node FROM Node sn WHERE sn.node IN("+sb.substring(1)+") AND sn.path LIKE "+DbAdapter.concat("n.path","'%'")+") ORDER BY n.path");
  while(e.hasMoreElements())
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    String p=Node.find(n.getFather()).getPath();
    int cint = 0;
    if(p!=null&&!p.equals(last))
    {
      for(int i=last.split("/").length-p.split("/").length;i>-1;i--)
      {
        out.print("</div>");
      }
      out.print("<div class='tree'>");
      last=p;
    }

    out.print("<img src='/tea/image/tree/tree_minus.gif' onclick='f_ex(this)'  id=img"+node+">");
    out.print("<span id = span"+node+">");
   		 out.print("<a href='/servlet/Node?node="+node+"' target='_blank'>"+n.getSubject(teasession._nLanguage)+"<br/></a>");
    out.print("</span>");
    ArrayList al=(ArrayList)hm.get(new Integer(node));
    if(al!=null)
    {
      out.print("<div class='tree'>");
      out.print("<script>form1.imghidden.value=form1.imghidden.value+"+node+"+';'</script>");
      int faaa = 0;
      for(int i=0;i<al.size();i++)
      {
        int lid=((Integer)al.get(i)).intValue();
        String name=Listing.find(lid).getName(teasession._nLanguage);
       //根据域名判断是否隐藏
      /*
       if(faaa!=Listing.find(lid).getNode())
        {
	        out.print("<script>");
	        out.print("f_ex(document.getElementById('img"+Listing.find(lid).getNode()+"'));");
	        out.print("</script>");
	        faaa =Listing.find(lid).getNode();
        }*/

        out.print("<span id=id"+lid+" ");
        boolean f = false;
        if(AccessMember.find(node,teasession._rv).getListings()!=null && AccessMember.find(node,teasession._rv).getListings().indexOf("/"+lid+"/")!=-1)
       	{
        	sint++;
        		enu++;
        	//out.print(" style=display:none ");
       	}else
       	{
       		out.print(" style=display:none ");
       		f = true;
       	}
        out.print(">");
        /*
        if(f)
        {
        	out.print("<script>");
        	out.print("document.getElementById('img"+node+"').style.display='none';document.getElementById('span"+node+"').style.display='none';");
        	out.print("</script>");
        }

        */



        out.print("<input name='listings' type='checkbox' view=\""+name+"\" value='"+lid+"' ");
        int counts=0;
        if(thif){
            counts=Listed.countBriefcaseItems(lid, " and node= "+nodeid);
            if(counts>0){
        	out.print(" checked ");
            }
        }

        out.print(" id='"+lid+"' />");
        if(thif&& counts>0){
        	out.print("<input type='hidden' value='true' id='p"+lid+"' />");
        }else{
        	out.print("<input type='hidden' value='false' id='p"+lid+"' />");
        }
        out.print("<label for='"+lid+"'>"+name+"</label><br/>");

       out.print("</span>");
      }
      if(enu==0)
      {
      	out.print("<script>");
      	out.print("document.getElementById('img"+node+"').style.display='none';document.getElementById('span"+node+"').style.display='none';");
      	out.print("</script>");
      }
      out.print("</div>");
    }
   enu=0;
  }
  if(sint>20){
	  out.print("<script>fhidden();</script>");
  }
  if(sint ==0 )
  {
	  out.print("<script>if(document.getElementById('tdid')!=null) document.getElementById('tdid').style.display='none'; </script>");
  }
}
%>
</div>
    </td>
  </tr>
</table>

<input  type="submit" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>" >
<input type="button" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBClose")%>" onClick="window.close()">
</FORM>

</body>
</html>
