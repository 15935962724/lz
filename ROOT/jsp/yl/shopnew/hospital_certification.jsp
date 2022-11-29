<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="tea.entity.*" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="util.CommonUtils" %>
<%@ page import="tea.entity.member.ModifyRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="tea.entity.member.Profile" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int hid = h.getInt("id");
    ShopHospital sh = ShopHospital.find(hid);

    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();

%>
<html>
<head>
    <title>资质申请</title>

    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/top.js'></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <%--<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">--%>
    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <link rel="stylesheet" href="/tea/new/css/bootstrap.css">
    <link rel="stylesheet" href="/tea/new/css/animate.css">
    <link rel="stylesheet" href="/tea/new/css/style1.css">
    <link rel="stylesheet" href="/tea/new/css/common.css">
    <script src="/tea/new/js/bootstrap.min.js"></script>
    <style>
        .yxq {
            margin-top: 20px;
        }
        #tablecenter {
            font-size: 9pt;
            border: 1px solid #d7d7d7;
            clear: both;
            width: 95.5%;
            margin: 0 auto;
            margin-top: 10px;
            border-collapse: collapse;
            margin-bottom: 6px;
            background: none;
        }
        #tableonetr td {
            font-weight: bold;
            /* background: #E1E5EE; */
            white-space: nowrap;
            text-align: center;
        }
        #tablecenter td {
            font-size: 12px;
            border: 1px solid #d7d7d7;
            /* min-height: 30px; */
            padding: 5px 10px 5px 10px;
            /* line-height: 150%; */
            text-align: left;
            line-height: 23px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1 class="head-tit animate-box" data-animate-effect="fadeInLeft" style="background-color: #0099db">
                申请医院资质</h1>
            <div class="rate-fot animate-box">
                <p>1. 请严格按照相关证件信息进行正确填写</p>
                <p>2. 请上传最新版的证件原件的彩色扫描或彩色照片，复印件需加盖公司红章</p>
                <p>3. 请确保上传文件信息清晰可辨</p>
            </div>
            <h2 class="head-hd animate-box" data-animate-effect="fadeInLeft">资质信息</h2>
            <form class="form-horizontal" name="form2" action="/ShopHospitals.do" id="form2" method="post"
                  enctype="multipart/form-data" target="_ajax">
                <input type="hidden" name="nexturl">
                <input type="hidden" name="hid" value="<%=hid%>">
                <input type="hidden" name="act" value="updateHospitalZz">
                <div class="natural upVip animate-box" data-animate-effect="fadeInLeft">

                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>辐射安全许可证</label>
                        <div class="col-sm-9">
                            <input name="fsaqxkz" type="file" alt="辐射安全许可证不能为空!"
                                   title="<%= MT.f(sh.getFsaqxkz()) %>">
                            <input name="fsaqxkz.attch" id="clientID" type="hidden"
                                   value="<%= MT.f(sh.getFsaqxkz()) %>"/>
                            <%
                                if (sh.getFsaqxkz() > 0) {
                            %>
                            <a href="<%=CommonUtils.getFileUrlByAttchId(tempContextUrl, sh.getFsaqxkz())%>"
                               target="_blank">查看</a>
                            <%
                                }
                            %>
                            <div class="yxq">
                                有效期：<input name="fsaqxkzrq" value="<%=MT.f(sh.getFsaqxkzrq())%>" onclick="mt.date(this)"
                                           class="date"/>
                            </div>

                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>放射性药品使用许可证</label>
                        <div class="col-sm-9">
                            <input name="fsxypsyxkz" type="file" alt="放射性药品使用许可证不能为空!"
                                   title="<%= MT.f(sh.getFsxypsyxkz()) %>">
                            <input name="fsxypsyxkz.attch" id="clientID" type="hidden"
                                   value="<%= MT.f(sh.getFsxypsyxkz()) %>"/>
                            <%
                                if (sh.getFsxypsyxkz() > 0) {
                            %>
                            <a href="<%=CommonUtils.getFileUrlByAttchId(tempContextUrl, sh.getFsxypsyxkz())%>"
                               target="_blank">查看</a>
                            <%
                                }
                            %>
                            <div class="yxq">
                                有效期：<input name="fsxypsyxkzrq" value="<%=MT.f(sh.getFsxypsyxkzrq())%>"
                                           onclick="mt.date(this)" class="date"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>放射诊疗许可证</label>
                        <div class="col-sm-9">
                            <input name="fszlxkz" type="file" alt="放射诊疗许可证不能为空!"
                                   title="<%= MT.f(sh.getFszlxkz()) %>">
                            <input name="fszlxkz.attch" id="clientID" type="hidden"
                                   value="<%= MT.f(sh.getFszlxkz()) %>"/>
                            <%
                                if (sh.getFszlxkz() > 0) {
                            %>
                            <a href="<%=CommonUtils.getFileUrlByAttchId(tempContextUrl, sh.getFszlxkz())%>"
                               target="_blank">查看</a>
                            <%
                                }
                            %>
                            <div class="yxq">
                                有效期：<input name="fszlxkzrq" value="<%=MT.f(sh.getFszlxkzrq())%>" onclick="mt.date(this)"
                                           class="date"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>转让审批表</label>
                        <div class="col-sm-9">
                            <input name="zfspb" type="file" alt="转让审批表不能为空!"
                                   title="<%= MT.f(sh.getZfspb()) %>">
                            <input name="zfspb.attch" id="clientID" type="hidden"
                                   value="<%= MT.f(sh.getZfspb()) %>"/>
                            <%
                                if (sh.getZfspb() > 0) {
                            %>
                            <a href="<%=CommonUtils.getFileUrlByAttchId(tempContextUrl, sh.getZfspb())%>"
                               target="_blank">查看</a>
                            <%
                                }
                            %>
                            <div class="yxq">
                                有效期：<input name="zfspbrq" value="<%=MT.f(sh.getZfspbrq())%>" onclick="mt.date(this)"
                                           class="date"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>Bq数量</label>
                        <div class="col-sm-9">
                            <input type="text" name="bq1"  value="<%=MT.f(sh.getBq1())%>" onkeyup="inputChange(this)">
                            <%--<input type="number" name="bq2" value="<%=MT.f(sh.getBq2())%>">--%>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>证件到期预警电话（医院）</label>
                        <div class="col-sm-9">
                            <input type="text" name="yjdhyy" value="<%=MT.f(sh.getYjdhyy())%>">
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>证件到期预警电话（粒子平台）</label>
                        <div class="col-sm-9">
                            <input type="text" name="yjdhlz" value="<%=MT.f(sh.getYjdhlz())%>">
                        </div>
                    </div>
                    <div class="center text-c animate-box" data-animate-effect="fadeInLeft" style="padding-top:40px;">
                        <a href="javascript:;" style="background-color: #169bd5" class="btn btn-primary btn-blue"
                           onclick="addHospitalZz()">提交</a>&nbsp;&nbsp;&nbsp;
                        <a href="javascript:;" onclick="history.go(-1)" class="btn btn-default">返回</a>
                    </div>
                </div>
                <div>
                    <%
                        List<ModifyRecord> modifyRecords = ModifyRecord.find(" AND order_id=" + Database.cite(sh.getId() + "") + " order by modifyTime ", 0, 10);
                        if (modifyRecords.size() > 0) {
                    %>
                    <table id="tablecenter" cellspacing="0">
                        <tr style="font-weight:bold;">
                            <td colspan="4" align='left'>审批日志</td>
                        </tr>
                        <tr id="tableonetr">
                            <td>操作人</td>
                            <td>时间</td>
                            <td>操作类型</td>
                            <td>操作内容</td>
                        </tr>
                        <%
                            for (ModifyRecord m : modifyRecords) {
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
                                String format = sdf.format(m.getModifyTime());
                        %>
                        <tr>
                            <td><%=MT.f(Profile.find(m.getMember()).getMember())%>
                            </td>
                            <td><%=MT.f(format)%>
                            </td>
                            <td><%=MT.f(m.getContent())%>
                            </td>
                            <td><%=  MT.f(m.getContentDetail())%>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </table>
                </div>
            </form>
        </div>
    </div>
</div>


<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down"/>
    <input name="attch" type="hidden"/>
</form>
</body>
</html>
<script>

    form2.nexturl.value = location.pathname + location.search;


    mt.receive = function (h, n) {
        $("#hospital").val(h);
        $("#hospitals").val(n);
    }


    function downatt(num) {
        form9.attch.value = num;
        form9.submit();
    }

    function addHospitalZz() {
        form2.submit();
    }

    function toThousands(num){
        var result = '';
        var numArr = num.toString().split('.');
        var int = numArr[0];
        var decmial = numArr[1] ? '.' + numArr[1] : '';
        for (var n = int.length - 1; n >= 0; n--) {
            result += int[int.length - n - 1];
            if ((int.length - n - 1) % 3 === 0 && n !== 0) {
                result += ',';
            }
        }
        return result + decmial;
    };

    function inputChange(obj) {
        var num = $(obj).val().replaceAll(",","");
        $(obj).val(toThousands(num));
    }

    mt.fit();
</script>
