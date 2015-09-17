<%@include file="include.jsp"%>
<html>
<body style="background:#041303">
<h1 style="color:#FCF9F9">Chapter3 - Template</h1>


<h2 style="color:#FCF9F9">1.add a Exception in delete()</h2>
<h3 style="color:#FCF9F9"><Changed : UserDao ></h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = dataSource.getConnection();
		
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
========================================================================	
	public void deleteAll() throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("delete from dao");
			ps.executeUpdate();
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
	}
========================================================================	
	public int getCount() throws SQLException{
		Connection c = dataSource.getConnection();
		
		PreparedStatement ps = c.prepareStatement("select count(*) from dao");
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		rs.close();
		ps.close();
		c.close();
		
		return count;
	}
	
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	
	@Autowired
	private ApplicationContext context;
	
	private UserDao dao;
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>


<h2 style="color:#FCF9F9">2.add a Exception in getCount()</h2>
<h3 style="color:#FCF9F9">* UserDao *</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = dataSource.getConnection();
		
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("delete from dao");
			ps.executeUpdate();
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
	}
======================================================================	
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
======================================================================	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	
	@Autowired
	private ApplicationContext context;
	
	private UserDao dao;
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">3.Strategy Pattern - Make a strategy</h2>
<h3 style="color:#FCF9F9">* Strategy is part changed, Context is not change part * </h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = dataSource.getConnection();
		
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
==============================================================================		
		try{
			c = dataSource.getConnection();
			StatementStrategy strategy = new DeleteAllStatement();
			ps = strategy.makePreparedStatement(c);
			
			ps.executeUpdate();
==============================================================================			
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
	}
	
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	
	@Autowired
	private ApplicationContext context;
	
	private UserDao dao;
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
	
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DeleteAllStatement]':'[DeleteAllStatement]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DeleteAllStatement</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteAllStatement implements StatementStrategy{
	
	public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
		PreparedStatement ps = c.prepareStatement("delete from dao");
		return ps;
	}
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">4.Strategy Pattern - Improve a count()</h2>
<h3 style="color:#FCF9F9">#Separate context and strategy in UserDao</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver"); -oracle
		Connection c = dataSource.getConnection();
		
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		PreparedStatement ps =c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
=================================================================================================
This is a strategy
=================================================================================================	
	public void deleteAll() throws SQLException{
		StatementStrategy st = new DeleteAllStatement();
		jdbcContextWithStatementStrategy(st);
		
	}
=================================================================================================	
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
=================================================================================================	
This is Context

=================================================================================================
	public void jdbcContextWithStatementStrategy(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c !=null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
	}
=================================================================================================	
	
}
</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	
	@Autowired
	private ApplicationContext context;
	
	private UserDao dao;
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DeleteAllStatement]':'[DeleteAllStatement]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DeleteAllStatement</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteAllStatement implements StatementStrategy{
	
	public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
		PreparedStatement ps = c.prepareStatement("delete from dao");
		return ps;
	}
}

</font>
</pre>
</div>


<h2 style="color:#FCF9F9">5.Strategy Pattern - Improve a add()</h2>
<h3 style="color:#FCF9F9">#Improve UserDao</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
==================================================================================	
	public void add(User user)throws ClassNotFoundException, SQLException{
		StatementStrategy st = new AddStatement(user);
		jdbcContextWithStatementStrategy(st);
	}
