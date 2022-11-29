<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;

Resource r=new Resource();

int cgroup=0;
String tmp=request.getParameter("cgroup");
if(tmp!=null&&tmp.length()>0)
{
  cgroup=Integer.parseInt(tmp);
}

int pos=0;
String spos=request.getParameter("pos");
if(spos!=null)pos=Integer.parseInt(spos);

StringBuffer sql = new StringBuffer();
StringBuffer par=new StringBuffer();
boolean isSel = false;//是否查询

par.append("?community=").append(teasession._strCommunity);
par.append("&cgroup=").append(cgroup);
String name = request.getParameter("member");

if(name!=null&&name.length()>0){
  isSel = true;
  sql.append(" AND member like '%"+name+"%'");
  par.append("&member=").append(name);
}
par.append("&pos=");

int sum=0;
if(!isSel){
  sum = AdminUnit.countByCommunity(teasession._strCommunity,"");
}else{
  sum = Profile.count(sql.toString());
}
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="">
  function document.onkeydown()
  {
    var e=event.srcElement;
    if(event.keyCode==13)
    {
      document.getElementById("sun").click();
      return false;
    }
  }

  function selmem(){
    var un = document.getElementById('member').value;
    var cg = document.form1.cgroup.value;
    window.location.href=encodeURI('/jsp/message/NewContacts.jsp?community=<%=teasession._strCommunity%>&member='+un+"&cgroup="+cg);
  }
  </script>
  </head>
  <body>
  <h1><%=r.getString(teasession._nLanguage, "MemberId")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

    <FORM name="form1" action="/servlet/EditContact" onSubmit="return(submitText(this.cgroup,'<%=r.getString(teasession._nLanguage, "无效-分组")%>')&&submitText(this.member,'<%=r.getString(teasession._nLanguage, "InvalidMemberIds")%>'));">
      <input type="hidden" name="act" value="newcontact"/>
      <h2>添加会员ID</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td width="15%">分组</td>
          <td>
            <select name="cgroup">
              <option value="">-------------</option>
              <%
              Enumeration e=CGroup.find(member,"",0,Integer.MAX_VALUE);
              while(e.hasMoreElements())
              {
                int id=((Integer)e.nextElement()).intValue();
                CGroup obj=CGroup.find(id);
                out.print("<option value="+id);
                if(id==cgroup)
                {
                  out.print(" selected ");
                }
                out.print(">"+obj.getName(teasession._nLanguage));
              }
              %>
              </select>
          </td>

        </tr>
        <tr>
          <td><%=r.getString(teasession._nLanguage, "MemberId")%></td>
          <td><input class="edit_input"  name="member" value="<%if(name!=null)out.print(name);%>">　<input type="button" id="sun" value="查询" onclick="selmem();"/>　<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>

        </tr>
        <tr>
          <td rowspan="99" valign="top" style="padding-top:10px;">会员列表</td>
        </tr>
        <%
        if(sum>0){
          if(isSel){
            Enumeration enumer1 =tea.entity.member.Profile.findByCommunityMem(teasession._strCommunity,sql.toString(),true);
            while(enumer1.hasMoreElements())
            {
              String memberID =(String)enumer1.nextElement();
              Profile p = Profile.find(memberID);
              if(p!=null)
              {
                out.print("<tr><td nowrap=nowrap>");
                out.print("<a href=# onclick=document.form1.member.value='"+p.getMember()+"'; >"+p.getMember()+"</a> ");
                out.print("</td></tr>");
              }
            }
          }else{
            Enumeration e1 = AdminUnit.findByCommunity(teasession._strCommunity," ORDER BY sequence",pos,20);
            for(int i=1;e1.hasMoreElements();i++)
            {

              AdminUnit obj=(AdminUnit)e1.nextElement();
              int id=obj.getId();
              int fid=obj.getFather();

              out.print("<tr><td colspan=2 nowrap=nowrap>&nbsp;&nbsp;");

              out.print(obj.getPrefix());
              out.print("<b>"+obj.getName() + "</b></tr>");

              if(i < 20){
                Enumeration enumer =tea.entity.member.Profile.findByCommunityNew(teasession._strCommunity,"",id,true);
                while(enumer.hasMoreElements())
                {

                  String memberID =(String)enumer.nextElement();
                  Profile p = Profile.find(memberID);
                  if(p!=null)
                  {
                    out.print("<tr><td nowrap=nowrap >　&nbsp;&nbsp;");
                    out.print(obj.getPrefix().replaceAll("├",""));
                    out.print("<a href=# onclick=document.form1.member.value='"+p.getMember()+"'; >"+p.getMember()+"</a> ");
                    out.print("</td></tr>");
                  }
                }
              }
            }
            if(sum>20)out.print("<tr><td>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,20)+"</td></tr>");
          }
        }else{
          out.print("<tr><td colspan='5' align='center'>暂无组织机构");
        }


        %>
        </table>



    </FORM>

    <SCRIPT>form1.member.focus();</SCRIPT>

    <div id="head6"><img height="6" src="about:blank"></div>
  </body>
</html>
