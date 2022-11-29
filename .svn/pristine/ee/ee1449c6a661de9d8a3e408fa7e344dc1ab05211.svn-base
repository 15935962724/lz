<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.net.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}


Node node=Node.find(teasession._nNode);

AccessMember obj_am = AccessMember.find(teasession._nNode, teasession._rv._strV);
boolean bool=teasession._rv.isWebMaster()||teasession._rv.isOrganizer(teasession._strCommunity);
boolean bool2=obj_am.getPurview()==3;
if (!bool && !node.isCreator(teasession._rv) && !bool2)
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/node/access/NewAccessMembers");

int accessmember=0;
String tmp=request.getParameter("accessmember");
if(tmp!=null)
{
  accessmember=Integer.parseInt(tmp);
}

int style=0,purview=0;
String member=request.getParameter("member"),type="/",category="/";
boolean auditing=false;
if(accessmember!=0)
{
  AccessMember obj= AccessMember.find(accessmember);
  member=obj.getMember();
  style=obj.getStyle();
  purview = obj.getPurview();
  type = obj.getType();
  category =obj.getCategory();
  auditing=obj.isAuditing();
}


StringBuffer t1=new StringBuffer();
StringBuffer t2=new StringBuffer();
StringBuffer c1=new StringBuffer();
StringBuffer c2=new StringBuffer();

CLicense obj=CLicense.find(node.getCommunity());
String clt="/0"+obj.getType();

//添加别名类//
Enumeration e=TypeAlias.find();
while(e.hasMoreElements())
{
  int id = ((Integer)e.nextElement()).intValue();
  clt=clt+id+"/";
}


String lt0=obj_am.getType(),lt1=obj_am.getCategory();

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
  String str="<option value="+j+">"+name;
  //是组织者 || 只能授自已勇用的权限
  if(bool || lt0.indexOf("/"+j+"/")!=-1)
  {
    if(type.indexOf("/"+j+"/")!=-1)
    {
      t1.append(str);
    }else
    {
      t2.append(str);
    }
  }
  if(j>1)
  {
    if(bool || lt1.indexOf("/"+j+"/")!=-1)
    {
      if(category.indexOf("/"+j+"/")!=-1)
      {
        c1.append(str);
      }else
      {
        c2.append(str);
      }
    }
  }
}

String title=r.getString(teasession._nLanguage, "CBAccessMembers");

%><html>
<head>
<title><%=title%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_submit()
{
  var t='/';
  var op=form1.type1.options;
  for(var i=0;i<op.length;i++)
  {
    t=t+op[i].value+'/';
  }
  var c='/';
  op=form1.category1.options;
  for(var i=0;i<op.length;i++)
  {
    c=c+op[i].value+'/';
  }
  form1.type.value=t;
  form1.category.value=c;
  return true;
}

</script>
</head>

<body>

<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM name="form1" METHOD=POST action="/servlet/EditAccessMember" onSubmit="return submitText(this.member,'<%=r.getString(teasession._nLanguage, "InvalidAccessMembers")%>')&&f_submit();">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="accessmember" value="<%=accessmember%>">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="type" value="/">
<input type="hidden" name="category" value="/">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "MemberIds")%>:</td>
    <td>
    <%
    if(member!=null)
    {
      out.print("<input type=hidden name=member value=\""+member+"\" size=40><input disabled value=\""+member+"\" >");
    }else
    {
      out.print("<input name=member size=40>");
    }
    %>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Style")%>:</td>
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
    <td><%=r.getString(teasession._nLanguage, "Access")%>:</td>
    <td><%
    for(int i=0;i<AccessMember.PUR_TYPE.length;i++)
    {
      out.print("<input name=purview type=radio value="+i);
      if(i==purview)out.print(" checked ");
      out.println(">"+AccessMember.PUR_TYPE[i]);
    }
    %>
    <input name="auditing" type="checkbox" value="true" <%if(auditing)out.print("checked");%> ><%=r.getString(teasession._nLanguage,"Auditing")%>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Type")%></td>
    <td>
      <table>
        <tr>
          <td>
            <select name="type1" size="10" multiple="multiple" style="width:150px" ondblclick="move(form1.type1,form1.type2,true);">
              <%=t1.toString()%>
            </select>
          </td>
          <td>
            <input type="button" value=" ← " onclick="move(form1.type2,form1.type1,true);" /><br><input type="button" value=" → " onclick="move(form1.type1,form1.type2,true);" />
          </td>
          <td>
            <select name="type2" size="10" multiple="multiple" style="width:150px" ondblclick="move(form1.type2,form1.type1,true);">
              <%=t2.toString()%>
            </select>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Category")%></td>
    <td>
      <table>
        <tr>
          <td>
            <select name="category1" size="10" multiple="multiple" style="width:150px" ondblclick="move(form1.category1,form1.category2,true);">
            <%=c1.toString()%>
            </select>
          </td>
          <td>
            <input type="button" value=" ← " onclick="move(form1.category2,form1.category1,true);" /><br><input type="button" value=" → " onclick="move(form1.category1,form1.category2,true);" />
          </td>
          <td>
            <select name="category2" size="10" multiple="multiple" style="width:150px" ondblclick="move(form1.category2,form1.category1,true);">
            <%=c2.toString()%>
            </select>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<input type="submit" class="edit_button" id="edit_submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input type="button" class="edit_button" id="edit_submit" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="window.history.back();">
</form>

<script type="">try{ form1.member.focus(); }catch(e){}</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