==================================================================================
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() throws SQLException{
		StatementStrategy st = new DeleteAllStatement();
		jdbcContextWithStatementStrategy(st);
		
	}
	
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	public void jdbcContextWithStatementStrategy(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c !=null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	
	@Autowired
	private ApplicationContext context;
	
	private UserDao dao;
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DeleteAllStatement]':'[DeleteAllStatement]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DeleteAllStatement</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteAllStatement implements StatementStrategy{
	
	public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
		PreparedStatement ps = c.prepareStatement("delete from dao");
		return ps;
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[AddStatement]':'[AddStatement]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>AddStatement</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddStatement implements StatementStrategy{
	
	User user;
	
	public AddStatement(User user){
		this.user = user;
	}
	
	public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
		
		PreparedStatement ps = c.prepareStatement("insert into dao(id,name,password)values(?,?,?)");
		
		ps.setString(1,user.getId());
		ps.setString(2,user.getName());
		ps.setString(3,user.getPassword());
		
		return ps;
	}
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">6.Strategy Pattern - Improve a add() : use a Inner Class</h2>
<h3 style="color:#FCF9F9">#Improve UserDao</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void add(User user)throws ClassNotFoundException, SQLException{
		============================================================================================
		class AddStatement implements StatementStrategy{
			User user;
			
			public AddStatement(User user){
				this.user = user;
			}
			
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps = c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
				ps.setString(1, user.getId());
				ps.setString(2, user.getName());
				ps.setString(3, user.getPassword());
				
				return ps;
			}
		}
		
		============================================================================================
		StatementStrategy st = new AddStatement(user);
		jdbcContextWithStatementStrategy(st);
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() throws SQLException{
		StatementStrategy st = new DeleteAllStatement();
		jdbcContextWithStatementStrategy(st);
		
	}
	
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	public void jdbcContextWithStatementStrategy(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c !=null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
	}
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	
	@Autowired
	private ApplicationContext context;
	
	private UserDao dao;
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[DeleteAllStatement]':'[DeleteAllStatement]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>DeleteAllStatement</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteAllStatement implements StatementStrategy{
	
	public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
		PreparedStatement ps = c.prepareStatement("delete from dao");
		return ps;
	}
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">7.Strategy Pattern - Improve a add() and delete() : use a anonymous inner class</h2>
<h3 style="color:#FCF9F9">#Improve UserDao - new interfaceName(){content of class}; </h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
		
	===========================================================================================
		StatementStrategy st =  new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps  = c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
				ps.setString(1, user.getId());
				ps.setString(2, user.getName());
				ps.setString(3, user.getPassword());
				
				return ps;
			}
		 };
		 
		 jdbcContextWithStatementStrategy(st);
	===========================================================================================	 
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() throws SQLException{
	===========================================================================================	
		StatementStrategy st = new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps = c.prepareStatement("delete from dao");
				return ps;
				}
			};
			
			jdbcContextWithStatementStrategy(st);
		
	}
	===========================================================================================
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	public void jdbcContextWithStatementStrategy(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c !=null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
	}
	
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	
	@Autowired
	private ApplicationContext context;
	
	private UserDao dao;
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>
<h3 style="color:#FCF9F9">#Improve UserDao - Upgrade UserDao </h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
	===============================================================================	
		jdbcContextWithStatementStrategy(
		  new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps  = c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
				ps.setString(1, user.getId());
				ps.setString(2, user.getName());
				ps.setString(3, user.getPassword());
				
				return ps;
			}
		 }
		 );
	}
	===============================================================================
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	===============================================================================
	public void deleteAll() throws SQLException{
		jdbcContextWithStatementStrategy(
		 new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps = c.prepareStatement("delete from dao");
				return ps;
				}
			}
			
		);
	}
	===============================================================================
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	public void jdbcContextWithStatementStrategy(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c !=null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
	}
	
	
}


</font>
</pre>
</div>


<h2 style="color:#FCF9F9">8.Strategy Pattern - Separate a context and make a JdbcContext AND Spring DI</h2>
<h3 style="color:#FCF9F9">#change a depedency - changed : userDao, applicationContext.xml, JdbcContext</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	private JdbcContext jdbcContext;
	
	public void setJdbcContext(JdbcContext jdbcContext){
		this.jdbcContext = jdbcContext;
	}
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
	======================================================================================	
		this.jdbcContext.workWithStrategyStatement(
		new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps  = c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
				ps.setString(1, user.getId());
				ps.setString(2, user.getName());
				ps.setString(3, user.getPassword());
				
				return ps;
			}
		 }
		 );
	}
	======================================================================================
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() throws SQLException{
	======================================================================================
		this.jdbcContext.workWithStrategyStatement(
		 new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps = c.prepareStatement("delete from dao");
				return ps;
				}
			}
			
		);
	}
	======================================================================================
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
	}
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
		<property name="jdbcContext" ref="jdbcContext"/>
	</bean>
	
	<bean id="jdbcContext" class="toby.JdbcContext">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
	
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[JdbcContext]':'[JdbcContext]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>JdbcContext</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

