<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
                          /*
                           java.util.Enumeration enumer=request.getParameterNames();
                          StringBuffer sql=new StringBuffer();
                          while(enumer.hasMoreElements())
                          { String paramname=(String)enumer.nextElement();
                            sql.append(" AND "+param +" like "+tea.db.DbAdapter.cite("%"+request.getParameter("paramname")+"%"));
                          }
                          */
                          String param=request.getParameter("Name");//用户姓名
                          StringBuffer sql=new StringBuffer(" FROM Profile,ProfileLayer WHERE Profile.member=ProfileLayer.member");
                          if(param!=null&&param.length()>0)
                          {
                            sql.append(" AND ProfileLayer.firstname like '%"+param+"%'");
                          }
                          param=request.getParameter("Email");
                          if(param!=null&&param.length()>0)
                          {
                            sql.append(" AND ProfileLayer.email like '%"+param+"%'");
                          }
                          param=request.getParameter("Mobile");
                          if(param!=null&&param.length()>0)
                          {
                            sql.append(" AND Profile.mobile like '%"+param+"%'");
                          }
                          param=request.getParameter("ISHasPhoto");
                          if(param!=null&&param.length()>0)
                          {
                            sql.append(" AND DATALENGTH(photo)>0");
                          }
                          param=request.getParameter("Gender");//性别
                          if(param!=null&&param.length()>0)
                          {
                            sql.append(" AND Profile.sex="+param);
                          }
                          param=request.getParameter("StartYear");//用户年龄
                          if(param!=null&&param.length()>0)
                          {
                            sql.append(" AND Profile.age>="+param);
                          }
                          param=request.getParameter("EndYear");//用户年龄
                          if(param!=null&&param.length()>0)
                          {
                            sql.append(" AND Profile.age<="+param);
                          }
                          param=request.getParameter("Province");//地 区
                          if(param!=null&&param.length()>0)
                          {
                            sql.append(" AND ProfileLayer.state="+tea.db.DbAdapter.cite( param));
                          }
                          tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
                          int pos=1;
                          if(request.getParameter("pos")!=null)
                          pos=Integer.parseInt(request.getParameter("pos"));
                          //System.out.println("SELECT COUNT(Profile.member)"+sql.toString());
                          int count=dbadapter.getInt("SELECT COUNT(Profile.member)"+sql.toString());
                          int PAGESIZE=5;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">
<!--
		var bshow = 1; // 0为关闭状态，1为打开状态
		function MouseOver()
		{

			document.form1.oImg.src = "../Images/Icon/ball2.gif";
			if( bshow == 1)
			{
				document.form1.oImg.title = "关闭一般搜索";
			}
			else
			{
				document.form1.oImg.title = "打开一般搜索";
			}
			document.form1.oImg.style.cursor = "hand";
		}
		function MouseDown()
		{

			document.form1.oImg.src = "../Images/Icon/ball3.gif";
			if( bshow == 1)
			{
				divoption.style.display = "none";
				bshow = 0;
			}
			else
			{
				divoption.style.display = "block";
				bshow = 1;
			}
		}
		function MouseOut()
		{

			document.form1.oImg.src = "../Images/Icon/ball1.gif";
		}
