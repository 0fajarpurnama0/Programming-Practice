<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="model" scope="request" class="model.Model" /> <%-- Initiate a bean class with identity "model", with the scope "request" to allow use of this bean from any jsp page, use a src class model --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> <%-- Doctype from www.w3.org --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> <%-- A meta data to set content type > text or html, using character UTF-8 --%>
<title>view sample</title> <%-- Title of this page --%>
</head>
<body>
<h1>Sample program for MVC model</h1> <%-- First heading --%>
<div align="right">version 2015-04-23 by <%-- A section with align right --%>
<a href="mailto:nakano@cc.kumamoto-u.ac.jp?subject=MVC20150425">nakano@cc.kumamoto-u.ac.jp</a></div> <%-- Link to email --%>

  <form action="Controller" method="post"> <%-- Send the form to Controller using method post --%>
    Your name:<input type="text" name="sender" size="20" /><br> <%-- Input a text to sender variable --%>
    Comment:<textarea name="content" rows="2" cols="40"></textarea><input type=submit value="send" /> <%-- Input comment using textarea, then submit by pressing the send button --%>
  </form>

  <hr />logs:<br /> <%-- A text --%>
  <jsp:getProperty name="model" property="history" /> <%-- Retrieve the value history from model --%>

</body>
</html>