public class JdbcContext {
	
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	public void workWithStrategyStatement(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = this.dataSource.getConnection();
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
			
		}catch(SQLException e){
			throw e;
		}finally{
			if( ps!= null){
				try{
					ps.close();
				}catch(SQLException e){
					throw e;
				}
			}
			if(c!=null){
				try{
					c.close();
				}catch(SQLException e){
					throw e;
				}
			}
		}
	}
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">9.Strategy Pattern - Separate a context and make a JdbcContext AND Operated-hand DI</h2>
<h3 style="color:#FCF9F9">#change a depedency - changed : userDao, applicationContext.xml</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	private JdbcContext jdbcContext;
	
	
	@Autowired
	DataSource dataSource;
	===================================================================
	public void setDataSource(DataSource dataSource){
		this.jdbcContext = new JdbcContext();
		
		this.jdbcContext.setDataSource(dataSource);
		
		this.dataSource = dataSource;
	}
	===================================================================
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
		
		this.jdbcContext.workWithStrategyStatement(
		new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps  = c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
				ps.setString(1, user.getId());
				ps.setString(2, user.getName());
				ps.setString(3, user.getPassword());
				
				return ps;
			}
		 }
		 );
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() throws SQLException{
		this.jdbcContext.workWithStrategyStatement(
		 new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps = c.prepareStatement("delete from dao");
				return ps;
				}
			}
			
		);
	}
	
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
	
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[JdbcContext]':'[JdbcContext]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>JdbcContext</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

public class JdbcContext {
	
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	public void workWithStrategyStatement(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = this.dataSource.getConnection();
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
			
		}catch(SQLException e){
			throw e;
		}finally{
			if( ps!= null){
				try{
					ps.close();
				}catch(SQLException e){
					throw e;
				}
			}
			if(c!=null){
				try{
					c.close();
				}catch(SQLException e){
					throw e;
				}
			}
		}
	}
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">10.Template/Callback Pattern - Separate a Callback</h2>
<h3 style="color:#FCF9F9">#Template is a not change part, Callback is changed changed : userDao</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	private JdbcContext jdbcContext;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.jdbcContext = new JdbcContext();
		
		this.jdbcContext.setDataSource(dataSource);
		
		this.dataSource = dataSource;
	}
	
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
		
		this.jdbcContext.workWithStrategyStatement(
		new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps  = c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
				ps.setString(1, user.getId());
				ps.setString(2, user.getName());
				ps.setString(3, user.getPassword());
				
				return ps;
			}
		 }
		 );
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
====================================================================================	
	public void deleteAll() throws SQLException{
		executeSql("delete from dao");
	}	
	
	private void executeSql(final String query)throws SQLException{
		this.jdbcContext.workWithStrategyStatement(
				 new StatementStrategy(){
					public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
						return c.prepareStatement(query);
						}
					}
					
			);
	}
	
====================================================================================	
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
	
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[JdbcContext]':'[JdbcContext]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>JdbcContext</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

public class JdbcContext {
	
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	public void workWithStrategyStatement(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = this.dataSource.getConnection();
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
			
		}catch(SQLException e){
			throw e;
		}finally{
			if( ps!= null){
				try{
					ps.close();
				}catch(SQLException e){
					throw e;
				}
			}
			if(c!=null){
				try{
					c.close();
				}catch(SQLException e){
					throw e;
				}
			}
		}
	}
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">11.Template/Callback Pattern - Callback go into Template</h2>
<h3 style="color:#FCF9F9"># changed : userDao, JdbcContext</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;


public class UserDao {
	
	private JdbcContext jdbcContext;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.jdbcContext = new JdbcContext();
		
		this.jdbcContext.setDataSource(dataSource);
		
		this.dataSource = dataSource;
	}
	
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
		
		this.jdbcContext.workWithStrategyStatement(
		new StatementStrategy(){
			public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
				PreparedStatement ps  = c.prepareStatement("insert into dao(id,name,password) values(?,?,?)");
				ps.setString(1, user.getId());
				ps.setString(2, user.getName());
				ps.setString(3, user.getPassword());
				
				return ps;
			}
		 }
		 );
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
====================================================================================		
	public void deleteAll() throws SQLException{
		this.jdbcContext.executeSql("delete from dao");
	}	
	
