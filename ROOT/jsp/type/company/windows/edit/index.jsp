<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%


%>

<DIV ID=content1>
<div id="Notice_edit">
  <input type="button" value="<%=r.getString(lang,"fj12hq3y")%>" onclick="f_open('?url=EditBulletinBoard')" /><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=BulletinBoards')" /><input type="button" value="<%=wbs[0].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden0')" /></div>
  <table id="Notice">
    <tr>
      <td id="Notice_l"><%=wbs[0].getName(lang)%></td>
      <td id="Notice_r">
        <marquee id="notice_ma" info="<%=r.getString(lang,"fj0vgqwy")%>" direction="left" scrollamount="1" scrolldelay="88" onMouseOver="this.scrollDelay=1000" onMouseOut="this.scrollDelay=1">
        <%
        Enumeration e87=Node.find(" AND father="+father87+" AND type=87",0,10);
        while(e87.hasMoreElements())
        {
          int n87=((Integer)e87.nextElement()).intValue();
          out.print("<Span ID=DynamicIDgetSubject><A HREF=javascript:f_open('.?url=ViewBulletinBoard&node="+n87+"')>"+Node.find(n87).getSubject(lang)+"</A></Span>");
        }
        %>
        </marquee>
      </td>
    </tr>
  </table>
  <div id="flash_edit"><input type="button" value="<%=r.getString(lang,"fj12hq3y")%>" onclick="f_open('?url=EditReport&mostly=')" /><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=Reports')"/><input type="button" value="<%=wbs[5].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden5')" /></div>
    <div id="flash">
    <%
    Enumeration e39=Node.find(" AND father="+father39+" AND type=39 AND mostly=1 ORDER BY node DESC",0,10);
    while(e39.hasMoreElements())
    {
      int n39=((Integer)e39.nextElement()).intValue();
      Node o39=Node.find(n39);
      Report r39=Report.find(n39);
      out.print("<DIV id=NEWS_DIV name=NEWS_DIV style=VISIBILITY:hidden;display:none;padding:0px;>");
      out.print("<DIV id=CONTENT_DIV name=CONTENT_DIV style=OVERFLOW:hidden;text-align:center;width:305px;><A HREF=javascript:f_open('.?url=ViewReport&node="+n39+"')>"+o39.getSubject(lang)+"</A></div>");
      out.print("</div>");
      out.print("<DIV id=PHOTOS_DIV name=PHOTOS_DIV style=display:none;margin:0px;padding:0px;><A HREF=javascript:f_open('.?url=ViewReport&node="+n39+"')><IMG onerror=this.style.display='none'; SRC="+r39.getPicture(lang)+" width=308 height=219></A></DIV>");
    }
    %>
    <DIV id=PHOTO_OUT_DIV></DIV>
    <DIV id=DAOHANG_OUT_DIV></DIV>
    <table><tr><td id=NEW_OUT_DIV info="<%=r.getString(lang,"fj0vgqwz")%>"></td></tr></table>

<SCRIPT language=JavaScript>
/**
 *  ????????????????????????????????????
 *  Feng 2005.3.15
 */
//????????????????????????
var news_div_array = null;
//????????????????????????
var photos_div_array = null;
//????????????????????????
var content_div_array = null;
//?????????????????????
var news_num = 0;
//???????????????????????????
var news_out_div = null;
//???????????????????????????
var photo_out_div = null;
//???????????????????????????
var daohang_out_div = null;
//????????????????????????ms
var delay_time = 5000;
//??????????????????1s
var ain_delay_time = 1;
//???????????????????????????
var now_show_index = 0;
//???????????????
var iTimerID = null;
/**
 *  ???????????????
 */
