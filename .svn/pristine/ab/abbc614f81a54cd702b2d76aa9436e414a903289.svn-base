<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.db.*"%><%@ page import="java.net.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
%>
<% request.setCharacterEncoding("UTF-8");



TeaSession teasession=new TeaSession(request);

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Node node=Node.find(teasession._nNode);
int root=AdminFunction.getRootId(teasession._strCommunity,teasession._nStatus);
AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);
boolean bool=false;
if(teasession._rv!=null)
{
	bool=teasession._rv.isWebMaster()||teasession._rv.isOrganizer(teasession._strCommunity);
}

boolean bool2=am.getPurview()==3;
if (!bool && !node.isCreator(teasession._rv) &&!bool2)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/node/access/NewAccessMembers");

int accessmember=0;
String tmp=request.getParameter("accessmember");
if(tmp!=null)
{
  accessmember=Integer.parseInt(tmp);
}

Community c=Community.find(teasession._strCommunity);
int style=0,purview=0,otype=2;
String member="",role="/",unit="/",type="/",category="/",section="/",listing="/",cssjs="/",listings="/";
boolean auditing=false;
int picshow=0;
//审核权限
int i2 = 0;
int permissions = Category.find(teasession._nNode).getPermissions();
if(accessmember!=0)
{
  AccessMember obj= AccessMember.find(accessmember);

  member=obj.getMember();
  role=obj.getRole();
  unit=obj.getUnit();
  style=obj.getStyle();
  purview = obj.getPurview();
  type = obj.getType();
  category =obj.getCategory();
  auditing=obj.isAuditing();
  picshow=obj.getPicshow();
  otype=obj.getObjectType();
  section =obj.getSection();
  listing=obj.getListing();
  cssjs=obj.getCssjs();

  listings=obj.getListings();
  if(member!=null)member=member.substring(1).replaceAll("/","; ");
  i2 = obj.getPermissions();
}



StringBuffer t1=new StringBuffer("/");
StringBuffer t2=new StringBuffer("/");
StringBuffer c1=new StringBuffer("/");
StringBuffer c2=new StringBuffer("/");

CLicense obj=CLicense.find(node.getCommunity());
String clt="/0"+obj.getType();

//添加别名类//
Enumeration e=TypeAlias.find();
while(e.hasMoreElements())
{
  int id = ((Integer)e.nextElement()).intValue();
  clt=clt+id+"/";
}


String lt0=am.getType(),lt1=am.getCategory();

String nts[]=clt.split("/");
for (int i = 1; i < nts.length; i++)
{
  int j=Integer.parseInt(nts[i]);

  String name;
  if(j<1024)
  {
    name=r.getString(teasession._nLanguage,Node.NODE_TYPE[j]);
  }else if(j<65535)
  {
    Dynamic d = Dynamic.find(j);
    if(!d.isExists())
    {
      continue;
    }
    name=d.getName(teasession._nLanguage);
  }else
  {
    name=TypeAlias.find(j).getName(teasession._nLanguage);
  }

  String str=name;
  String idj =String.valueOf(j);

  //是组织者 || 只能授自已勇用的权限
  if(bool || lt0.indexOf("/"+j+"/")!=-1)
  {
    //if(type.indexOf("/"+j+"/")!=-1)
    //{
   //   t1.append(str);
   // }else
    //{

	  t1.append(idj).append("/");
      t2.append(str).append("/");
   // }
  }


  if(j>1)
  {
    if(bool || lt1.indexOf("/"+j+"/")!=-1)
    {
     //if(category.indexOf("/"+j+"/")!=-1)
      //{
        //c1.append(str);
     // }else
      //{
       // c2.append(str);

        c1.append(idj).append("/");
        c2.append(str).append("/");

      //}
    }
  }
}

String title=r.getString(teasession._nLanguage, "CBAccessMembers");


