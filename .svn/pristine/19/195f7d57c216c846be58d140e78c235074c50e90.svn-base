<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();

StringBuffer jsu=new StringBuffer("var jsu=new Array(new Array('------------------','')");
StringBuffer jsm=new StringBuffer();

Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity,"");
while(e.hasMoreElements())
{
  AdminUnit au=(AdminUnit)e.nextElement();
  int id=au.getId();
  if(au.getFather()==0)id=0;
  jsu.append(",new Array(\""+au.getPrefix()+au.getName()+"\",\""+id+"\")");

  //me.append("group=document.createElement('OPTGROUP'); group.label=\""+au.getPrefix()+au.getName()+"\"; sel.appendChild(group);");
  jsm.append("var jsm"+id+"=new Array('----------'");
  Enumeration e2=AdminUnitSeq.findByCommunity(teasession._strCommunity,id,true);
  while(e2.hasMoreElements())
  {
    String member=(String)e2.nextElement();
    jsm.append(",\""+member+"\"");
  }
  jsm.append("); \r\n\r\n");
}
jsu.append(");");

/////////////////我的组/////
StringBuffer jscg=new StringBuffer("var jscg=new Array(new Array('------------------','0')");
StringBuffer jscm=new StringBuffer();
e=CGroup.find(teasession._rv._strV,"",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  CGroup cg=CGroup.find(id);
  jscg.append(",new Array(\""+cg.getName(teasession._nLanguage)+"\",\""+id+"\")");

  jscm.append("var jscm"+id+"=new Array('----------'");
  Enumeration e2=Contact.find(id,"",0,999);
  while(e2.hasMoreElements())
  {
    Contact c=(Contact)e2.nextElement();
    jscm.append(",\""+c.getMember()+"\"");
  }
  jscm.append("); \r\n\r\n");
}
jscg.append(");");

String tmember=request.getParameter("member");
String tunit=request.getParameter("unit");
String tname=request.getParameter("name");
String cgv="0";
String tm = request.getParameter("tm");

if(request.getParameter("cgv")!=null&&request.getParameter("cgv").length()>0){
  cgv = request.getParameter("cgv");
}


StringBuffer sql = new StringBuffer();
boolean isSel = false;//是否查询
String upname = request.getParameter("upname");