function init() {
  //?????????????????????
  news_div_array = document.getElementsByName("NEWS_DIV");
  photos_div_array = document.getElementsByName("PHOTOS_DIV");
  content_div_array = document.getElementsByName("CONTENT_DIV");
  news_out_div = document.getElementById("NEW_OUT_DIV");
  photo_out_div = document.getElementById("PHOTO_OUT_DIV");
   daohang_out_div = document.getElementById("DAOHANG_OUT_DIV");
  news_num = news_div_array.length;
  if (news_num == 0) {
    return;
  }
  //???????????????????????????
  var i = 0;
  for (i = 0; i < news_num; i++) {
    //????????????
    var new_content = content_div_array[i].innerHTML;
    /*
    new_content = new_content.replace(/<img[^>]*>/gi, '');
    new_content = new_content.replace(/<\/p>/gi, 'bbrr');
    */
    new_content = new_content.replace(/<[^>]*>/gi, '');
    new_content = new_content.replace(/\s/gi, '');
    new_content = new_content.replace(/\n\r/gi, '');
    /*
    new_content = new_content.replace(/\n\r/gi, 'bbrr');
    new_content = new_content.replace(/\n/gi, 'bbrr');
    new_content = new_content.replace(/<br>/gi, 'bbrr');
    new_content = new_content.replace(/(\&nbsp;)+/gi, '&nbsp;&nbsp;&nbsp;&nbsp;');
    new_content = new_content.replace(/(bbrr)+/gi, '<br>');
    */
    new_content = new_content.replace(/(\&nbsp;)+/gi, '');
    content_div_array[i].innerHTML =  new_content;
  }
  select_new_photo(0);
}

/**
 *  ????????????
 */
function create_new_div() {
  news_out_div.innerHTML = news_div_array[now_show_index].innerHTML;
}

/**
 *  ????????????
 */
function create_photo_div() {
  try {
    photo_out_div.filters[0].Apply();
  } catch(e) {
  }
  photo_out_div.innerHTML = photos_div_array[now_show_index].innerHTML;
  try {
    photo_out_div.filters[0].Play();
  } catch(e) {
  }
}
/**
 *  ????????????
 */
function create_daohang_div() {
  var strHtml = "";
  strHtml += "<table width=100% cellspacing=0 cellpadding=0 ><tr>";
  var i = 0;
  for (i = 0; i < news_num; i++) {
    var classstyle = "oneNewStyle";
    if (i == now_show_index) {
      classstyle = "selectedNewStyle";
    }
    strHtml += "<td align=center class='" + classstyle + "' style='cursor:pointer;' onclick='select_new_photo(" + i + ")'>" + (i + 1) + "</a></td>"
  }
  strHtml += "<td align=center style='font-size:12px;' class='daohangNewStyle'><%=wbs[5].getName(lang)%></td>"
  strHtml += "</tr></table>";
  daohang_out_div.innerHTML = strHtml;
}
/**
 *  ??????????????????
 */
function select_new_photo(index) {
  now_show_index = index;
  create_daohang_div();
  create_new_div();
  create_photo_div();
  window.clearInterval(iTimerID);
  iTimerID = window.setInterval("roll_news()", delay_time);
}
/**
 * ??????????????????
 */
function roll_news() {
  //?????????????????????
  now_show_index++;
  //??????????????????????????????????????????????????????
  if (now_show_index == news_num) {
    now_show_index = 0;
  }
  //??????????????????
  select_new_photo(now_show_index);
}

