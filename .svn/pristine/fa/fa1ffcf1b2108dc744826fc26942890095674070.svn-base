package tea.ui.member.profile;

import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaServlet;
import java.sql.*;
import org.dom4j.*;
import tea.entity.member.SynRegMethod;
import tea.entity.member.Profile;


public class SynchronousReg extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

        request.setCharacterEncoding("utf-8");

        String updateType = null; //XML中用户注册的状态
        Element user = null; //XML中根元素2 表示用户
        String userInfo = null; //查询用户返回的结果
        String userId = null; //用户ID
        String userName = null; //用户名
        String password = null; //密码
        String email = null; //EMAIL
        String mobile = null; //手机号
        String cardType; //证件类型
        String cardNumber = null; //证件号码
        String sex = null; //性别

        String xml = request.getParameter("request");
        System.out.println("发送过来的XML请求内容：" + xml);

        String generateXML = null;

        PrintWriter out = response.getWriter();

        try
        {
            Document document = DocumentHelper.parseText(xml);
            Element root = document.getRootElement();

            SynRegMethod srm = new SynRegMethod();
            Profile p = new Profile();

            //取得XML中的用户状态值
            updateType = root.element("UpdateType").getStringValue();
            user = root.element("CheckContent");

            //取得XML中用户各项注册信息
            userId = user.element("UserId").getText();
            userName = user.element("UserName").getText();
            password = user.element("Password").getText();
            email = user.element("Email").getText();
            mobile = user.element("Mobile").getText();
            cardType = user.element("CardType").getText();
            int intCardType = Integer.parseInt(cardType);
            cardNumber = user.element("CardNumber").getText();
            sex = user.element("Sex").getText();
            int intSex = Integer.parseInt(sex);

            System.out.println("updateType:" + updateType);
            if ("0".equals(updateType))
            { //注册用户
                userInfo = srm.findUserId(userId);
                System.out.println("数据库中是否有此用户：" + userInfo);
                if ("无".equals(userInfo)) //无人注册此ID 可以注册
                {
                    //用户注册资料不全
                    if (userId == "" || userName == "" || password == "" || email == "" || mobile == "" || cardNumber == "")
                    {
                        //创建XML <Result>2</Result>
                        generateXML = srm.writeXML("0", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "2");
                        //发送请求 把generateXML传到别的系统中

                        out.print(generateXML);
                    } else
                    {
                        int regResult = srm.registerUser(userId, userName, password, email, mobile, intCardType, cardNumber, intSex);
                        System.out.println("regResult:" + regResult);
                        if (regResult == 1)
                        {

                            //注册成功 创建XML <Result>0</Result>
                            generateXML = srm.writeXML("0", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "0");

                            System.out.println("响应的XML内容：" + generateXML);
                            out.print(generateXML);

                        } else
                        {
                            //注册失败 创建XML <Result>3</Result>
                            generateXML = srm.writeXML("0", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "3");

                            out.print(generateXML);

                        }
                    }
                } else
                {
                    //此ID已被注册 <Result>1</Result>
                    generateXML = srm.writeXML("0", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "1");

                    out.print(generateXML);

                }
            } else if ("1".equals(updateType))
            { //更新用户
                int updateResult = p.updateUserInfo1(userId, password, intSex, cardNumber, intCardType, userName, mobile, email);
                System.out.println("更新返回值：" + updateResult);
                if (updateResult == 1 || updateResult == 2)
                {
                    //更新成功 创建XML <Result>0</Result>
                    generateXML = srm.writeXML("1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "0");
                    System.out.println("更新成功");
                    out.print(generateXML);

                } else
                {
                    //更新失败 创建XML <Result>4</Result>
                    generateXML = srm.writeXML("1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "4");
                    System.out.println("更新失败");
                    out.print(generateXML);

                }
            } else
            { //删除用户
                int deleteResult = srm.deleteUser(userId);
                // 创建XML <Result>0</Result>
                if (deleteResult == 1)
                {
                    generateXML = srm.writeXML("2", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "0");
                    System.out.println("删除成功");
                    out.print(generateXML);
                } else
                {
                    generateXML = srm.writeXML("2", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1", "4");
                    System.out.println("删除失败");
                    out.print(generateXML);

                }
            }

        } catch (SQLException ex)
        {
            ex.getStackTrace();
        } catch (DocumentException ex)
        {
            ex.getStackTrace();
        }
    }
}