%><HTML>
<HEAD>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_submit()
{
  var tmp="/";
  var op=form1.role1.options;
  for(var i=0;i<op.length;i++)
  {
    tmp=tmp+op[i].value+"/";
  }
  form1.role.value=tmp;

  tmp="/";
  op=form1.unit1.options;
  for(var i=0;i<op.length;i++)
  {
    tmp=tmp+op[i].value+"/";
  }
  form1.unit.value=tmp;
/*
  tmp='/';
  op=form1.type1.options;
  for(var i=0;i<op.length;i++)
  {
    tmp=tmp+op[i].value+'/';
  }
  form1.type.value=tmp;

  tmp='/';
  op=form1.category1.options;
  for(var i=0;i<op.length;i++)
  {
    tmp=tmp+op[i].value+'/';
  }
  form1.category.value=tmp;
  */
  return true;
  //return submitText(this.member,'<%=r.getString(teasession._nLanguage, "InvalidAccessMembers")%>')&&f_submit()
}

function f_click()
{
  var t=form1.otype;
  tb.style.display=t[2].checked?"":"none";
  f_load();
}

function f_ex(obj)
{
  var div=obj.nextSibling.nextSibling;
  var flag=div.style.display=="none";
  div.style.display=flag?"":"none";
  obj.src="/tea/image/tree/tree_"+(flag?"minus":"plus")+".gif";
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
</head>

<body onload="f_click()">

<h1><%=r.getString(teasession._nLanguage, "CBInsertMemberID")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM name="form1" METHOD=POST action="/servlet/EditAccessMember" onSubmit="return f_submit();">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="accessmember" value="<%=accessmember%>">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="role" value="<%=role%>">
<input type="hidden" name="unit" value="<%=unit%>">
<!--
<input type="hidden" name="type" value="/">
<input type="hidden" name="category" value="/">
  -->

<h2>对象</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td align="right">类型：</td>
<td>
  <%
  for(int i=0;i<AccessMember.OBJECT_TYPE.length;i++)
  {
    out.print("<input name='otype' type='radio' value='"+i+"' id='t"+i+"' onclick='f_click()'");
    if(i==0||otype==i)
    out.print(" checked='checked'");
    out.println("><label for='t"+i+"'>"+AccessMember.OBJECT_TYPE[i]+"</label>");
  }
  %>
  </td>
</tr>
<tbody id="tb" style="display:none">
<tr>
<td align="right">角色:</td>
<td>
<table>
  <tr><td>
    <select name="role1" size="8" style="width:150px"  multiple ondblclick="move(form1.role1,form1.role2,true)">
    <%
    if(otype==2)
    {
      String rs[]=role.split("/");
      for(int i=1;i<rs.length;i++)
      {
        AdminRole ar=AdminRole.find(Integer.parseInt(rs[i]));
        if(ar.isExists())
        out.print("<option value="+rs[i]+">"+ar.getName());
      }
    }
    %>
    </select></td>
    <td><input type="button" value="←" onclick="move(form1.role2,form1.role1,true)"><br><input type="button" value="→" onclick="move(form1.role1,form1.role2,true)"></td>
      <td><select name="role2" size="8" style="width:150px"  multiple ondblclick="move(form1.role2,form1.role1,true)">
      <%
      ArrayList alr=AdminRole.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,200);
      for(int j=0;j<alr.size();j++)
      {
        AdminRole ar=(AdminRole)alr.get(j);
        if(otype!=2||role.indexOf("/"+ar.id+"/")==-1)
        {
          out.print("<option value="+ar.id+">"+ar.getName());
        }
      }
      %>
</select>
</table>
</td>
</tr>
<!--   ================部门====================   -->
<tr>
<td align="right">部门:</td>
<td>
<table>
<tr><td>
  <select name="unit1" size="8" style="width:150px" multiple ondblclick="move(form1.unit1,form1.unit2,true)">
  <%
  if(otype==2)
  {
    String us[]=unit.split("/");
    for(int i=1;i<us.length;i++)
    {
      AdminUnit au=AdminUnit.find(Integer.parseInt(us[i]));
      if(au.isExists())
      out.print("<option value="+us[i]+">"+au.getName());
    }
  }
  %>
  </select></td>
