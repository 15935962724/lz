<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node=Node.find(teasession._nNode);


if(!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}

int id=0;
if(teasession.getParameter("id")!=null)
id=Integer.parseInt(teasession.getParameter("id"));

java.util.Date start=null,stop=null,zzxwsj=null;
String school=null,city=null,majorname=null,zzzymc2=null,degree=null,zzxlbh2=null,sland=null,anzeh=null,zzjgdz=null,zzxxxs=null,comment=null,zzxlbh=null;
int anzkl=0;
int majorcategory=0;
boolean zzjylx=true,zzzgxl=true,zzzgxw=true,zzbsh=true;
if(id!=0)
{
  Educate educate=Educate.find(id);
  if(educate.getNode()!=teasession._nNode)
  {
    response.sendError(403);
    return;
  }
  start=educate.getStart();
  stop=educate.getStop();
  school=educate.getSchool();
  city=educate.getCity();
  majorcategory=educate.getMajorCategory();
  majorname=educate.getMajorName();
  zzzymc2=educate.getZzzymc2();
  degree=educate.getDegree();
  zzxlbh2=educate.getZzxlbh2();
  sland=educate.getSland();
  anzkl=educate.getAnzkl();
  anzeh=educate.getAnzeh();
  zzjylx=educate.isZzjylx();
  zzxwsj=educate.getZzxwsj();
  zzjgdz=educate.getZzjgdz();
  zzxxxs=educate.getZzxxxs();
  zzzgxl=educate.isZzzgxl();
  zzzgxw=educate.isZzzgxw();
  zzbsh=educate.isZzbsh();
  comment=educate.getComment();
  zzxlbh=educate.getZzxlbh();
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

String nexturl=request.getParameter("nexturl");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="text/javascript">
function submitSelect(obj,text)
{
  if(obj.selectedIndex==0)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
  </HEAD>
  <body >
<h1><%=r.getString(teasession._nLanguage,"1167470941156")%><!--教育背景--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="Form1" method="post" action="/servlet/EditEducate"  onsubmit="return (submitText(this.tbSchoolName,'<%=r.getString(teasession._nLanguage,"1167472331375")%>')&&submitSelect(this.ddlMajorCategory,'<%=r.getString(teasession._nLanguage,"1167472360500")%>')&&submitText(this.tbMajorName,'<%=r.getString(teasession._nLanguage,"1167472380640")%>')&&submitInteger(this.anzkl,'<%=r.getString(teasession._nLanguage,"1167472396140")%>'))" id="Form1">
<input type="hidden" name="node" value="<%=teasession._nNode%>" />
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="nexturl" value="<%=nexturl%>" />

<h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"Time")%><!--Time--></td>
    <td><%=r.getString(teasession._nLanguage,"1167471003140")%><!--学校名称--></td>
    <td><%=r.getString(teasession._nLanguage,"1167471030656")%><!--专业名称--></td>
    <td><%=r.getString(teasession._nLanguage,"1167446517671")%><!--学历--></td>
    <td></td>
  </tr>
  <%
  java.util.Enumeration enumeration=Educate.find(teasession._nNode,teasession._nLanguage);
  while(enumeration.hasMoreElements())
  {
    Educate educateobj=Educate.find(((Integer)enumeration.nextElement()).intValue());

    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=educateobj.getStart("yyyy/MM")%>--<%=educateobj.getStop("yyyy/MM")%></td>
      <td><%=educateobj.getSchool()%></td>
      <td><%=educateobj.getMajorName()%></td>
      <td><%=educateobj.getDegree(teasession._nLanguage)%></td>
      <td><input class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('EditEducate.jsp?id=<%=educateobj.getId()%>&node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')"/>
        <input  class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/DeleteEducate?id=<%=educateobj.getId()%>&node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')};"/>
</td>
    </tr>

    <%} %>
</table>

      <br>
      <h2><%=r.getString(teasession._nLanguage,"1167471137156")%><!--添加/编辑--></h2>
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

              <tr>
                <td valign="baseline" align="right" width="140">
                  <span class="alert"><strong>*</strong></span>
                  <strong><%=r.getString(teasession._nLanguage,"1167471168140")%><!--开始时间--></strong></td>
                <td>
                  <select name="ymStartDate:ymYear" id="ymStartDate_ymYear" >
                    <%
                    java.util.Calendar c=java.util.Calendar.getInstance();
                    int year=c.get(java.util.Calendar.YEAR);
                    if(start!=null)
                    c.setTime(start);

                    for(int len=year;len>=1950;len--)
                    {
                      out.print("<option value=\""+len+"\" ");
                      if(start!=null&&len==c.get(java.util.Calendar.YEAR))
                      out.print("selected");
                      out.print(">"+len+"</option>");
                    }
            %>
		</select><%=r.getString(teasession._nLanguage,"1167448647531")%><!--年 -->
                <select name="ymStartDate:ymMonth" id="ymStartDate_ymMonth"  >
                <%
                    for(int len=1;len<=12;len++)
                    {
                      out.print("<option value=\""+len+"\" ");
                      if(len==c.get(java.util.Calendar.MONTH)+1)
                      out.print("selected");
                      out.print(">"+len+"</option>");
                    }
            %>
                </select><%=r.getString(teasession._nLanguage,"1167471209125")%><!--月-->
                </td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span>

                  <strong><%=r.getString(teasession._nLanguage,"1167471229125")%><!--结束时间--></strong></td>
                <td><select name="ymEndDate:ymYear" id="ymEndDate_ymYear" ><onChange="document.all['ymEndDate:ymMonth'].disabled=this.selectedIndex==0;">
			<option selected="selected" value="3000"><%=r.getString(teasession._nLanguage,"1167471250265")%><!--至今--></option>
                    <%
                    if(stop!=null)
                    c.setTime(stop);

                    for(int len=year+6;len>=1950;len--)
                    {
                      out.print("<option value=\""+len+"\" ");
                      if(stop!=null&&len==c.get(java.util.Calendar.YEAR))
                      out.print("selected");
                      out.print(">"+len+"</option>");
                    }
            %>
		</select><%=r.getString(teasession._nLanguage,"1167448647531")%><!--年 -->
                <select name="ymEndDate:ymMonth" id="ymEndDate_ymMonth"  >
                    <%
                    for(int len=1;len<=12;len++)
                    {
                      out.print("<option value=\""+len+"\" ");
                      if(len==c.get(java.util.Calendar.MONTH)+1)
                      out.print("selected");
                      out.print(">"+len+"</option>");
                    }
            %>
                </select><%=r.getString(teasession._nLanguage,"1167471209125")%><!--月--> </td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167471003140")%><!--学校名称--></strong></td>
                <td><input class="edit_input" name="tbSchoolName" id="tbSchoolName" type="text" maxlength="100" size="40" value="<%if(school!=null)out.print(school);%>" /></td>
              </tr>

              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167471303500")%><!--城市--></strong></td>
                <td><font size="2"><input class="edit_input" name="tbRegion" id="tbRegion" type="text" size="20" maxlength="30"  value="<%if(city!=null)out.print(city);%>"/>
                  </font>
                </td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167471334046")%><!--专业类别--></strong></td>
                <td><%=new tea.htmlx.MajorSelection("ddlMajorCategory",majorcategory)%></td>
              </tr>

              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167471366546")%><!--专业名称或研究方向--></strong></td>
                <td><input class="edit_input" name="tbMajorName" id="tbMajorName" type="text" maxlength="50" size="40"  value="<%if(majorname!=null)out.print(majorname);%>"/></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167471390328")%><!--第二专业名称--></strong></td>
                <td><input class="edit_input" name="zzzymc2" id="zzzymc2" type="text" maxlength="50" size="40"  value="<%if(zzzymc2!=null)out.print(zzzymc2);%>"/></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167446517671")%><!--学历--></strong></td>
                <td><font size="2"><%=new tea.htmlx.DegreeSelection("ddlDegree",degree,"finitzzxlbh();")%></font></td>
              </tr>
<tr>
    <td align="right" valign="baseline"><B><%=r.getString(teasession._nLanguage,"1167471440203")%><!--学位--></B></th>
    <td><select  name="zzxlbh" onchange=" " >
<%--
    <option value="" >无学位</option>
     <option value="Z1" <%if("Z1".equals(educate.getZzxlbh()))out.print(" selected");%>>学士学位</option>
     <option value="Z2"<%if("Z2".equals(educate.getZzxlbh()))out.print(" selected");%>>双学士学位</option>
     <option value="Z3"<%if("Z3".equals(educate.getZzxlbh()))out.print(" selected");%>>硕士学位</option>
     <option value="Z4"<%if("Z4".equals(educate.getZzxlbh()))out.print(" selected");%>>博士学位</option>
     --%>
    </select>
    <script type="">
    function finitzzxlbh()
    {
      while(Form1.zzxlbh.length>0)
      {
        Form1.zzxlbh[0]=null;
      }
      switch(Form1.ddlDegree.value)
      {
        case 'Z0':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        break;
        case 'Z1':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        break;
        case 'Z2':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        break;
        case 'Z3':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        break;
        case 'Z4':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        break;
        case 'Z5':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        break;
        case 'Z6':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        break;
        case 'Z7':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        break;
        case 'Z8':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471534703")%>","Z1");//学士学位
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471550921")%>","Z2");//双学士学位
        break;
        case 'Z9':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471586703")%>","Z3");//硕士学位
        break;
        case 'ZA':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471490750")%>","");//<!--无学位-->
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471606109")%>","Z4");//博士学位
        break;
        case 'ZB':
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471586703")%>","Z4");//硕士学位
        Form1.zzxlbh[Form1.zzxlbh.length]=new Option("<%=r.getString(teasession._nLanguage,"1167471606109")%>","Z4");//博士学位
        break;
      }
    }
    finitzzxlbh();
    for(var index=0;index<Form1.zzxlbh.length;index++)
    {
      if(Form1.zzxlbh[index].value=='<%=zzxlbh%>')
      {
        Form1.zzxlbh[index].selected=true;
        break;
      }
    }
    </script>
    </td>
    </tr>
      <tr>
    <td align="right" ><B><%=r.getString(teasession._nLanguage,"1167471660578")%><!--学历证书编号--></B></th>
    <td><input type="text" class="edit_input" name="zzxlbh2" maxlength="20" value="<%if(zzxlbh2!=null)out.print(zzxlbh2);%>"/></td>
    </tr>
  <tr>
    <td align="right" ><B>* <%=r.getString(teasession._nLanguage,"国家")%><!--国家代码--></B></th>
    <td><%=new tea.htmlx.CountrySelection("sland",teasession._nLanguage,sland)%></td>
    </tr>
    <tr><td align="right" ><B><%=r.getString(teasession._nLanguage,"1167471711984")%><!--培训课程期间--></B></td>
    <td><input type="text" class="edit_input"  name="anzkl" value="<%=anzkl%>" maxlength="5" size="5"/>
    <select name="anzeh">
    <%
    for(int index=0;index<Educate.ANZKL_TYPE.length;index++)
    {
      out.print("<option value="+Educate.ANZKL_TYPE[index][0]);
      if(Educate.ANZKL_TYPE[index][0].equals(anzeh))
      out.print(" SELECTED");
      out.print(" >"+Educate.ANZKL_TYPE[index][1]);
    }
    %>
    </select>
    </td>
    </tr>
    <tr>
    <td align="right"><B><%=r.getString(teasession._nLanguage,"1167471741812")%><!--学历类型--></B></th>
    <td><input type="radio" name="zzjylx" value="true" checked="checked"/><%=r.getString(teasession._nLanguage,"1167471761375")%><!--全日制-->
    <input type="radio" name="zzjylx" value="false" <%if(!zzjylx)out.print(" checked");%>/><%=r.getString(teasession._nLanguage,"1167471781312")%><!--在职教育-->
    </td>
    </tr>
            <tr>
    <td align="right"><B><%=r.getString(teasession._nLanguage,"1167471804546")%><!--学位授予时间--></B></th>
    <td>
    <%=new tea.htmlx.TimeSelection("zzxwsj",zzxwsj)%>(年 月 日 例如:2008-05-26)
    </td>
    </tr>
     <tr>
    <td align="right"><B><%=r.getString(teasession._nLanguage,"1167471840109")%><!--学位授予机构--></B></th>
    <td><input type="text"  class="edit_input" name="zzjgdz" value="<%if(zzjgdz!=null)out.print(zzjgdz);%>" size="40"/>
    </td>
    </tr>
         <tr>
    <td align="right"><B><%=r.getString(teasession._nLanguage,"1167471863140")%><!--学习形式--></B></th>
    <td>
    <select name="zzxxxs">
    <%
    for( int index=0;index<Educate.ZZXXXS_TYPE.length;index++)
    {      %>
      <option value="<%=Educate.ZZXXXS_TYPE[index][0]%>" <%if(Educate.ZZXXXS_TYPE[index][0].equals(zzxxxs))out.print(" selected");%>><%=Educate.ZZXXXS_TYPE[index][1]%></option>
      <%
    }
    %>
    </select>
    </td>
    </tr>
      <tr>
    <td align="right"><B><%=r.getString(teasession._nLanguage,"1167471885171")%><!--最高学历--></B></th>
    <td>
    <input name="zzzgxl" type="radio" value="true" checked="checked"><%=r.getString(teasession._nLanguage,"1167469410921")%><!--是-->
      <input name="zzzgxl" type="radio" value="false" <%if(!zzzgxl)out.print(" checked");%>><%=r.getString(teasession._nLanguage,"1167469442484")%><!--否-->
    </td>
    </tr>
    <tr>
    <td align="right"><B><%=r.getString(teasession._nLanguage,"1167471940406")%><!--最高学位--></B></th>
    <td><input name="zzzgxw" type="radio" value="true" checked="checked"><%=r.getString(teasession._nLanguage,"1167469410921")%><!--是-->
      <input name="zzzgxw" type="radio" value="false"<%if(!zzzgxw)out.print(" checked");%>><%=r.getString(teasession._nLanguage,"1167469442484")%><!--否--></td>
    </tr>
	  <!--  <tr>
    <td align="right"><B><%=r.getString(teasession._nLanguage,"1167471940406")%>博士后</B></th>
    <td><input name="zzbsh" type="radio" value="true" checked="checked"><%=r.getString(teasession._nLanguage,"1167469410921")%>是
      <input name="zzbsh" type="radio" value="false"<%if(!zzbsh)out.print(" checked");%>><%=r.getString(teasession._nLanguage,"1167469442484")%>否</td>
    </tr>-->
    <tr>
      <td valign="top" align="right"><strong><%=r.getString(teasession._nLanguage,"1167471992875")%><!--专业描述--></strong></td>
      <td><textarea  class="edit_input" name="tbComment" id="tbComment" rows="5" cols="60"><%if(comment!=null)out.print(comment);%></textarea>
        <BR><span class="note"><%=r.getString(teasession._nLanguage,"1167472040890")%><!--重点描述与你就业期望有关的信息,限800字。--></span>
          <%=r.getString(teasession._nLanguage,"1167472147515")%><!--<a href="javascript:alert(&quot;现已输入了&quot;+document.all['tbComment'].value.length+&quot;个字！&quot;);">计算字数</a>--><br>
</td>
    </tr>
            </table>
	<tr>
		<td>

      </td>
	</tr>
	<tr>
		<td><div align="center"><br>
                <!--保存&amp;新增教育背景-->
                  <input  class="edit_button" type="submit" name="btnSave" value="<%=r.getString(teasession._nLanguage,"1167472179203")%>"   id="btnSave" />
                  &nbsp;


        </div></td>
	</tr>
</table>


  <br>
<!--上一步-->
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditResume.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<!--下一步-->
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"CBNext")%>" onClick="window.open('/jsp/type/resume/EditEmployment.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<!--完成-->
<input type="button" class="edit_button" name="btnSaveAndNext" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" onClick="window.open('<%=nexturl%>','_self')"   />



  </form>
</div>
  </body>
</HTML>

