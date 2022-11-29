<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%

  /*if (!tea.entity.util.Safety.find(teasession._rv.toString(),5).isExists()&&!teasession._rv.toString().equalsIgnoreCase("admin") && !License.getInstance().getWebMaster().equals(teasession._rv.toString()))
  {
    response.sendError(403);
    return;
  }*/

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();

String _strId=request.getParameter("id");
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

String q=request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  sql.append(" AND vmember LIKE ").append(DbAdapter.cite("%"+q+"%"));
  param.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND vmember IN ( SELECT member FROM ProfileLayer WHERE lastname LIKE "+DbAdapter.cite("%"+name+"%")+" OR firstname LIKE "+DbAdapter.cite("%"+name+"%")+")");
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String email=request.getParameter("email");
if(email!=null&&(email=email.trim()).length()>0)
{
  sql.append(" AND vmember IN ( SELECT member FROM Profile WHERE email LIKE "+DbAdapter.cite("%"+email+"%")+")");
  param.append("&email=").append(email);
}
param.append("&pos=");

String act=request.getParameter("act");
if("delete".equals(act))
{
  //Subscriber s = Subscriber.find(teasession._strCommunity, new RV(member));
  //s.delete();
  //删除权限
  String member=request.getParameter("member");
  for(int i=1;i<10;i++)
  {
    Safety safety=Safety.find(member,teasession._strCommunity,i);
    safety.delete();
  }
}

//" AND s.vmember NOT IN(SELECT member FROM AdminUsrRole WHERE role!='/' AND teasession._strCommunity="+DbAdapter.cite(teasession._strCommunity)+")"



//只列出有权限的会员
sql.append(" AND vmember IN ( SELECT member FROM Safety WHERE community="+DbAdapter.cite(teasession._strCommunity)+")");

r.add("/tea/ui/member/community/Subscribers");
r.add("/tea/ui/member/community/Communities");
r.add("/tea/resource/NetDisk");

String s1 = request.getParameter("pos");
int pos = s1 == null ? 0 : Integer.parseInt(s1);

int count=Subscriber.count(teasession._strCommunity,sql.toString());


String text=request.getParameter("text");

String hidden = request.getParameter("hidden");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT  type="text/javascript">
  function selectAll(form,check)
    {
     // alert(form.checkbox2);

      if(form1.checkbox2.length)
      {
        for(index=0;index<form1.checkbox2.length;index++)
        {
          if(form1.checkbox2[index].type=='checkbox')
          {
            form1.checkbox2[index].checked=check.checked;
          }
        }
      }
      else
      {
          form1.checkbox2.checked=check.checked;
      }
    }

var v="";
    function add_all()
    {
      // var ul=document.all('unitlist');
      var hidden="";
      var check=document.all('checkbox2');
      var sunsk= document.all('checkbox1');
      for(var i=0;i<check.length;i++)
      {
        if(check[i].checked)
        {
          if(v!="")
          v=v;
          v=v+","+check[i].value;
          hidden=hidden+","+sunsk[i].value;
        }
      }
      window.dialogArguments.<%=text%>.value=v;
      window.dialogArguments.<%=hidden%>.value=hidden;
      //window.returnValue = v;
      window.close();
    }
</script>
</head>
<body>
 <h1><%=r.getString(teasession._nLanguage, "Subscriber")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2><%="列表 ( "+count+" )"%></h2>
<form name="form1" action="?" method="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<input type="hidden" name="member" />
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<TR id="tableonetr">
    <td nowrap><%=r.getString(teasession._nLanguage, "MemberId")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Name")%></td>
  </tr>
 <%
 Enumeration e=Subscriber.find(teasession._strCommunity,sql.toString(),pos,25);
 while(e.hasMoreElements())
 {
   RV rv = (RV)e.nextElement();
   String s2=rv._strV;
   Profile profile = Profile.find(s2);
   %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><input type="checkbox" name="checkbox2" value="<%=profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage)%>"></td><input type="hidden" value="<%=s2%>" name="checkbox1">
    <td nowrap><%=profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage)%></td>
  </tr>
<%
}
%>
<tr><td colspan="6" align="center"><%=new FPNL(teasession._nLanguage, param.toString(), pos,count)%></td></tr>
    <tr>
        <td id=unitlist nowrap class="menulines" align="center"><input type="CHECKBOX" onclick="selectAll(form1,this)" value="0" style="cursor:hand">全选</td>
          <td><input name="button"  type="button" value="提交" onclick="add_all()" /></td>
      </tr>
</table>
</form>
</body>
</html>