<td><input type="button" value="←" onclick="move(form1.unit2,form1.unit1,false)"><br><input type="button" value="→" onclick="move(form1.unit1,form1.unit2,true)"></td>
<td><select name="unit2" size="8" style="width:150px" multiple ondblclick="move(form1.unit2,form1.unit1,false)">
<%
e=AdminUnit.findByCommunity(teasession._strCommunity,"");
while(e.hasMoreElements())
{
  AdminUnit ar=(AdminUnit)e.nextElement();
  int id=ar.getId();
  //if(unit.indexOf("/"+id+"/")==-1)
  {
    out.print("<option value="+id+">"+ar.getPrefix()+ar.getName());
  }
}
%>
  </select>
  </table>
</td>
</tr>
<tr>
  <td align="right">会员:</td>
  <td><input name="member" type="text" size="40" value="<%=member%>" readonly>
    <input type="button" value="添加" onclick="window.open('/jsp/user/list/SelMembers.jsp?input=form1.member','','width=600,height=500,scrollbars=1');">
    <input type="button" value="清空" onclick="form1.member.value='';">
  </td>
</tr>
</tbody>
</table>
<br>

<h2>权限</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Style")%>：</td>
    <td><%
    for(int i=0;i<AccessMember.APPLY_STYLE.length;i++)
    {
      out.print("<input name=style type=radio value="+i);
      if(i==style)out.print(" checked ");
      //如果是节点创建者,只有本节点的权限///////
      if (i>0 && !bool && !bool2)
      {
        out.print(" disabled ");
      }
      out.println(">"+AccessMember.APPLY_STYLE[i]);
    }
    %>
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Access")%>：</td>
    <td><%
    for(int i=0;i<AccessMember.PUR_TYPE.length;i++)
    {
      out.print("<input name=purview type=radio value="+i);
      if(i==purview)out.print(" checked ");
      out.println(">"+AccessMember.PUR_TYPE[i]);
    }
    %>
    <input name="auditing" type="checkbox" value="true" <%if(auditing)out.print("checked");%> ><%=r.getString(teasession._nLanguage,"Auditing")%>
    <input name="picshow" type="checkbox" value="0" <%if(picshow==0)out.print("checked");%> ><%=r.getString(teasession._nLanguage,"前台编辑小图标")%>

    <%
    	if((permissions & 1) != 0)
    	{
    		out.println("<input type=\"CHECKBOX\" name=\"Permissions1\" value=null ");
    		out.println(getCheck((i2 & 1) != 0));
    		out.println(">");
    		out.println("是否需要一级初审");
    	}
	    if((permissions & 2) != 0)
		{
			out.println("<input type=\"CHECKBOX\" name=\"Permissions2\" value=null ");
			out.println(getCheck((i2 & 2) != 0));
			out.println(">");
			out.println("是否需要一级终审");
		}
	    if((permissions & 4) != 0)
		{
			out.println("<input type=\"CHECKBOX\" name=\"Permissions3\" value=null ");
			out.println(getCheck((i2 & 4) != 0));
			out.println(">");
			out.println("是否需要二级初审");
		}
	    if((permissions & 8) != 0)
		{
			out.println("<input type=\"CHECKBOX\" name=\"Permissions4\" value=null ");
			out.println(getCheck((i2 & 8) != 0));
			out.println(">");
			out.println("是否需要二级终审");
		}
    %>



    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage,"Category")%>：</td>
    <td>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	      <%
	      for(int i=1;i<c1.toString().split("/").length;i++)
	      {
	    	  if(i%10==1){
	    		  out.print("<tr>");
	    	  }
	    	  	out.print("<td>");
	    	  	out.print("<input  style=\"cursor:pointer\" type=\"checkbox\" name=\"category\" value="+c1.toString().split("/")[i]);
	    	  	if(category!=null && category.length()>0 && category.indexOf("/"+c1.toString().split("/")[i]+"/")!=-1)
	    	  	{
	    	  		out.print(" checked ");
	    	  	}
	    	  	out.print(">"+c2.toString().split("/")[i]);
	    	  	out.print("</td>");
	      	  if(i%10==0){
	      		out.print("</tr>");
	      	  }
	      }
	      %>

      </table>
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage,"类型")%>：</td>
    <td>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <%
      for(int i=1;i<t1.toString().split("/").length;i++)
      {
    	  if(i%10==1){
    		  out.print("<tr>");
    	  }
    	  	out.print("<td>");
    	  	out.print("<input  style=\"cursor:pointer\" type=\"checkbox\" name=\"type\" value="+t1.toString().split("/")[i]);
    	  	if(type!=null && type.length()>0 && type.indexOf("/"+t1.toString().split("/")[i]+"/")!=-1)
    	  	{
    	  		out.print(" checked ");
    	  	}
    	  	out.print(">"+t2.toString().split("/")[i]);
    	  	out.print("</td>");
      	  if(i%10==0){
      		out.print("</tr>");
      	  }
      }
      %>

      </table>
    </td>
  </tr>

  <tr>
  	<td align="right">段落：</td>
  	<td>
  		<%
		for(int si =0;si<AccessMember.COMPETENCE_TYPE.length;si++)
			{
				out.print("<input type=\"checkbox\" style=\"cursor:pointer\" name=\"section\" value=\""+si+"\" ");

				if(section!=null && section.indexOf("/"+si+"/")!=-1)
				{
					out.print(" checked ");
				}
				out.print(">&nbsp;"+AccessMember.COMPETENCE_TYPE[si]+"&nbsp;&nbsp;");
			}
  		%>
  	</td>
  </tr>
   <tr>
  	<td align="right">列举：</td>
  	<td>
  		<%
		for(int si =0;si<AccessMember.COMPETENCE_TYPE_2.length;si++)
			{
				out.print("<input type=\"checkbox\" style=\"cursor:pointer\" name=\"listing\" value=\""+si+"\" ");

				if(listing!=null && listing.indexOf("/"+si+"/")!=-1)
				{
					out.print(" checked ");
				}
				out.print(">&nbsp;"+AccessMember.COMPETENCE_TYPE_2[si]+"&nbsp;&nbsp;");
			}

  		%>
  	</td>
  </tr>
  <tr>
  	<td align="right">CSS：</td>
  	<td>
  		<%
		for(int si =0;si<AccessMember.COMPETENCE_TYPE.length;si++)
			{
				out.print("<input type=\"checkbox\" style=\"cursor:pointer\" name=\"cssjs\" value=\""+si+"\" ");

				if(cssjs!=null && cssjs.indexOf("/"+si+"/")!=-1)
				{
					out.print(" checked ");
				}
				out.print(">&nbsp;"+AccessMember.COMPETENCE_TYPE[si]+"&nbsp;&nbsp;");
			}
  		%>
  	</td>
  </tr>


   <tr>
       <td align="right">推荐栏目：</td>
    <td>