//-->
		</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Search")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FONT face="宋体"></FONT>
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr>
    <td height="933" vAlign="top"><form id="form1" name="form1" action="" method="get">
        <table cellSpacing="5" cellPadding="0" width="100%" border="0">
          <tr>
            <td vAlign="top" width="31%" height="508"><table  cellSpacing="0" cellPadding="0" width="100%" border="0">
                <tr>
                  <td  height="30"><table  cellSpacing="0" cellPadding="0" width="100%" border="0">
                      <tr>
                        <td  align="center" height="25">搜 索</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td vAlign="top"><table cellSpacing="0" cellPadding="0" width="100%" border="0">
                      <tr>
                        <td  height="79"><table cellSpacing="0" cellPadding="5" border="0">
                            <tr>
                              <td  align="right" width="60">用户姓名</td>
                              <td><input id="Name" type="text" size="20" name="Name">
                              </td>
                            </tr>
                            <tr>
                              <td  align="right" width="60">电子邮件</td>
                              <td><input  id="Email" type="text" size="20" name="Email"></td>
                            </tr>
                            <tr>
                              <td  align="right" width="60">手机号码</td>
                              <td><input  id="Mobile" type="text" size="20" name="Mobile"></td>
                            </tr>
                          </table></td>
                      </tr>
                    </table>
                    <div id="divoption" style="DISPLAY: block">
                      <table height="376" width="100%">
                        <tr>
                          <td ><table cellSpacing="0" cellPadding="5" width="100%" border="0">
                              <tr >
                                <td align="right" width="60" height="36">有照片</td>
                                <td><input id="ISHasPhoto"  id="CHECKBOX" type="CHECKBOX" CHECKED value="1" name="ISHasPhoto">
                                </td>
                              </tr>
                            </table></td>
                        </tr>
                        <tr>
                          <td  height="56"><table height="54" cellSpacing="0" cellPadding="5" width="100%" border="0">
                              <tr>
                                <td  style="HEIGHT: 27px" align="right" width="60" height="27">用户性别
                                  <label></label>
                                  <label></label>
                                </td>
                                <td  style="HEIGHT: 27px"><label>
                                  <select name="Gender">
                                    <option value="">------不限---</option>
                                    <option value="1">-----男---</option>
                                    <option value="0">-----女---</option>
                                  </select>
                                  <INPUT id="CHECKBOX" type="CHECKBOX" CHECKED value="男" name="Gender">
&nbsp;男&nbsp;
                                  <INPUT id="CHECKBOX" type="CHECKBOX" CHECKED value="女" name="Gender">
                                  </label>
                                  <label>女 </label>
                                </td>
                              </tr>
                              <tr>
                                <td  align="right" width="60" height="24"><label>用户年龄 </label>
                                </td>
                                <td ><input  id="StartYear" type="text" size="5" name="StartYear">
                                  到
                                  <input  id="EndYear" type="text" size="5" name="EndYear">
                                  岁 </td>
                              </tr>
                            </table></td>
                        </tr>
                        <tr>
                          <td  vAlign="top" height="120"><table cellSpacing="0" cellPadding="5" width="100%" border="0">
                              <tr>
                                <td  colSpan="2">和我有缘</td>
                              </tr>
                              <tr>
                                <td  height="75"><input id="SameCity"  id="CHECKBOX" type="CHECKBOX" value="同城" name="SameCity">
                                  同城<br>
                                  <input id="SameHomeTown"  id="CHECKBOX" type="CHECKBOX" value="同乡" name="SameHomeTown">
                                  同乡<br>
                                  <input id="SameCompany"  id="CHECKBOX" type="CHECKBOX" value="同事" name="SameCompany">
                                  同事<br>
                                </td>
                                <td  height="75"><input id="SameAge"  id="CHECKBOX" type="CHECKBOX" value="同龄" name="SameAge">
                                  同龄<br>
                                  <input id="SameBloodType"  id="CHECKBOX" type="CHECKBOX" value="同血型" name="SameBloodType">
                                  同血型<br>
                                  <input id="SameIndustry"  id="CHECKBOX" type="CHECKBOX" value="同行业" name="SameIndustry">
                                  同行业<br>
                                </td>
                              </tr>
                            </table></td>
                        </tr>
                        <tr>
                          <td  vAlign="top" height="200"><table cellSpacing="0" cellPadding="5" width="100%" border="0">
                              <tr>
                                <td >用户交友目的</td>
                              </tr>
                              <tr>
                                <td  height="97"><input id="Intention"  id="CHECKBOX" type="CHECKBOX" CHECKED value="知心朋友" name="Intention">
                                  知心朋友 <br>
                                  <input id="Intention"  id="CHECKBOX" type="CHECKBOX" CHECKED value="开心玩伴" name="Intention">
                                  开心玩伴<br>
                                  <input id="Intention"  id="CHECKBOX" type="CHECKBOX" CHECKED value="商务事业朋友" name="Intention">
                                  商务事业朋友<br>
                                  <input id="Intention"  id="CHECKBOX" type="CHECKBOX" CHECKED value="浪漫情缘" name="Intention">
                                  浪漫情缘<br>
                                  <input id="Intention"  id="CHECKBOX" type="CHECKBOX" CHECKED value="来者不拒" name="Intention">