if(upname!=null&&upname.length()>0){
  isSel = true;

  sql.append(" AND member like '%"+upname+"%'");//人员

}
System.out.println(request.getHeader("user-agent"));
%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script>
    <%=jsu.toString()%>
    <%=jsm.toString()%>
    <%=jscg.toString()%>
    <%=jscm.toString()%>


    var id=opener.document.<%=tmember%>;
    var unit=opener.document.<%=tunit%>;
    var name=opener.document.<%=tname%>;
    function f_submit()
    {
      var sname = "";
      if(document.form1.sel4.value=='0'){
        alert('请选择分组');
        return false;
      }
      form1.act.value='newcgmember';
      form1.cgroup.value = form1.sel4.value;
      var op=form1.sel3.options;
      for(var i=0;i<op.length;i++)
      {
        sname=sname+op[i].text+"/";
      }
      form1.cgmember.value = sname;
      return true;
    }

    function f_load(init)
    {
      f_clear(form1.sel3.options);

      f_unit(form1.sel1);
      if(form1.isSel.value=='false'){
        f_member(form1.sel1,form1.sel2);
      }

        f_cgroup(form1.sel4,true);

      var slt = form1.sel4;
      var cgv = <%=cgv%>;
      for(var i = 0; i < slt.options.length; i ++){
        if(slt.options[i].value==cgv){
          slt.options[i].selected=true;
        }
      }

      var tm = '<%=tm%>';
      if(tm.length>0){
        var tt = tm.split('/');
        for(var j = 0; j < tt.length-1; j++){
          form1.sel3.options[form1.sel3.options.length] = new Option(tt[j],tt[j]);
        }
      }
    }

    //加载部门///
    function f_unit(s1)
    {
      var op=s1.options;
      f_clear(op);
      for(var i=1;i<jsu.length;i++)
      {
        op[op.length]=new Option(jsu[i][0],jsu[i][1]);
      }
    }

    //加载组///
    function f_cgroup(s1,bool)
    {
      var op=s1.options;
      var tm = '<%=tm%>';
      f_clear(op);

      for(var i=bool?0:1;i<jscg.length;i++)
      {
        op[op.length]=new Option(jscg[i][0],jscg[i][1]);
      }

    }

    //部门-加载会员
    function f_member(s1,s2)
    {
      var o1=s1.options;
      var o2=s2.options;
      f_clear(o2);
      var x=-1;
      var si=s1.selectedIndex;
      for(var i=si;i<o1.length;i++)
      {
        var y=o1[i].text.indexOf("├");
        if(i!=si && x>=y)
        {
          break;
        }
        if(i==si)
        {
          x=y;
        }
        var me=eval("jsm"+o1[i].value);
        for(var j=1;j<me.length;j++)
        {
          o2[o2.length]=new Option(me[j],me[j]);
        }
      }
    }
    //组-加载会员
    function f_cmember(s1,s2)
    {
      var o1=s1.options;
      var o2=s2.options;
      f_clear(o2);
      if(s1.value!="0")
      {
        if(form1.otype.value=='upd'){

          form1.cgroup.value = s1.value;
          for(var i = 0; i <jscg.length; i ++){
            if(jscg[i][1] == s1.value){
              form1.name.value = jscg[i][0];
            }
          }
        }
        var me=eval("jscm"+s1.value);
        for(var j=1;j<me.length;j++)
        {
          o2[o2.length]=new Option(me[j],me[j]);
        }
      }
    }

    function f_clear(op)
    {
      while(op.length>0)
      {
        op[0]=null;
      }
    }
    function f_sel(sel)
    {
      var op=sel.options;
      for(var i=0;i<op.length;i++)
      {
        op[i].selected=true;
      }
    }

    function paspar(){
      var upname = document.form1.upname.value;
      form1.cgroup.value = form1.sel4.value;

      var sname = "";
      var op=form1.sel3.options;
      for(var i=0;i<op.length;i++)
      {
        sname=sname+op[i].text+"/";
      }
      form1.cgmember.value = sname;

      var url = encodeURI('/jsp/user/list/TeamManage.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.tunit&name=form1.name&upname='+upname+'&tm='+form1.cgmember.value+'&cgv='+form1.cgroup.value);
      window.location.href=url;
    }

    function document.onkeydown()
    {
      var e=event.srcElement;
      if(event.keyCode==13)
      {
        document.getElementById("sun").click();
        return false;
      }
    }

    function cg_show(act){
      var cg = 'none';
      if(act == 'add'){
        form1.otype.value=act;
        form1.name.value = '';
        document.getElementById('addcg').style.display = '';
      }else{
        if(form1.sel4.value == '0'){
          alert('请选择组');
          document.getElementById('addcg').style.display = 'none';
        }else{
          document.getElementById('addcg').style.display = '';
        }
        form1.otype.value=act;
        form1.name.value = jscg[form1.sel4.value][0];
      }
    }

    function cg_submit(obj){
      if(obj == 'edit'){
        if(form1.name.value.length ==0){
          alert('无效组名');
          return false;
        }
      }

      if(form1.otype.value == 'upd'&&form1.cgroup.value=='0'){
        alert('请选择组');
        return false;
      }
      if(obj == 'delete'){
        if(form1.sel4.value=='0'){
          alert('请选择组');
          return false;
        }else{
          form1.cgroup.value = form1.sel4.value;
        }
      }

      form1.act.value = obj;
      form1.action='/servlet/EditCGroup';

      form1.submit();
    }
    </script>
    </head>
    <body onload="f_load();">

    <h1>分组管理</h1>
    <form name="form1" action="/servlet/EditContact" onSubmit="return f_submit();">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
    <input type="hidden" name="act">
    <input type="hidden" name="otype">
    <input type="hidden" name="cgmember"/>
    <input type="hidden" name="cgroup" value="0"/>
    <input type="hidden" name="nexturl" value="/jsp/user/list/TeamManage.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.tunit&name=form1.name"/>
    <input type="hidden" name="isSel" value="<%=isSel%>"/>


    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

      <tr id="tr0">
        <td width="10%">名称&nbsp;</td>
        <td>
          <input type="text" name="upname" value="<%if(upname!=null)out.print(upname);%>"/>&nbsp;<input id="sun" type="button" style="width:34px;" value="GO" onclick="paspar();"/>
        </td>
      </tr>
      <tr>
        <td>组&nbsp;</td>
        <td><select name="sel4" style="width:131px" onchange="f_cmember(this,form1.sel3);"></select>&nbsp;<input type="button" value="创建" onclick="cg_show('add');"/>&nbsp;<input type="button" value="编辑" onclick="cg_show('upd');"/>&nbsp;<input type="button" value="删除" onclick="if(confirm('是否删除该组？'))return cg_submit('delete');"/>　
