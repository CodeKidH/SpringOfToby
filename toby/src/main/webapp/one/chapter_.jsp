<%@include file="include.jsp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src='../cornerstone/lib/jquery-1.8.1.min.js'></script>
<script type="text/javascript">

var i = 0;

function makeGreen(a) {
	
	//var i = Math.floor(Math.random() * 2) + 1;
	
	var node = document.createElement("pre");
    var text = document.getElementById(a);
    var textNode = document.createTextNode('===========================================================');
    
    node.setAttribute("style","font-size: 10pt")
    	//text.removeAttribute("style");
    text.setAttribute("style","display: inline")
    
    var iframe = document.getElementById('ifrm');
    
    if(i%2 == 0){
    	var iframe = document.getElementById('ifrm');
    	
    }else{
    	var iframe = document.getElementById('ifrm1');
    }
    i++;
    var doc = iframe.contentWindow.document;
    
    node.appendChild(text);
    node.appendChild(textNode);
    doc.body.appendChild(node);
    
  }
function makeClean1() {
	
	//var i = Math.floor(Math.random() * 2) + 1;
    
   	var iframe = document.getElementById('ifrm');
    var doc = iframe.contentWindow.document;
    
    while ( doc.body.hasChildNodes() )
    {
    	doc.body.removeChild( doc.body.firstChild );       
    }   
  }
  
function makeClean2() {
	
	//var i = Math.floor(Math.random() * 2) + 1;
    
   	var iframe = document.getElementById('ifrm1');
    var doc = iframe.contentWindow.document;
    
    while ( doc.body.hasChildNodes() )
    {
    	doc.body.removeChild( doc.body.firstChild );       
    }   
  }
  
</script>
</head>
<body>

<h1 style="color:">Chapter1 - Object and DI</h1>

<table border="1" width="100%">
	<colgroup>
		<col width="600"/>
		<col width="600"/>
	</colgroup>
	<tr>
		<td valign="top" width="30%">
			<h2 style="color:#1E90FF">1. STUDPID DAO</h2>
				<input type="button" onclick="makeGreen('a1')" value="User">
				<input type="button" onclick="makeGreen('a2')" value="UserDao">
			<H2 style="color:#1E90FF">2. Let's separate concerns</H2>
			<H3 style="color:">#changed - UserDao</H3>
				<input type="button" onclick="makeGreen('b1')" value="User">
				<input type="button" onclick="makeGreen('b2')" value="UserDao">
			<H2 style="color:#1E90FF">3. extends DAO by using extends</H2>
			<H3 style="color:">#Factory Pattern, Template Method Pattern, IOC</H3>
			<H3 style="color:">#changed - UserDao, NUserDao, DUserDao</H3>
				<input type="button" onclick="makeGreen('c1')" value="UserDao">
				<input type="button" onclick="makeGreen('c2')" value="NUserDao">
				<input type="button" onclick="makeGreen('c3')" value="DUserDao">
				<input type="button" onclick="makeGreen('c4')" value="User">
			<H2 style="color:#1E90FF">4. extends DAO by using Class</H2>
			<H3 style="color:">#changed - web.xml</H3>
			<H3 style="color:">#ContextLoaderListener</H3>
				<input type="button" onclick="makeGreen('d1')" value="web.xml">
			<H3 style="color:">#contextClass</H3>
				<input type="button" onclick="makeGreen('d2')" value="web.xml">
				
		</td>
		<td valign="top" bgcolor="#ddfF4ff" >
		<input type="button" onclick="makeClean1()" value="Clean">
		   <iframe name="ifrm" id="ifrm" width="650" height="800" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes">
		   </iframe>
		</td>
		<td valign="top" bgcolor="#ddfF4ff" >
		<input type="button" onclick="makeClean2()" value="Clean">
		   <iframe name="ifrm1" id="ifrm1" width="650" height="800" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes"></iframe>
		</td>
	</tr>
</table>


<div id="a1" style="display: none;color:#A7B32A">

public class User {
	
	String id;
	
	String name;
	String password;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}