//??????????????????
init();
</SCRIPT>
  </div>

  <table id="Business">
    <tr>
      <td>
        <DIV ID="Business_WAI">
          <TABLE cellspacing="0" cellpadding="0">
            <TR>
              <TD id="Business_qy"><a href="javascript:f_show(<%=home21%>,<%=hn21.getClick()%>,0);"><%=r.getString(lang,"fj0vgqwf")%></a></TD>
              <TD id="Business_lt"><a href="javascript:f_show(<%=home21%>,<%=hn21.getClick()%>,3);"><%=r.getString(lang,"fj0vgqwg")%></a></TD>
              <TD id="Business_th"><a href="javascript:f_show(<%=home21%>,<%=hn21.getClick()%>,4);"><%=r.getString(lang,"fj0vgqwh")%></a></TD>
            </TR>
          </TABLE>
        </DIV>
        <div id="Business_bottom">
          <div id="Business_bottom_nei"><%=r.getString(lang,"fj12hq47")%>???<%=community.getStartTimeToString()%><br>
          <%=r.getString(lang,"fj12hq48")%>???<font><%=NodeAccessMonth.find(teasession._strCommunity).getTotal()%></font>
          </div>
        </div>
      </td></tr>
  </table>

<table id="Search_c" cellspacing="0" cellpadding="0">
  <tr>
    <td><input type="text" name="q" id="Search_k"/></td>
    <td><input type="button" id="Search_b" onclick="f_open('.?url=Search&q='+encodeURIComponent(document.all('q').value));" value="<%=r.getString(lang,"fj14p1yl")%>"></td>
  </tr>
</table>

<div id="Recruitment_edit"><input type="button" value="<%=r.getString(lang,"fj12hq3y")%>" onclick="f_open('?url=EditJob')" /><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=Jobs')"/><input type="button" value="<%=wbs[9].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden9')" /></div>
  <div id="Recruitment">
    <div id="Recruitment_top"><span><%=wbs[9].getName(lang)%></span></div>
    <table cellspacing="0" cellpadding="0">
      <tr><td id="Recruitment_Posts"><%=r.getString(lang,"fj12hq43")%></td><td id="Recruitment_Number"><%=r.getString(lang,"fj12hq44")%></td><td id="Recruitment_Date"><%=r.getString(lang,"fj12hq45")%></td>
      <%
      Enumeration e50=Node.find(" AND father="+father50+" AND type=50 ORDER BY node DESC",0,3);
      while(e50.hasMoreElements())
      {
        int n50=((Integer)e50.nextElement()).intValue();
        Node o50=Node.find(n50);
        Job j50=Job.find(n50,lang);
        out.print("<tr><td id=Recruitment_Posts><a href=javascript:f_open('.?url=ViewJob&node="+n50+"')>"+o50.getSubject(lang)+"</a></td>");
        out.print("<td id=Recruitment_Number>"+j50.getHeadCount()+"</td>");
        out.print("<td id=Recruitment_Date>"+o50.getTimeToString()+"</td>");
      }
      %>
    </table>
  </div>
  <div id="Ad_Big_edit"><input type="button" value="<%=r.getString(lang,"fj12hq3x")%>" onclick=f_upload('ad3');><input type="button" value="<%=wbs[13].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden13')" /></div>
    <div id="Ad_Small">
    <%
    if(adpic[3]!=null&&adpic[3].length()>0)
    {
      out.print("<a href="+(adlink[3]!=null?adlink[3]:"/")+" target=_blank><img src="+adpic[3]+"></a>");
    }
    %>
    </div>
    <%--
    <div id="Latest_edit"><input type="button" value="<%=wbs[15].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden15')" /></div>
      <div id="Latest">
        <div id="Latest_con"><div id="Latest_con_top"><%=wbs[15].getName(lang)%></div>
          <ul>
            <li><a href="#">?????????????????????</a></li>
            <li><a href="#">?????????????????????</a></li>
            <li><a href="#">?????????????????????</a></li>
            <li><a href="#">?????????????????????</a></li>
            <li><a href="#">?????????????????????</a></li>
            <li><a href="#">?????????????????????</a></li>
          </ul>
        </div>
      </div>
      --%>
      <div id="Visitors_edit"><input type="button" value="<%=wbs[16].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden16')" /></div>