</td>
      </tr>

      <tr id="addcg" style="display:none;">
        <td>组名&nbsp;</td>
        <td><input type="text" name="name" />&nbsp;<input type="button" value="提交" onclick="return cg_submit('edit');"/>&nbsp;<input type="button" value="隐藏" onclick="document.getElementById('addcg').style.display='none';"/></td>
      </tr>

      <tr><td>部门&nbsp;</td><td><select name="sel1" onchange="f_member(this,form1.sel2);"></select>

        <label id="addcg" style="display:none;"> </label>
      </td></tr>

      <tr>
        <td>选择</td>
        <td>
          <table>
            <tr><td align="center">备选<br />
              <select name="sel2" size="12" multiple style="width:150px " ondblclick="move(form1.sel2,form1.sel3,false);">
              <%
              if(isSel){

                Enumeration enumer1 =tea.entity.member.Profile.findByCommunityMem(teasession._strCommunity,sql.toString(),true);
                while(enumer1.hasMoreElements())
                {
                  String member =(String)enumer1.nextElement();
                  out.print("<option value="+member+" >"+member+"</option>");
                }

              }
              %>
              </select>
        </td>
        <td>
          <!--input type="button" value="&gt;&gt;| " onclick="move2(form1.sel2,form1.sel3,false);"><br-->
            <input type="button" value=" &gt;&gt; " onclick="move(form1.sel2,form1.sel3,false);"><br><br>
            <input type="button" value=" &lt;&lt; " onclick="move(form1.sel3,form1.sel2,true);"><br>
            <!--input type="button" value=" |&lt;&lt;" onclick="move2(form1.sel3,form1.sel2,true);"-->
        </td>
        <td align="center">已选<br />
          <select name="sel3" size="12" multiple style="width:150px " ondblclick="move(form1.sel3,form1.sel2,true);">
          <%
          System.out.println(tm);
          if(tm!=null){
            String[] tmem = tm.split("/");
            for(int i = 0; i < tmem.length; i ++){
              out.print("<option value="+tmem[i]+" >"+tmem[i]+"</option>");
            }
          }
          %>
          </select>
        </td></tr>
          </table>
</td>
      </tr>
    </table>

    <input type="submit" value="确定"/>
    <input type="button" value="返回" onclick="window.location.href='/jsp/user/list/SelMembers2.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.tunit&name=form1.name';"/>

    </form>

    </body>
</html>
<!--
参数说明:
type
0:通迅录人员
1:内部人员(可以进后台的)

field:
没有:手机号
email:邮箱
member:会员ID
-->