====================================================================================		
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
	
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
	
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[StatementStrategy]':'[StatementStrategy]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>StatementStrategy</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface StatementStrategy {
	PreparedStatement makePreparedStatement(Connection c)throws SQLException;
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[JdbcContext]':'[JdbcContext]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>JdbcContext</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

public class JdbcContext {
	
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
===========================================================================	
	public void executeSql(final String query)throws SQLException{
		workWithStrategyStatement(
				 new StatementStrategy(){
					public PreparedStatement makePreparedStatement(Connection c)throws SQLException{
						return c.prepareStatement(query);
						}
					}
					
			);
	}
===========================================================================	
	public void workWithStrategyStatement(StatementStrategy stmt)throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = this.dataSource.getConnection();
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
			
		}catch(SQLException e){
			throw e;
		}finally{
			if( ps!= null){
				try{
					ps.close();
				}catch(SQLException e){
					throw e;
				}
			}
			if(c!=null){
				try{
					c.close();
				}catch(SQLException e){
					throw e;
				}
			}
		}
	}
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">12.JdbcTemplate - update()</h2>
<h3 style="color:#FCF9F9"># changed : userDao, JdbcContext</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;


public class UserDao {
	======================================================================
	private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
		this.dataSource = dataSource;
	}
	======================================================================
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
	======================================================================	
		this.jdbcTemplate.update("insert into dao(id,name,password)value(?,?,?)",user.getId(),user.getName(),user.getPassword());
		======================================================================
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() throws SQLException{
	======================================================================
		this.jdbcTemplate.update("delete from dao");
	======================================================================			
	}	
	
	
	
	public int getCount() throws SQLException{
		Connection c = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("select count(*) from dao");
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		}catch(SQLException e){
			throw e;
		}finally{
			if(rs != null){
				try{
					rs.close();
				}catch(SQLException e){
					
				}
			}
			if(ps != null){
				try{
					ps.close();
				}catch(SQLException e){
					
				}
			}
			if(c != null){
				try{
					c.close();
				}catch(SQLException e){
					
				}
			}
		}
		
		
	}
	
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
	
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
	
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>


<h2 style="color:#FCF9F9">13.JdbcTemplate - queryForInt</h2>
<h3 style="color:#FCF9F9"># changed : userDao</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;


public class UserDao {
	private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
		this.dataSource = dataSource;
	}
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
		this.jdbcTemplate.update("insert into dao(id,name,password)value(?,?,?)",user.getId(),user.getName(),user.getPassword());
	}
	
	public User get(String id)throws  SQLException{
		//Class.forName("oracle.jdbc.driver.OracleDriver");
		//Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl1","HJEONG","1111");
		Connection c = dataSource.getConnection();
		PreparedStatement ps = c.prepareStatement("select * from dao where id = ?");
		
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		
		User user =null;
		if(rs.next()){
			user = new User();
			
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
		}
		rs.close();
		ps.close();
		c.close();
		
		
		if(user == null)throw new EmptyResultDataAccessException(1);
		
		return user;
	}
	
	public void deleteAll() {
		this.jdbcTemplate.update("delete from dao");
	}	
	
	
	===================================================================================
	public int getCount() throws SQLException{
		return this.jdbcTemplate.query(new PreparedStatementCreator(){
			public PreparedStatement createPreparedStatement(Connection con)throws SQLException{
				return con.prepareStatement("select count(*) from dao");
			}
		}, new ResultSetExtractor<Integer>(){
			public Integer extractData(ResultSet rs)throws SQLException,
				DataAccessException{
				rs.next();
				return rs.getInt(1);
			}
		});
	}
	
	===================================================================================
	|
	|
	|
	v
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	===================================================================================
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
	
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
	
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>