<div style="overflow: scroll;width:100%;height:200px;">
<input type='checkbox' onclick='selectAll(form1.listings,checked)'   style=cursor:pointer>&nbsp;全选<br/>

<%
out.flush();

/*
int type2 = 39;
StringBuilder sb=new StringBuilder();
HashMap hm=new HashMap();
StringBuilder sql = new StringBuilder();
sql.append("SELECT l.listing,l.node FROM Listing l INNER JOIN Node n ON l.node=n.node WHERE path LIKE '/"+c.getNode()+"/%' AND n.type<2 AND n.hidden=0 AND l.ectypal=0 AND(");
sql.append("(l.type=3 AND EXISTS(SELECT picknode FROM PickNode p WHERE l.listing=p.listing AND p.type IN(").append(type2).append(",255)))");
sql.append("OR(l.pick=0 AND EXISTS(SELECT pickmanual FROM PickManual p WHERE l.listing=p.listing AND p.community IN(").append(DbAdapter.cite(teasession._strCommunity)).append(",").append(DbAdapter.cite("")).append(")").append(" AND p.type IN(").append(type2).append(",255))))");
*/

int type2=39;
int type_96=96;
int type_97=97;
int type_2=2;
StringBuilder sb=new StringBuilder();
HashMap hm=new HashMap();
StringBuilder sql = new StringBuilder();
sql.append("SELECT l.listing,l.node FROM Listing l INNER JOIN Node n ON l.node=n.node WHERE path LIKE '/"+c.getNode()+"/%' AND n.type<2 AND n.hidden=0 AND l.ectypal=0 AND(");
sql.append("(l.type=3 AND EXISTS(SELECT picknode FROM PickNode p WHERE l.listing=p.listing ").append("))");
sql.append("OR(l.pick=0 AND EXISTS(SELECT pickmanual FROM PickManual p WHERE l.listing=p.listing AND p.community IN(").append(DbAdapter.cite(teasession._strCommunity)).append(",");
sql.append(DbAdapter.cite("")).append(")");
sql.append(")))");
//out.println(sql.toString());
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
  out.println("没有手动列举");
}else
{
  String last="";
  int sint = 0;



  Enumeration e2=Node.find(" AND EXISTS(SELECT node FROM Node sn WHERE sn.node IN("+sb.substring(1)+") AND sn.path LIKE "+DbAdapter.concat("n.path","'%'")+") ORDER BY n.path",0,Integer.MAX_VALUE);
//out.println(" AND EXISTS(SELECT node FROM Node sn WHERE sn.node IN("+sb.substring(1)+") AND sn.path LIKE "+DbAdapter.concat("n.path","'%'")+") ORDER BY n.path");

  while(e2.hasMoreElements())
  {
    int node2=((Integer)e2.nextElement()).intValue();
    Node n=Node.find(node2);
    String p=Node.find(n.getFather()).getPath();
    int cint = 0;
    if(p!=null&&!p.equals(last))
    {
      for(int i=last.split("/").length-p.split("/").length;i>-1;i--)
      {
        out.print("</div>");
      }
      out.print("<div class='tree'  >");
      last=p;
    }

    out.print("<img src='/tea/image/tree/tree_minus.gif' onclick='f_ex(this)'  id=img"+node2+">");
    out.print("<span id = span"+node2+">");
   		 out.print("<a href='/servlet/Node?node="+node2+"' target='_blank'>"+n.getSubject(teasession._nLanguage)+"<br/></a>");
    out.print("</span>");
    ArrayList al=(ArrayList)hm.get(new Integer(node2));
    if(al!=null)
    {
      out.print("<div class='tree'>");
      for(int i=0;i<al.size();i++)
      {
        int lid=((Integer)al.get(i)).intValue();
        String name=Listing.find(lid).getName(teasession._nLanguage);

        out.print("<span id=id"+lid+" ");
        /*
        boolean f = false;
        if(AccessMember.find(node2,teasession._rv).getListings()!=null && AccessMember.find(node2,teasession._rv).getListings().indexOf("/"+lid+"/")!=-1)
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
        */
        out.print(">");

        out.print("<input name='listings' type='checkbox' view=\""+name+"\" value='"+lid+"' ");


          if(listings!=null && listings.indexOf("/"+lid+"/")!=-1)
          {
                  out.print(" checked ");
          }

        out.print(" id='"+lid+"' /><label for='"+lid+"'>"+name+"</label><br/>");

       out.print("</span>");
      }
      out.print("</div>");
    }

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
<input type="submit" class="edit_button" id="edit_submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input type="button" class="edit_button" id="edit_submit" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="window.history.back();">
</FORM>

<script type="">try{ form1.member.focus(); }catch(e){}</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>