&nbsp;<FONT face="宋体">来者不拒</FONT> </td>
                              </tr>
                            </table>
                            <table height="30" cellSpacing="0" cellPadding="5" width="100%" border="0">
                              <tr>
                                <td  colSpan="2">用户感情生活 </td>
                              </tr>
                              <tr>
                                <td  style="WIDTH: 81px" width="81">&nbsp;</td>
                                <td><select  id="MarriageState" style="WIDTH: 140px" name="MarriageState">
                                    <option value="0" selected>请选择</option>
                                    <option value="1">单身贵族</option>
                                    <option value="2">寻觅中</option>
                                    <option value="3">恋爱中</option>
                                    <option value="4">长期预定</option>
                                    <option value="5">已婚</option>
                                    <option value="6">同居</option>
                                    <option value="7">分居</option>
                                    <option value="8">离异</option>
                                    <option value="9">总之你还有机会</option>
                                  </select></td>
                              </tr>
                            </table></td>
                        </tr>
                        <tr>
                          <td  height="68"><table cellSpacing="0" cellPadding="5" width="100%" border="0">
                              <tr>
                                <td  style="WIDTH: 81px" align="right" width="81">地 区</td>
                                <td><select  id="select2" style="WIDTH: 140px" name="Province">
                                    <option value="" selected>请选择</option>
                                    <option value="1">北京市</option>
                                    <option value="2">辽宁省</option>
                                    <option value="3">广东省</option>
                                    <option value="4">浙江省</option>
                                    <option value="5">江苏省</option>
                                    <option value="6">山东省</option>
                                    <option value="7">四川省</option>
                                    <option value="8">黑龙江省</option>
                                    <option value="9">湖南省</option>
                                    <option value="10">湖北省</option>
                                    <option value="11">上海市</option>
                                    <option value="12">福建省</option>
                                    <option value="13">陕西省</option>
                                    <option value="14">河南省</option>
                                    <option value="15">安徽省</option>
                                    <option value="16">重庆市</option>
                                    <option value="17">河北省</option>
                                    <option value="18">吉林省</option>
                                    <option value="19">江西省</option>
                                    <option value="20">天津省</option>
                                    <option value="21">广西省</option>
                                    <option value="22">山西省</option>
                                    <option value="23">内蒙古</option>
                                    <option value="24">甘肃省</option>
                                    <option value="25">贵州省</option>
                                    <option value="26">新疆</option>
                                    <option value="27">云南省</option>
                                    <option value="28">宁夏</option>
                                    <option value="29">海南省</option>
                                    <option value="30">青海省</option>
                                    <option value="31">西藏</option>
                                    <option value="32">港澳台</option>
                                    <option value="33">海外</option>
                                  </select>
                                </td>
                              </tr>
                              <tr>
                                <td  style="WIDTH: 81px" align="right" width="81" height="29">行 业</td>
                                <td><select  id="Industry" style="WIDTH: 140px" name="Industry">
                                    <option value="0" selected>请选择</option>
                                    <option value="1">金融业</option>
                                    <option value="2">服务业</option>
                                    <option value="3">信息产业</option>
                                    <option value="4">制造业</option>
                                    <option value="5">传播业</option>
                                    <option value="6">教育</option>
                                    <option value="7">政府机构</option>
                                    <option value="8">医疗保健</option>
                                    <option value="9">房地产</option>
                                    <option value="10">其它</option>
                                  </select></td>
                              </tr>
                            </table></td>
                        </tr>
                        <tr>
                          <td  vAlign="top" height="90"><table cellSpacing="0" cellPadding="5" width="100%" border="0">
                              <tr>
                                <td>搜索范围</td>
                              </tr>
                              <tr>
                                <td  height="70"><input id="Distance"  id="radio" type="radio" CHECKED value="所有" name="Distance">
                                  所有人<br>
                                  <input id="Distance"  id="radio" type="radio" value="朋友和朋友的朋友" name="Distance">
                                  朋友和朋友的朋友<br>
                                  <input id="Distance"  id="radio" type="radio" value="朋友" name="Distance">
                                  <FONT face="宋体">朋友</FONT> </td>
                              </tr>
                            </table></td>
                        </tr>
                      </table>
                    </div>
                    <table width="100%">
                      <tr>
                        <td  align="center" height="44"><table height="24" cellSpacing="0" cellPadding="5" width="100%" border="0">
                            <tr>
                              <td width="29%"><IMG onmouseup="MouseOut()" onmousedown="MouseDown()" id="oImg" onmouseover="MouseOver()" title="打开一般搜索" onmouseout="MouseOut()" height="14" src="../Images/Icon/ball1.gif" width="14"></td>
                              <td width="71%"><input class="picButton" type="submit" value="搜索" name="Submit"></td>
                            </tr>
                          </table></td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
            <td vAlign="top" width="69%"><table  cellSpacing="0" cellPadding="0" width="100%" border="0">
                <tr>
                  <td ><table height="31" cellSpacing="0" cellPadding="0" width="100%" border="0">
                      <tr>
                        <td align="center" width="8%"><IMG height="25" src="../images/Icon/user_c_icon.gif" width="36"></td>
                        <td  width="70%"> 搜索结果 1-5人/页,按最近更换照片的顺序排列 </td>
                        <td  width="25%"> 当前第 <%=pos%> 页</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td vAlign="top"><table cellSpacing="0" cellPadding="2" width="100%" border="0">
                      <%

                          dbadapter.executeQuery("SELECT TOP "+PAGESIZE*pos+" Profile.member"+sql.toString() +" ORDER BY time DESC");
                          for(int index=0;index<PAGESIZE*(pos-1);index++)
                          dbadapter.next();
                          while (dbadapter.next()){
                            String member=dbadapter.getString(1);
                            tea.entity.member.Profile profile=tea.entity.member.Profile.find(member);

                          %>
                      <tr>
                        <td  vAlign=top align=center width=150 height=170>&nbsp;</td>
                        <td  vAlign=top><table cellSpacing="0" cellPadding="0" border="0">
                            <tr>
                              <td  style="WIDTH: 70px" width="71">姓 名</td>
                              <td  style="WIDTH: 161px" width="161"><%=profile.getFirstName(teasession._nLanguage)+" "+profile.getLastName(teasession._nLanguage)%><FONT face="宋体">&nbsp;</FONT></td>
                              <td  width="92"><A style="TEXT-DECORATION: none" href="/Friend/FriendHome.aspx?FriendID=106314" ><IMG height="8" SRC="/images/icon/dot_blue.gif" width="8" align="absMiddle" border="0">&nbsp;网友首页</A></td>
                            </tr>
                            <tr>
                              <td  style="WIDTH: 70px" width="71">性 别</td>
                              <td  style="WIDTH: 161px"><%=profile.isSex()%><FONT face="宋体">&nbsp;</FONT></td>
                              <td  style="TEXT-DECORATION: none"><A style="TEXT-DECORATION: none" href="/comment/write.aspx?FriendID=106314" ><IMG height="8" SRC="/images/icon/dot_blue.gif" width="8" align="absMiddle" border="0">&nbsp;发表评论</A></td>
                            </tr>
                            <tr>
                              <td  style="WIDTH: 70px" width="71">城 市</td>
                              <td  style="WIDTH: 161px">深圳</td>
                              <td  style="HEIGHT: 23px"><A style="TEXT-DECORATION: none" href="apply.aspx?friendid=106314" ><IMG height="8" SRC="/images/icon/dot_blue.gif" width="8" align="absMiddle" border="0">&nbsp;加为好友</A></td>
                            </tr>
                            <tr>
                              <td  style="WIDTH: 70px" width="71" height="25">好友数</td>
                              <td  style="WIDTH: 161px">795<a href="/Friend/FriendHome.aspx?FriendID=106314" ><img
                              height=160 src="http://www.heiyou.com/Upload/Thumb/35abbd40-a9c9-4e45-9ed3-674d49bc8760.jpg" width=120 border=0
                              ></a>0 位</td>
                              <td ><A style="TEXT-DECORATION: none" href="introduction.aspx?friendid=106314" ><IMG height="8" SRC="/images/icon/dot_blue.gif" width="8" align="absMiddle" border="0">&nbsp;推荐朋友</A></td>
                            </tr>
                            <tr>
                              <td  style="WIDTH: 70px" width="71" height="25">仰慕者数</td>
                              <td  style="WIDTH: 161px">2 位</td>
                              <td><A style="TEXT-DECORATION: none" href="/friend/Present.aspx?friendID=106314" ><IMG height="8" SRC="/images/icon/dot_purple.gif" width="8" align="absMiddle" border="0">&nbsp;赠送礼物</A></td>
                            </tr>
                            <tr>
                              <td  style="WIDTH: 70px" width="71" height="25">星座匹配</td>
                              <td  style="WIDTH: 161px"><A href="AstrologyMatch.aspx?friendid=106314">匹配度:40</A></td>
                              <td  vAlign="top"><A style="TEXT-DECORATION: none" href="AstrologyMatch.aspx?friendid=106314" ><IMG height="8" SRC="/images/icon/dot_blue.gif" width="8" align="absMiddle" border="0">&nbsp;星座匹配</A></td>
                            </tr>
                            <tr>
                              <td  style="WIDTH: 70px" width="71" height="25">上次登录</td>
                              <td  style="WIDTH: 161px">2005年06月09日</td>
                              <td  vAlign="top">&nbsp;</td>
                            </tr>
                            <tr>
                              <td  style="WIDTH: 70px" vAlign="top" width="71" rowSpan="2">自我介绍</td>
                              <td  style="WIDTH: 220px; WORD-WRAP: break-word" rowSpan="2">不是不想爱，不是不能爱。其实爱只是一种伤害。不是不想拥有，不是不能拥有，只是怕受伤害</td>
                            </tr>
                          </table></td>
                      </tr>
                      <%}dbadapter.close();%>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="0" width="90%" style="MARGIN: 2px">
                      <tr>
                        <td align="left"  height="20"><%
                                int pageindex=count/PAGESIZE;
                                if(count%PAGESIZE!=0)
                                pageindex++;
                                int start=pos-5;
                                if(start<=0)
                                start=1;
                                int end=pos+5;
                                if(pageindex<end)
                                end=pageindex;
                                StringBuffer href=new StringBuffer(request.getRequestURI()+"?");
java.util.Enumeration enumer=                                request.getParameterNames();
while(enumer.hasMoreElements())
{
  String name=(String)enumer.nextElement();
  if(!"pos".equals(name))
  href.append("&"+name+"="+request.getParameter(name));
}
href.append("&pos=");
if(pos>1){%>
                          <a href="<%=href.toString()%><%=pos-1%>">上一页</a>
                          <%}%>
                        <td align="left"  height="20"><%
                                for(int index=start;index<=end;index++)
                                {if(pos!=index){
                                %>
                          <a href="<%=href.toString()%><%=index%>">
                          <%}out.print(index);%>
                          </a>&nbsp;
                          <%}%>
                        <td align="right" ><%if(pageindex>pos){%>
                          <a href="<%=href.toString()%><%=pos+1%>">下一页</a>
                          <%}%>
&nbsp; <a href="<%=href.toString()%><%=pageindex%>">最后页</a>&nbsp; </td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table>
        <INPUT type="hidden" value="flag" name="Flag">
      </form>
      <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" >
        <tr> </tr>
      </table></td>
  </tr>
</table>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
<!-- 执行时间 0.21875 秒 -->