<h2 style="color:#FCF9F9">14.JdbcTemplate - queryForObject(), RowMapper</h2>
<h3 style="color:#FCF9F9"># changed : userDao</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class UserDao {
	
	private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
		this.dataSource = dataSource;
	}
	
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
		
		this.jdbcTemplate.update("insert into dao(id,name,password)value(?,?,?)",user.getId(),user.getName(),user.getPassword());
	}
	
	======================================================================================
	public User get(String id)throws  SQLException{
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[] {id},
					new RowMapper<User>(){
						public User mapRow(ResultSet rs, int rowNum)throws SQLException{
							User user = new User();
							user.setId(rs.getString("id"));
							user.setName(rs.getString("name"));
							user.setPassword(rs.getString("password"));
							return user;
						}
					}
				
				);
	}
	======================================================================================
	
	public void deleteAll() throws SQLException{
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	
	public int getCount() throws SQLException{
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		
	
		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		
	
		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">15.JdbcTemplate - query() and add function of getAll()</h2>
<h3 style="color:#FCF9F9"># changed : UserDao, UserDaoTest</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class UserDao {
	
	private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
		this.dataSource = dataSource;
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password)value(?,?,?)",user.getId(),user.getName(),user.getPassword());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[] {id},
					new RowMapper<User>(){
						public User mapRow(ResultSet rs, int rowNum)throws SQLException{
							User user = new User();
							user.setId(rs.getString("id"));
							user.setName(rs.getString("name"));
							user.setPassword(rs.getString("password"));
							return user;
						}
					}
				
				);
	}
	
	public void deleteAll() {
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	
	
	public int getCount() {
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	=====================================================================================
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					new RowMapper<User>(){
						public User mapRow(ResultSet rs, int rowNum)throws SQLException{
							User user = new User();
							user.setId(rs.getString("id"));
							user.setName(rs.getString("name"));
							user.setPassword(rs.getString("password"));
							return user;
						}
					}
				);
				
	}
	=====================================================================================
	
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(user2.getName(), is(user2.getName()));
		assertThat(user2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	=======================================================================
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user2);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(0));
		checkSameUser(user1, users3.get(1));
		checkSameUser(user2, users3.get(2));
		
		
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
	}
	=======================================================================
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">16.JdbcTemplate - delete useless DI and overlap</h2>
<h3 style="color:#FCF9F9"># changed : UserDao, UserDaoTest</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[User]':'[User]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>user</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package toby;

public class User {
	
	public User(String id, String name, String password){
		this.id = id;
		this.name= name;
		this.password = password;
	}
	
	public User(){}
	
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

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDao]':'[UserDao]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDao</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class UserDao {
	
	private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password)value(?,?,?)",user.getId(),user.getName(),user.getPassword());
	}
	============================================================================
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	============================================================================
	public void deleteAll() {
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	
	
	public int getCount() {
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	============================================================================
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
	============================================================================			
	}
	============================================================================
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			return user;
		}
	};
	============================================================================
	
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[applicationContext.xml]':'[applicationContext.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>applicationContext.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
	
	<bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
		<property name="driverClass" value ="com.mysql.jdbc.Driver"/>
		<property name="url" value = "jdbc:mysql://localhost/toby"/>
		<property name="username" value="root"/>
		<property name="password" value="1111"/>
	</bean>
	
	
	
	<bean id="userDao" class="toby.UserDao">
		<property name="dataSource" ref="dataSource"/>
	</bean>
	
</beans>

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[UserDaoTest]':'[UserDaoTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>UserDaoTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserDaoTest {
	
	@Autowired
	 ApplicationContext context;
	
	UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDao();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		dao.setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x");
		this.user1 = new User("v","v","v");
		this.user2 = new User("z","z","z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		assertThat(userget1.getName(), is(user1.getName()));
		assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		assertThat(userget2.getName(), is(user2.getName()));
		assertThat(userget2.getPassword(),is(user2.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	@Test(expected=EmptyResultDataAccessException.class)
	public void getUserFailure() throws SQLException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.get("unknown");
	}
	
	@Test
	public void getAll() throws SQLException, ClassNotFoundException{
		dao.deleteAll();
		
		
		List<User> users0 =dao.getAll();
		assertThat(users0.size(), is(0));
		
		dao.add(user1);
		List<User> users1 = dao.getAll();
		assertThat(users1.size(),is(1));
		checkSameUser(user1, users1.get(0));
		
		dao.add(user2);
		List<User> users2 = dao.getAll();
		assertThat(users2.size(),is(2));
		checkSameUser(user1, users2.get(0));
		checkSameUser(user2, users2.get(1));
		
		dao.add(user3);
		List<User> users3 = dao.getAll();
		assertThat(users3.size(),is(3));
		checkSameUser(user3, users3.get(1));
		checkSameUser(user1, users3.get(0));
		checkSameUser(user2, users3.get(2));
		
		
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}


</font>
</pre>
</div>


</body>
</html>

