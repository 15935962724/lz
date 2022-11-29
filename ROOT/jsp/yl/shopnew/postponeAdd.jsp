<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.ActivityWarning" %>
<%@ page import="java.util.*" %>
<%@ page import="util.CommonUtils" %>
<%@ page import="tea.entity.yl.shop.ApprovalProcess" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    String nexturl = h.get("nexturl");
    int id = h.getInt("id");
    ShopHospital sh = ShopHospital.find(id);
    //查询到期的证件
    int apid = h.getInt("apid");
    ApprovalProcess ap = ApprovalProcess.find(apid);

    int yqlb = h.getInt("yqlb",-1);
    if(yqlb==-1&&apid>0){
        yqlb = ap.getYqlb();
    }
    String dateValue = "";
    if(yqlb>-1){
        switch (yqlb){

            case 0:
                dateValue = MT.f(sh.getFsaqxkzrq());
                break;
            case 1:
                dateValue = MT.f(sh.getFsxypsyxkzrq());
                break;
            case 2:
                dateValue = MT.f(sh.getFszlxkzrq());
                break;
            case 3:
                dateValue = MT.f(sh.getZfspbrq());
                break;
        }
    }
    System.out.println(dateValue);

    HashMap<Integer, String> HashMapArr = new HashMap<Integer, String>();
    if (apid == 0) {//apid = 0 是 新增 可选可编辑   apid>0 是查看不可编辑
        Date date = new Date();
        Date fsaqxkzrq = sh.getFsaqxkzrq();
        if (fsaqxkzrq != null) {
            if (fsaqxkzrq.before(date)) {//辐射安全许可证 在 今天之前  过期了
                HashMapArr.put(0, ShopHospital.dqzjArr[0]);
            }
        }
        Date fsxypsyxkzrq = sh.getFsxypsyxkzrq();
        if (fsxypsyxkzrq != null) {
            if (fsxypsyxkzrq.before(date)) {//放射性药品使用许可证 在 今天之前  过期了
                HashMapArr.put(1, ShopHospital.dqzjArr[1]);
            }
        }
        Date fszlxkzrq = sh.getFszlxkzrq();
        if (fszlxkzrq != null) {
            if (fszlxkzrq.before(date)) {//放射诊疗许可证 在 今天之前  过期了
                HashMapArr.put(2, ShopHospital.dqzjArr[2]);
            }
        }
        Date zfspbrq = sh.getZfspbrq();
        if (zfspbrq != null) {
            if (zfspbrq.before(date)) {//转让审批表 在 今天之前  过期了
                HashMapArr.put(3, ShopHospital.dqzjArr[3]);
            }
        }
    }


    Set<Map.Entry<Integer, String>> entries = HashMapArr.entrySet();
    Iterator<Map.Entry<Integer, String>> iterator = entries.iterator();

    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();
%>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/top.js'></script>
</head>
<body onload="changeSelected();">
<h1>预警管理</h1>

<form name="form1" action="/ApprovalProcesss.do" id="form1" method="post"
      enctype="multipart/form-data" target="_ajax">
    <input type="hidden" name="id" value="<%=id%>"/>
    <input type="hidden" name="apid" value="<%=apid%>"/>
    <input type="hidden" name="nexturl" value="/jsp/yl/shopnew/shopHospitalsextensionRequestList.jsp?id=<%=id%>"/>
    <input type="hidden" name="act" value="edityanqi"/>
    <table id="tablecenter">

        <tr>
            <td align="right">医院名称：</td>
            <td><%=MT.f(sh.getName())%>
            </td>
        </tr>
        <tr>
            <td>到期证件:</td>
            <td>
                <select name="yqlb" onchange="changelb()">
                    <%
                        if (apid > 0) {%>
                    <option><%=ShopHospital.dqzjArr[ap.getYqlb()]%>
                    </option>
                    <%
                    } else {
                            if(iterator.hasNext()){%>
                              <option value="-1">请选择</option>
                            <%}
                        while (iterator.hasNext()) {
                            Map.Entry<Integer, String> key = iterator.next();
                    %>
                    <option <%=yqlb==key.getKey()?"selected='selected'":""%> value="<%=key.getKey()%>"><%=key.getValue()%>
                    </option>
                    <%
                            }
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td>申请原因:</td>
            <td><textarea  name="reason" cols='28' rows='5'><%=apid>0?MT.f(ap.getReason()):""%></textarea></td>
        </tr>
        <tr>
            <td>文件:</td>
            <td>
                <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-9">
                        <input name="yanqi" type="file"
                               title="<%= MT.f(ap.getAttchid()) %>">
                        <input name="yanqi.attch" id="clientID" type="hidden"
                               value="<%= MT.f(ap.getAttchid())%>"/>
                        <%
                            if (ap.getAttchid() > 0) {
                        %>
                        <a href="<%=CommonUtils.getFileUrlByAttchId(tempContextUrl, ap.getAttchid())%>"
                           target="_blank" style="color: #007aaf">查看  (不上传文件默认为使用原文件)</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>原有效期:</td>
            <td><%=dateValue%></td>
        </tr>
        <tr>
            <td>有效期调整为:</td>
            <td><input name="yqrq" value="<%=MT.f(ap.getYqrq())%>" onclick="mt.date(this)"
                       class="date"/></td>
        </tr>
    </table>
    <button class="btn btn-primary" type="button" onclick="fnedit()">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>

<script type="text/javascript">
    function fnedit() {
        form1.submit();
    }

    function changelb() {
        var id = form1.id.value;
        var apid = form1.apid.value;
        var nexturl = form1.nexturl.value;
        var yqlb = form1.yqlb.value;
        location.href="/jsp/yl/shopnew/postponeAdd.jsp?yqlb="+yqlb+"&id="+id+"&apid="+apid+"&nexturl="+nexturl;
    }


</script>
</body>
</html>