</div>
<div id="a2" style="display: none">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("com.mysql.jdbc.Driver"); -mysql
		Class.forName("oracle.jdbc.driver.OracleDriver");------------------------> first concerns
		//Connection c = DriverManager.getConnection("jdbc:mysql://localhost/spring","spring","book");
		
		Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into users(id,name,password) values(?,?,?)"); --------->second concerns
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close(); ---------------------------> third concerns
		c.close();
	}
	
	public User get(String id)throws ClassNotFoundException, SQLException{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps = c.prepareStatement("select * from users where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword("password");
		
		rs.close();
		ps.close();
		c.close();
		
		return user;
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException{
		UserDao dao = new UserDao();
		
		User user = new User();
		user.setId("white");
		user.setName("jh");
		user.setPassword("1111");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}
</div>

<div id="b1" style="display: none">

public class User {
	
	String id;
	
	String name;
	String password;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}

</div>
<div id="b2" style="display: none">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = getConnection();
		
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public User get(String id)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword("password");
		
		rs.close();
		ps.close();
		c.close();
		
		return user;
	}
	========================================================================================
	private Connection getConnection() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
	=========================================Refactory=======================================
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException{
		UserDao dao = new UserDao();
		
		User user = new User();
		user.setId("wh");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}

</div>



<div id="c1" style="display: none">

====================================
we use a template method pattern or factory pattern
===================================

package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public abstract class UserDao { ---------------------------->>abstract
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = getConnection();
		
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public User get(String id)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword("password");
		
		rs.close();
		ps.close();
		c.close();
		
		return user;
	}
=====================================================================================	
	public abstract Connection getConnection() throws ClassNotFoundException, SQLException;
======================================================================================
	
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException{
		UserDao dao = new DUserDao(); ----------->>>
		
		User user = new User();
		user.setId("asd");
		user.setName("JH");
		user.setPassword("JH");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		System.out.println(user2.getName());
	}
}

</div>
<div id="c2" style="display: none">
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class NUserDao extends UserDao{
	public Connection getConnection()throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}
</div>

<div id="c3" style="display: none" >
package toby;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DUserDao extends UserDao{
	public Connection getConnection()throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/toby","root","1111");
		return c;
	}
}
</div>
<div id="c4" style="display: none">

public class User {
	
	String id;
	
	String name;
	String password;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}

</div>


<div id="d1" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(web-app xmlns="http://java.sun.com/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
	version="2.5")

  (display-name)Archetype Created Web Application(/display-name)
  
  (listener)
  	(listener-class)org.springframework.web.context.ContextLoaderListener
  	(/listener-class)
  (/listener)
  (!--웹 어플리케이션이 시작될때 루트 애플리케이션 컨텍스트를 만들어 초기화, 웹 애플리케이션이 종료될 때 컨텍스트를 함께 종료하는 리스너  --)
  (!--디폴트 값 루트 어플리케이션위치 WEB-INF/applicationContext.xml--)
  (!--ContextLoaderListener가 자동생성하는 컨텍스트의 클래스는 XmlWebApplicationContext이다--)
  
  (context-param)  
	(param-name)contextConfigLocation(/param-name)  
	(param-value)  (!--ContextLoaderListener가 이용할 파라미터를 (context-param)항목에 넣음--)
		/WEB-INF/daoContext.xml
		/WEB-INF/applicationContext.xml
		(!-- classpath:applicationContext.xml--) //이런 스타일도 가능
		(!-- /WEB-INF/*Context.xml--) //이런 스타일도 가능
	(/param-value) 
	 
  (/context-param)  

(/web-app)

</div>

<div id="d2" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(web-app xmlns="http://java.sun.com/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
	version="2.5")

  (display-name)Archetype Created Web Application(/display-name)
  
  (listener)
  	(listener-class)org.springframework.web.context.ContextLoaderListener
  	(/listener-class)
  (/listener)
  (!--웹 어플리케이션이 시작될때 루트 애플리케이션 컨텍스트를 만들어 초기화, 웹 애플리케이션이 종료될 때 컨텍스트를 함께 종료하는 리스너  --)
  (!--디폴트 값 루트 어플리케이션위치 WEB-INF/applicationContext.xml--)
  (!--ContextLoaderListener가 자동생성하는 컨텍스트의 클래스는 XmlWebApplicationContext이다--)
  
  
  -------------------------------------------------------------------------------
  
  (context-param)  
	(param-name)contextClass(/param-name)  
	(param-value) (!--다른 애플리케이션컨텍스트 구현 클래스로 변경하고 싶으면 contextClass파라미터를 이용--)
		org.springframework.web.context.support.AnnotationConfigWebApplicationContext
	(/param-value) 
	 
  (/context-param)  
 -------------------------------------------------------------------------------

(/web-app)

</div>
</body>
</html>