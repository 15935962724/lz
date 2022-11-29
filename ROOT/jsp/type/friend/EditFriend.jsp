<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%r.add("/tea/ui/node/type/friend/EditFriend");
           tea.entity.node. Friend friend =  tea.entity.node.Friend.find(teasession._nNode);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditFriend")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <FORM name=foEdit METHOD=POST action="/servlet/EditFriend" onSubmit="return(submitInteger(this.Age, '<%=r.getString(teasession._nLanguage, "InvalidAge")%>')&&submitInteger(this.Height, '<%=r.getString(teasession._nLanguage, "InvalidHeight")%>'));">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Gender")%>:</td>
        <td><SELECT name=Gender>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_GENDER[0])%></OPTION>
            <OPTION <%=getSelect(friend.getGender()==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_GENDER[1])%></OPTION>
          </SELECT>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "PrefGender")%>:</td>
        <td><SELECT name=PrefGender>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_GENDER[0])%></OPTION>
            <OPTION <%=getSelect(friend.getPrefGender()==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_GENDER[1])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Relationship")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name=LongTerm value=null <%=getCheck((friend.getRelationship() & 1 << 0) != 0)%>>
          <%=r.getString(teasession._nLanguage, Friend.FRIEND_RELATIONSHIP[0])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=ShortTerm value=null <%=getCheck((friend.getRelationship() & 1 << 1) != 0)%>>
          <%=r.getString(teasession._nLanguage, Friend.FRIEND_RELATIONSHIP[1])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=ActivityPartner value=null <%=getCheck((friend.getRelationship() & 1 << 2) != 0)%>>
          <%=r.getString(teasession._nLanguage, Friend.FRIEND_RELATIONSHIP[2])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=LongDistance value=null <%=getCheck((friend.getRelationship() & 1 << 3) != 0)%>>
          <%=r.getString(teasession._nLanguage, Friend.FRIEND_RELATIONSHIP[3])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=AlternativeLifestyles value=null <%=getCheck((friend.getRelationship() & 1 << 4) != 0)%>>
          <%=r.getString(teasession._nLanguage, Friend.FRIEND_RELATIONSHIP[4])%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Ethnicity")%>:</td>
        <td><SELECT name=Ethnicity>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_ETHNICITY[0])%></OPTION>
            <OPTION <%=getSelect( friend.getEthnicity()==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_ETHNICITY[1])%></OPTION>
            <OPTION  <%=getSelect( friend.getEthnicity()==2)%>VALUE="2"><%=r.getString(teasession._nLanguage, Friend.FRIEND_ETHNICITY[2])%></OPTION>
            <OPTION <%=getSelect( friend.getEthnicity()==3)%> VALUE="3"><%=r.getString(teasession._nLanguage, Friend.FRIEND_ETHNICITY[3])%></OPTION>
            <OPTION <%=getSelect( friend.getEthnicity()==4)%> VALUE="4"><%=r.getString(teasession._nLanguage, Friend.FRIEND_ETHNICITY[4])%></OPTION>
            <OPTION <%=getSelect( friend.getEthnicity()==5)%> VALUE="5"><%=r.getString(teasession._nLanguage, Friend.FRIEND_ETHNICITY[5])%></OPTION>
            <OPTION <%=getSelect( friend.getEthnicity()==6)%> VALUE="6"><%=r.getString(teasession._nLanguage, Friend.FRIEND_ETHNICITY[6])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Education")%>:</td>
        <td><SELECT name=Education>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_EDUCATION[0])%></OPTION>
            <OPTION <%=getSelect(friend.getEducation()==1)%>VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_EDUCATION[1])%></OPTION>
            <OPTION <%=getSelect(friend.getEducation()==2)%>VALUE="2"><%=r.getString(teasession._nLanguage, Friend.FRIEND_EDUCATION[2])%></OPTION>
            <OPTION <%=getSelect(friend.getEducation()==3)%>VALUE="3"><%=r.getString(teasession._nLanguage, Friend.FRIEND_EDUCATION[3])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Employment")%>:</td>
        <td><SELECT name=Employment>
            <OPTION SELECTED VALUE="0"><%=Friend.FRIEND_EMPLOYMENT[0]%></OPTION>
            <OPTION <%=getSelect(friend.getEmployment()==1)%>VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_EMPLOYMENT[1])%></OPTION>
            <OPTION <%=getSelect(friend.getEmployment()==2)%>VALUE="2"><%=r.getString(teasession._nLanguage, Friend.FRIEND_EMPLOYMENT[2])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Religion")%>:</td>
        <td><SELECT name=Religion>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[0])%></OPTION>
            <OPTION  <%=getSelect(friend.getReligion()==1)%>VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[1])%></OPTION>
            <OPTION  <%=getSelect(friend.getReligion()==2)%>VALUE="2"><%=r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[2])%></OPTION>
            <OPTION <%=getSelect(friend.getReligion()==3)%>VALUE="3"><%=r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[3])%></OPTION>
            <OPTION <%=getSelect(friend.getReligion()==4)%>VALUE="4"><%=r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[4])%></OPTION>
            <OPTION <%=getSelect(friend.getReligion()==5)%>VALUE="5"><%=r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[5])%></OPTION>
            <OPTION <%=getSelect(friend.getReligion()==6)%>VALUE="6"><%=r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[6])%></OPTION>
            <OPTION <%=getSelect(friend.getReligion()==7)%>VALUE="7"><%=r.getString(teasession._nLanguage, Friend.FRIEND_RELIGION[7])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Hobbies")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX"  name=ArtsCrafts value=null <%=getCheck((friend.getHobbies() & 1 << 0) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[0])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=CommunityService value=null <%=getCheck((friend.getHobbies() & 1 << 1) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[1])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Dancing value=null <%=getCheck((friend.getHobbies() & 1 << 2) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[2])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Dining value=null <%=getCheck((friend.getHobbies() & 1 << 3) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[3])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Family value=null <%=getCheck((friend.getHobbies() & 1 << 4) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[4])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Movies value=null <%=getCheck((friend.getHobbies() & 1 << 5) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[5])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Music value=null <%=getCheck((friend.getHobbies() & 1 << 6) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[6])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=OutdoorActivities value=null <%=getCheck((friend.getHobbies() & 1 << 7) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[7])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Photography value=null <%=getCheck((friend.getHobbies() & 1 << 8) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[8])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=ReligionSpiritual value=null <%=getCheck((friend.getHobbies() & 1 << 9) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[9])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Sports value=null <%=getCheck((friend.getHobbies() & 1 << 10) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[10])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Theater value=null <%=getCheck((friend.getHobbies() & 1 << 11) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[11])%>
          <input  id="CHECKBOX" type="CHECKBOX" name=Travel value=null <%=getCheck((friend.getHobbies() & 1 << 12) != 0)%>><%=r.getString(teasession._nLanguage, Friend.FRIEND_HOBBIES[12])%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "BodyType")%>:</td>
        <td><SELECT name=BodyType>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_BODYTYPE[0])%></OPTION>
            <OPTION<%=getSelect(friend.getBodyType()==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_BODYTYPE[1])%></OPTION>
            <OPTION <%=getSelect(friend.getBodyType()==2)%> VALUE="2"><%=r.getString(teasession._nLanguage, Friend.FRIEND_BODYTYPE[2])%></OPTION>
            <OPTION <%=getSelect(friend.getBodyType()==3)%> VALUE="3"><%=r.getString(teasession._nLanguage, Friend.FRIEND_BODYTYPE[3])%></OPTION>
            <OPTION <%=getSelect(friend.getBodyType()==4)%> VALUE="4"><%=r.getString(teasession._nLanguage, Friend.FRIEND_BODYTYPE[4])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Age")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Age VALUE="<%=friend.getAge()%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Height")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Height VALUE="<%=friend.getHeight()%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Smoke")%>:</td>
        <td><SELECT name=Smoke>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_SMOKE[0])%></OPTION>
            <OPTION <%=getSelect(friend.getSmoke()==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_SMOKE[1])%></OPTION>
            <OPTION  <%=getSelect(friend.getSmoke()==2)%> VALUE="2"><%=r.getString(teasession._nLanguage, Friend.FRIEND_SMOKE[2])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Drink")%>:</td>
        <td><SELECT name=Drink>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_DRINK[0])%></OPTION>
            <OPTION  <%=getSelect(friend.getDrink()==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_DRINK[1])%></OPTION>
            <OPTION  <%=getSelect(friend.getDrink()==2)%> VALUE="2"><%=r.getString(teasession._nLanguage, Friend.FRIEND_DRINK[2])%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Children")%>:</td>
        <td><SELECT name=Children>
            <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Friend.FRIEND_CHILDREN[0])%></OPTION>
            <OPTION  <%=getSelect(friend.getChildren()==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, Friend.FRIEND_CHILDREN[1])%></OPTION>
            <OPTION  <%=getSelect(friend.getChildren()==2)%> VALUE="2"><%=r.getString(teasession._nLanguage, Friend.FRIEND_CHILDREN[2])%></OPTION>
          </SELECT></td>
      </tr>
    </table>
    <P ALIGN=CENTER>
      <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
    </P>
  </FORM>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

