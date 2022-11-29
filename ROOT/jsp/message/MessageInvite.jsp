<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ManageInvite")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD vAlign="top" width="26%"><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td height="30" class="Title"><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr>
                <td height="18" align="center" class="Caption">�ҵ����� </td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="186" valign="top"><table  border="0" cellpadding="0" cellspacing="0" class="commandTable1">
              <tr>
                <td class="Item"><a href="send_mail.aspx">�����ʼ�</a></td>
              </tr>
              <tr>
                <td class="ItemSpliter">&nbsp;</td>
              </tr>
              <tr>
                <td class="Item"><a href="mail_sendbox.aspx">������</a></td>
              </tr>
              <tr>
                <td class="ItemSpliter">&nbsp;</td>
              </tr>
              <tr>
                <td class="Item"><a href="default.aspx">�ռ���</a><FONT face="����"><img SRC="/images/Icon/mail_icon_new.gif"></FONT></td>
              </tr>
              <tr>
                <td class="ItemSpliter">&nbsp;</td>
              </tr>
              <tr>
                <td class="Item"><a href="mail_draft.aspx">�ݸ���</a></td>
              </tr>
              <tr>
                <td class="ItemSpliter">&nbsp;</td>
              </tr>
              <tr>
                <td class="Item"><a href="mail_rubbox.aspx">,����</a></A></td>
              </tr>
              <tr>
                <td class="ItemSpliter">&nbsp;</td>
              </tr>
              <tr>
                <td class="Item" nowrap style="HEIGHT: 34px"><a href="<%=request.getRequestURI()%>?act=Inbox">�յ�������</a></td>
              </tr>
              <tr>
                <td class="ItemSpliter">&nbsp;</td>
              </tr>
              <tr>
                <td class="Item"><a href="<%=request.getRequestURI()%>?act=Sent">���������</a></td>
              </tr>
            </table></td>
        </tr>
      </table></TD>
    <TD vAlign="top" width="74%"><TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <TR>
          <TD class="Title"><TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <TR>
                <td align="center" width="9%">&nbsp;</td>
                <td class="blueFont" width="91%">�鿴����</td>
              </TR>
            </TABLE>
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr>
                <td width="20%" height="23" nowrap class="blueFont">���������</td>
                <td width="20%" height="23" nowrap class="blueFont">�յ��������</td>
                <td width="20%" height="23" nowrap class="blueFont">���������</td>
                <td width="20%" height="23" nowrap class="blueFont">����״̬</td>
                <td width="20%" height="23" nowrap class="blueFont">���������</td>
              </tr>
              <%
                            int pos=0;
                            String act=request.getParameter("act");
                            if(act==null)
                            act="Inbox";
                            for(java.util.Enumeration enumeration = tea.entity.member.Message.find(act, teasession._rv, pos, 25); enumeration.hasMoreElements(); )
                            {int message=((Integer)enumeration.nextElement()).intValue();
                              tea.entity.member.Message msg=tea.entity.member.Message.find(message);

                            %>
              <tr class="TdAlterA">
                <td class="blueFont" width="20%"><a href=../friend/friendhome.aspx?friendid=116833><%=msg.getFrom()%></a></td>
                <td class="blueFont" width="20%"><a href=../friend/friendhome.aspx?friendid=117010><%=                             msg.getMessageTo()%></a></td>
                <td class="blueFont" width="20%"><a href="ViewInvite.jsp?message=<%=message%>"><%= msg.getSubject(teasession._nLanguage)%></a></td>
                <td class="blueFont" width="20%"><img src=../images/undetermined.gif alt="������" width="15" height="18"></td>
                <td width="10%" nowrap class="blueFont"><%=msg.getTime()%></td>
              </tr>
              <%}%>
              <tr>
                <td colSpan="5">&nbsp;</td>
              </tr>
            </table>
            <div id="AcceptPane" style="DISPLAY: none">
              <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                <tr>
                  <td width="7%"><IMG src="../images/icon/button_to_right.gif" width="21" height="21"></td>
                  <td class="blueFont" width="53%">��ѡ����ǽ��ܽ������룬�����/��Ĺ�ϵΪ��</td>
                  <td width="17%"><select name="RelationList" id="RelationList" style="width:104px;">
                      <option value="1">δ�����</option>
                      <option value="2">��ʶ����</option>
                      <option value="3">һ������</option>
                      <option value="4">������</option>
                      <option value="5">ֿ��</option>
                    </select></td>
                  <td></td>
                </tr>
              </table>
              <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                <tr>
                  <td width="7%"><IMG src="../images/icon/button_to_right.gif" width="21" height="21"></td>
                  <td class="blueFont" width="93%" colSpan="2">���x���/��������ģ�</td>
                </tr>
                <tr>
                  <td width="7%"></td>
                  <td class="blueFont" width="10%">���⣺</td>
                  <td><input name="AcceptMailTitle" type="text" id="AcceptMailTitle" class="Msninput" style="width:440px;" /></td>
                </tr>
                <tr class="TdAlterA">
                  <td colSpan="2"></td>
                  <td align="center"><textarea name="AcceptMailContent" id="AcceptMailContent" class="blueFont" style="BORDER-RIGHT: #b8dcbf 1px solid; BORDER-TOP: #b8dcbf 1px solid; BORDER-LEFT: #b8dcbf 1px solid; BORDER-BOTTOM: #b8dcbf 1px solid" rows="8" cols="60"></textarea>
                  </td>
                </tr>
                <tr>
                  <td colSpan="3"><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                      <tr>
                        <td width="20%"></td>
                        <td width="20%"><input type="submit" name="AcceptAndSend" value="�������벢����" id="AcceptAndSend" class="PicButton" /></td>
                        <td width="20%"></td>
                        <td width="20%"><INPUT class="PicButton" onclick="OnCancle()" type="button" value="����������"></td>
                        <td width="20%"></td>
                      </tr>
                    </table></td>
                </tr>
              </table>
            </div>
            <div id="RejectPane" style="DISPLAY: none">
              <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                <tr>
                  <td width="7%"><IMG src="../images/icon/button_to_right.gif" width="21" height="21"></td>
                  <td class="blueFont" width="93%" colSpan="2">���x���/�����˵��һ��ԭ��</td>
                </tr>
                <tr>
                  <td width="7%"></td>
                  <td class="blueFont" width="10%">���⣺</td>
                  <td><input name="RejectMailTitle" type="text" id="RejectMailTitle" class="MsnInput" style="width:440px;" /></td>
                </tr>
                <tr class="TdAlterA">
                  <td width="7%"></td>
                  <td class="blueFont" width="10%">���ݣ�</td>
                  <td width="83%">&nbsp;
                    <select name="RejectContentList" id="RejectContentList" onchange="SelectChange()">
                      <option selected="selected" value="δѡ��">δѡ��</option>
                      <option value="��ֻ������ʶ���ˡ�">��ֻ������ʶ���ˡ�</option>
                      <option value="������ϲ�ȫ���Ҳ��˽��㡣">������ϲ�ȫ���Ҳ��˽��㡣</option>
                      <option value="��������i�����ʡ�">��������i�����ʡ�</option>
                      <option value="�Ҷ��㲻����Ȥ��">�Ҷ��㲻����Ȥ��</option>
                      <option value="�����ң������أ�">�����ң������أ�</option>
                      <option value="@#@#$%^$%&amp;()(*&amp;##��">@#@#$%^$%&amp;()(*&amp;##��</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td colSpan="2"></td>
                  <td align="center"><textarea name="RejectMailContent" id="RejectMailContent" class="blueFont" style="BORDER-RIGHT: #b8dcbf 1px solid; BORDER-TOP: #b8dcbf 1px solid; BORDER-LEFT: #b8dcbf 1px solid; BORDER-BOTTOM: #b8dcbf 1px solid" rows="10" cols="60">																						</textarea>
                  </td>
                </tr>
                <tr class="TdAlterA">
                  <td colSpan="3"><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                      <tr>
                        <td width="20%"></td>
                        <td width="20%"><input type="submit" name="RejectAndSend" value="�ܾ����벢����" id="RejectAndSend" class="PicButton" /></td>
                        <td width="20%"></td>
                        <td width="20%"><INPUT class="PicButton" onclick="OnCancle()" type="button" value="����������"></td>
                        <td width="20%"></td>
                      </tr>
                    </table></td>
                </tr>
              </table>
            </div></TD>
        </TR>
      </TABLE></TD>
  </TR>
</TABLE>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
<!-- ִ��ʱ�� 0.0625 �� -->

