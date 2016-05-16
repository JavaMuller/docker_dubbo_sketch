<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<body>
<h2>SAY HELLO</h2>
<p>
<ul>
<li><a href="index?ln=en">say en</a></li>
<li><a href="index?ln=zh">say zh</a></li>
<li><a href="index?ln=fr">say fr</a></li>
<li><a href="index?ln=ja">say ja</a></li>
<li><a href="index?ln=ko">say ko</a></li>
</ul> 
</p>
<p>
${message}
</p>
</body>
</html>
