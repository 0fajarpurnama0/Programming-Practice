<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="model" scope="request" class="model.Model" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Style-Type" content="text/css"> <%-- Set Content-Style-Type as text/css. --%>
<meta name="viewport" content="width=device-width, initial-scale=1"> <%-- Set the view scale of mobile device. --%>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" /> <%-- Get a stylesheet from code.jquery.com. --%>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script> <%-- Get a jquery min.js script. --%>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script> <%-- Get a mobile jquery min.js script. --%>
<title>view sample (for mobile)</title>
</head>
<body>
<div data-role="page"> <%-- the page displayed in the browser --%>
<div data-role="header"> <%-- creates a toolbar at the top of the page (often used for title or search buttons) --%>
<h1>Sample program for MVC model (for Mobile)</h1>
</div><!-- /header -->
<div role="main" class="ui-content"> <%-- defines the content of the page, like text, images, buttons, forms, etc, class adds extra padding and margin inside the page content --%>
<div align="right">version 2015-04-23 by 
<a href="mailto:nakano@cc.kumamoto-u.ac.jp?subject=MVC20150425">nakano@cc.kumamoto-u.ac.jp</a></div>
This content is ready for mobile device by <a target="_blank" href="http://jquerymobile.com/">jQuery Mobile</a>.

  <form action="Controller" method="post">
    Your name:<input type="text" name="sender" size="20" /><br>
    Comment:<textarea name="content" rows="2" cols="40"></textarea><input type=submit value="send" />
  </form>

  <hr />logs:<br />
  <jsp:getProperty name="model" property="history" />
</div><!-- /content -->

<div data-role="footer"> <%-- creates a toolbar at the bottom of the page --%>
<h4>Copyright <a target="_blank" href="mailto:nakano@cc.kumamoto-u.ac.jp">Hiroshi Nakano</a> 2015-04-23, All Rights Reserved</h4>
</div><!-- /footer -->
</div><!-- /page -->
</body>
</html>