<%
//????????????
out.print("<div id=Visitors>");
out.print("<div id=Visitors_top><font>"+wbs[16].getName(lang)+"</font></div>");
out.print("<table id=Visitors_table cellspacing=0 cellpadding=0>");
out.print("<table id=Visitors_table cellspacing=0 cellpadding=0>");
String ehms[]=ehm.split("/");
String ehts[]=eht.split("/");
for(int i16=1;i16<ehms.length&&i16<7;i16++)
{
  out.print("<script src=http://"+OpenID.find(ehms[i16]).getProxy()+"/jsp/type/company/windows/view/ViewHits.jsp?member="+java.net.URLEncoder.encode(ehms[i16],"UTF-8")+"&time="+ehts[i16]+"></script>");
}
out.print("</table>");
out.print("</div>");
%>
		</DIV>
		<DIV ID=content3>
		<div id="content3_top_edit">
		<span id="gongs_jj_edit"><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=EditCompany1')"><input type="button" value="<%=wbs[1].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden1')" /></span>
		<span id="gongs_gk_edit" style="display:none"><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=EditCompany0')"><input type="button" value="<%=wbs[2].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden2')" /></span>
		<span id="gongs_zz_edit" style="display:none"><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=EditCompany2')"><input type="button" value="<%=wbs[3].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden3')" /></span>
		<span id="lianx_wm_edit" style="display:none"><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=EditCompany4')"><input type="button" value="<%=wbs[4].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden4')" /></span>
		</div>
			<DIV id="content3_top">
                          <ul>
                            <li><span id="gongs_jj" class="onClick_After" onClick="f_click(0,this)"><%=wbs[1].getName(lang)%></span></li>
                            <li><span id="gongs_gk" class="onClick_Ago" onClick="f_click(0,this)"><%=wbs[2].getName(lang)%></span></li>
                            <li><span id="gongs_zz" class="onClick_Ago" onClick="f_click(0,this)"><%=wbs[3].getName(lang)%></span></li>
                            <li><span id="lianx_wm" class="onClick_Ago" onClick="f_click(0,this)"><%=wbs[4].getName(lang)%></span></li>
                          </ul>
                          <%
                          {//????????????
                            String text=h.getText(lang);
                            text=text.replaceAll("(<font[^>]*>)|(<span[^>]*>)|(<div[^>]*>)|(<img[^>]*>)|(</font>)|(</span>)|(</div>)","");
                            if(text.length()>300)
                            {
                              text=text.substring(0,300)+"...";
                            }
                            out.print("<div id=gongs_jj_con info='"+r.getString(lang,"fj0vgqx0")+"'>"+text+"</div>");
                          }
                          ////////////
                          String ccat="";
                          int ccate=c.getCategory(lang);
                          if(ccate>0)
                          {
                            Node n1=Node.find(ccate);
                            Node n0=Node.find(n1.getFather());
                            ccat=n0.getSubject(lang)+"/"+n1.getSubject(lang);
                          }
                          String ccit="";
                          int ccity=c.getCity(lang);
                          if(ccity!=0)
                          {
                            ccit=Card.find(ccity).toString();
                          }
                          String cpro=c.getProduct(lang);
                          if(cpro==null)
                          {
                            cpro="";
                          }
                          String cpri=c.getPrincipal(lang);
                          if(cpri==null)
                          {
                            cpri="";
                          }
                          String cbir= c.getBirth(lang);
                          if(cbir==null)
                          {
                            cbir="";
                          }
                          String cbra=c.getBrand(lang);
                          if(cbra==null)
                          {
                            cbra="";
                          }
                          %>
                          <div id="gongs_gk_con">
                            <table cellspacing="0" cellpadding="0">
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqwq")%>???</td>
                                <td id="gongs_gk_con_right"><%=ccat%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqwr")%>???</td>
                                <td id="gongs_gk_con_right"><%=ccit%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqws")%>???</td>
                                <td id="gongs_gk_con_right"><%=cpro%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqwt")%>???</td>
                                <td id="gongs_gk_con_right"><%=Company.ENROL_TYPE[c.getEnrol(lang)]%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqwu")%>???</td>
                                <td id="gongs_gk_con_right"><%=Company.SIZE_TYPE[c.getScale(lang)]%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqwv")%>???</td>
                                <td id="gongs_gk_con_right"><%=cpri%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqww")%>???</td>
                                <td id="gongs_gk_con_right"><%=Company.PROPERTY_TYPE[c.getProperty(lang)]%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqwx")%>???</td>
                                <td id="gongs_gk_con_right"><%=cbir%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj0vgqxb")%>???</td>
                                <td id="gongs_gk_con_right"><%=cbra%></td>
                              </tr>
                            </table>
                          </div>
                          <div id="gongs_zz_con" info="<%=r.getString(lang,"fj0vgqx1")%>">
                          <%
                          String qualification[] = c.getQualification();
                          for(int i=0;i<qualification.length;i++)
                          {
                            if(qualification[i]!=null&&qualification[i].length()>0)
                            {
                              out.print("<img src="+qualification[i]+" width=250 height=180>");
                            }
                          }

                          String cadd=c.getAddress(lang);
                          if(cadd==null)
                          {
                            cadd="";
                          }
                          String czip=c.getZip(lang);
                          if(czip==null)
                          {
                            czip="";
                          }
                          String ctel=c.getTelephone(lang);
                          if(ctel==null)
                          {
                            ctel="";
                          }
                          String cfax=c.getFax(lang);
                          if(cfax==null)
                          {
                            cfax="";
                          }
                          String ccon=c.getContact(lang);
                          if(ccon==null)
                          {
                            ccon="";
                          }
                          String cweb=c.getWebPage(lang);
                          if(cweb==null)
                          {
                            cweb="";
                          }
                          String cema=c.getEmail(lang);
                          if(cema==null)
                          {
                            cema="";
                          }
                          %>
                          </div>
                          <div id="lianx_wm_con">
                            <table  cellspacing="0" cellpadding="0">
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj14p1xv")%>???</td>
                                <td id="gongs_gk_con_right"><%=h.getSubject(lang)%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj14p1xw")%>???</td>
                                <td id="gongs_gk_con_right"><%=cadd%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj14p1xx")%>???</td>
                                <td id="gongs_gk_con_right"><%=czip%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj14p1xy")%>???</td>
                                <td id="gongs_gk_con_right"><%=ctel%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj14p1xz")%>???</td>
                                <td id="gongs_gk_con_right"><%=cfax%></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj14p1y0")%>???</td>
                                <td id="gongs_gk_con_right"><%=ccon%> </td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left"><%=r.getString(lang,"fj14p1y1")%>???</td>
                                <td id="gongs_gk_con_right"><a href="<%=cweb%>" target=_blank><%=cweb%></a></td>
                              </tr>
                              <tr>
                                <td id="gongs_gk_con_left">E-Mail???</td>
                                <td id="gongs_gk_con_right"><a href="mailto:<%=cema%>"><%=cema%></a> </td>
                              </tr>
                            </table>
                          </div>
			</DIV>
			<div id="content3_news_edit">
			<span id="gongs_news_edit"><input type="button" value="<%=r.getString(lang,"fj12hq3y")%>" onclick="f_open('?url=EditReport')" /><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=Reports')"/><input type="button" value="<%=wbs[6].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden6')" /></span>
			<span id="qiy_wh_edit" style="display:none"><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=EditCompany3')" /><input type="button" value="<%=wbs[7].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden7')" /></span>
			</div>
			<div id="content3_news">
				<ul>
				<li><span id="gongs_news" class="onClick_After" onClick="f_click(1,this);"><%=wbs[6].getName(lang)%></span></li>
				<li><span id="qiy_wh" onClick="f_click(1,this);"><%=wbs[7].getName(lang)%></span></li>
				</ul>
                                <!--????????????-->
				<div id="gongs_news_con" info="<%=r.getString(lang,"fj0vgqx2")%>">
                                <%
                                e39=Node.find(" AND father="+father39+" AND type=39 ORDER BY node DESC",0,6);// AND mostly=0
                                if(e39.hasMoreElements())
                                {
                                  String p39=null;
                                  out.print("<table cellspacing=0 cellpadding=0><tr><td id=gongs_news_con_left><img id=p39 width=120 height=100 style=display:none onload=style.display='';></td><td id=gongs_news_con_right><ul>");
                                  while(e39.hasMoreElements())
                                  {
                                    int n39=((Integer)e39.nextElement()).intValue();
                                    if(p39==null||p39.length()==0)
                                    {
                                      p39=Report.find(n39).getPicture(lang);
                                    }
                                    Node o39=Node.find(n39);
                                    String s39=o39.getSubject(lang);
                                    if(s39.length()>20)
                                    {
                                      s39=s39.substring(0,18)+"...";
                                    }
                                    out.print("<li><a href=javascript:f_open('.?url=ViewReport&node="+n39+"')>"+s39+"</a></li>");
                                  }
                                  out.print("<script>p39.src='"+p39+"';</script>");
                                  out.print("</ul></td></tr></table>");
                                }
                                %>
				</div>
                                <!--????????????-->
				<div id="qiy_wh_con" info="<%=r.getString(lang,"fj0vgqx3")%>">
				<%
				String culturepicture=c.getCulturePicture(lang);
				String culturecontent=c.getCultureContent(lang);
				if(culturepicture!=null&&culturepicture.length()>0)
				{
                                  out.print("<img src="+culturepicture+" width=150 height=120>");
				}
				if(culturecontent!=null)
				{
                                  out.print(culturecontent);
				}
				%>
				</div>
			</div>
			<div id="Ad_Big_edit"><input type="button" value="<%=r.getString(lang,"fj12hq3x")%>" onclick=f_upload('ad2');><input type="button" value="<%=wbs[12].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden12')" /></div>
			<div id="Ad_Big">
			<%
			if(adpic[2]!=null&&adpic[2].length()>0)
			{
                          out.print("<a href="+(adlink[2]!=null?adlink[2]:"/")+" target=_blank><img src="+adpic[2]+" width=480 height=80></a>");
			}
			%>
			</div>
<!--????????????-->
<div id="Products_edit"><input type="button" value="<%=r.getString(lang,"fj12hq3y")%>" onclick="f_open('?url=EditGoods')" /><input type="button" value="<%=r.getString(lang,"fj12hq3z")%>" onclick="f_open('?url=Goodss')"/><input type="button" value="<%=wbs[14].isHidden()?r.getString(lang,"fj12hq42"):r.getString(lang,"fj12hq40")%>" onclick="f_open('?act=hidden14')" /></div>
  <div id="Products">
    <div id="Products_top"><span><%=wbs[14].getName(lang)%></span></div>
    <ul id="products_ul" info="<%=r.getString(lang,"fj0vgqx4")%>">
    <%
    Enumeration e34=Node.find(" AND path LIKE "+DbAdapter.cite(n34.getPath()+"%")+" AND type=34 ORDER BY node DESC",0,12);
    while(e34.hasMoreElements())
    {
      int id34=((Integer)e34.nextElement()).intValue();
      Node o34=Node.find(id34);
      Goods g34=Goods.find(id34);
      String sp=g34.getSmallpicture(lang);
      if(sp==null||sp.length()<1)
      {
        sp="/tea/image/eyp/images/null_80x80.jpg";
      }
      out.print("<li><img src="+sp+" width=80 height=80><br><a href=javascript:f_open('.?url=ViewGoods&node="+id34+"')>"+o34.getSubject(lang)+"</a></li>");
    }
    %>
    </ul>
  </div>


  <DIV>
  </DIV>
  <DIV ID=Content2></DIV>




