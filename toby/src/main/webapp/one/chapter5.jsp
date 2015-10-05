<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
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

<h1 style="color:">Chapter5 - AOP</h1>

<table border="1" width="100%">
	<colgroup>
		<col width="600"/>
		<col width="600"/>
	</colgroup>
	<tr>
		<td valign="top" width="30%">
			<h2 style="color:#1E90FF">1.separate Method - segregate business logic and transaction in service</h2>
			<h3 style="color:"># changed : UserService</h3>
				<input type="button" onclick="makeGreen('a1')" value="User">
				<input type="button" onclick="makeGreen('a2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('a3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('a4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('a5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('a6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('a7')" value="UserService">
				<input type="button" onclick="makeGreen('a8')" value="UserServiceTest">
			<h2 style="color:#1E90FF">2.separate Method - seprate class from the UserService and change UserService</h2>
			<h3 style="color:"># changed : UserService, UserServiceTest, UserServiceImpl, UserServiceTx,applicataionContext.xml</h3>
				<input type="button" onclick="makeGreen('b1')" value="User">
				<input type="button" onclick="makeGreen('b2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('b3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('b4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('b5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('b6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('b7')" value="UserService(I)">
				<input type="button" onclick="makeGreen('b8')" value="UserServiceTest">
				<input type="button" onclick="makeGreen('b9)" value="UserServiceImpl">
				<input type="button" onclick="makeGreen('b10')" value="UserServiceTx">
			<h2 style="color:#1E90FF">3.separate Method - Unit test </h2>
			<h3 style="color:"># changed : UserServiceTest</h3>
				<input type="button" onclick="makeGreen('c1')" value="User">
				<input type="button" onclick="makeGreen('c2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('c3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('c4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('c5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('c6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('c7')" value="UserService(I)">
				<input type="button" onclick="makeGreen('c8')" value="UserServiceTest">
				<input type="button" onclick="makeGreen('c9)" value="UserServiceImpl">
				<input type="button" onclick="makeGreen('c10')" value="UserServiceTx">
			<h2 style="color:#1E90FF">4. separate Method - Use a Mockito Framework</h2>
			<h3 style="color:"># changed : UserServiceTest</h3>
				<input type="button" onclick="makeGreen('d1')" value="User">
				<input type="button" onclick="makeGreen('d2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('d3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('d4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('d5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('d6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('d7')" value="UserService(I)">
				<input type="button" onclick="makeGreen('d8')" value="UserServiceTest">
				<input type="button" onclick="makeGreen('d9)" value="UserServiceImpl">
				<input type="button" onclick="makeGreen('d10')" value="UserServiceTx">
			<h2 style="color:#1E90FF">5. separate Method - Use a Dynamic Proxy</h2>
			<h3 style="color:"># use a Dynamic proxy to apply transaction</h3>
			<h3 style="color:"># changed : UserServiceTest, TransactionHandler</h3>
				<input type="button" onclick="makeGreen('e1')" value="User">
				<input type="button" onclick="makeGreen('e2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('e3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('e4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('e5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('e6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('e7')" value="UserService(I)">
				<input type="button" onclick="makeGreen('e8')" value="UserServiceTest">
				<input type="button" onclick="makeGreen('e9)" value="UserServiceImpl">
				<input type="button" onclick="makeGreen('e10')" value="UserServiceTx">
				<input type="button" onclick="makeGreen('e11')" value="TransactionHandler">
			<h2 style="color:#1E90FF">6.Transaction Proxy Factory bean</h2>	
			<h3 style="color:"># changed : UserServiceTest, applicationContext.xml, TxProxyFactoryBean</h3>
			<h3 style="color:"># Use a InvocationHandler</h3>
				<input type="button" onclick="makeGreen('f1')" value="User">
				<input type="button" onclick="makeGreen('f2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('f3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('f4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('f5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('f6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('f7')" value="UserService(I)">
				<input type="button" onclick="makeGreen('f8')" value="UserServiceTest">
				<input type="button" onclick="makeGreen('f9)" value="UserServiceImpl">
				<input type="button" onclick="makeGreen('f10')" value="UserServiceTx">
				<input type="button" onclick="makeGreen('f11')" value="TransactionHandler">
				<input type="button" onclick="makeGreen('f12')" value="TxProxyFactoryBean">
			<h2 style="color:#1E90FF">7.Spring Dynamic proxy - ProxyFactoryBean</h2>	
			<h3 style="color:"># changed : DynamicProxyTest</h3>
			<h3 style="color:"># Use a MethodInterceptor</h3>
				<input type="button" onclick="makeGreen('g1')" value="User">
				<input type="button" onclick="makeGreen('g2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('g3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('g4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('g5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('g6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('g7')" value="UserService(I)">
				<input type="button" onclick="makeGreen('g8')" value="UserServiceTest">
				<input type="button" onclick="makeGreen('g9)" value="UserServiceImpl">
				<input type="button" onclick="makeGreen('g10')" value="UserServiceTx">
				<input type="button" onclick="makeGreen('g11')" value="TransactionHandler">
				<input type="button" onclick="makeGreen('g12')" value="TxProxyFactoryBean">
				<input type="button" onclick="makeGreen('g13')" value="DynamicProxyTest">
			<h2 style="color:#1E90FF">8.ProxyFactoryBean - pointcut, advisor</h2>	
			<h3 style="color:"># changed : DynamicProxyTest</h3>
				<input type="button" onclick="makeGreen('h1')" value="DynamicProxyTest">
			<h2 style="color:#1E90FF">9.ProxyFactoryBean - To Apply ProxyFactoryBean  </h2>	
			<h3 style="color:"># changed : TxProxyFactoryBean, applicationContext.xml, TransactionAdvice </h3>
				<input type="button" onclick="makeGreen('i1')" value="User">
				<input type="button" onclick="makeGreen('i2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('i3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('i4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('i5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('i6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('i7')" value="UserService(I)">
				<input type="button" onclick="makeGreen('i8')" value="UserServiceTest">
				<input type="button" onclick="makeGreen('i9)" value="UserServiceImpl">
				<input type="button" onclick="makeGreen('i10')" value="UserServiceTx">
				<input type="button" onclick="makeGreen('i11')" value="TransactionHandler">
				<input type="button" onclick="makeGreen('i12')" value="TransactionAdvice">
			<h2 style="color:#1E90FF">10.PointCutTest - ClassFilter  </h2>	
			<h3 style="color:"># changed : DynamicProxyTest </h3>
				<input type="button" onclick="makeGreen('j1')" value="DynamicProxyTest">
			<h2 style="color:#1E90FF">11.AutoProxy - DefaultAdvisorAutoProxyCreator </h2>	
			<h3 style="color:"># changed : applicationContext.xml, UserServiceTest, NameMatchClassMethodPointCut </h3>
				<input type="button" onclick="makeGreen('k1')" value="User">
				<input type="button" onclick="makeGreen('k2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('k3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('k4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('k5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('k6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('k7')" value="UserService(I)">
				<input type="button" onclick="makeGreen('k8')" value="UserServiceTest">
				<input type="button" onclick="makeGreen('k9)" value="UserServiceImpl">
				<input type="button" onclick="makeGreen('k10')" value="UserServiceTx">
				<input type="button" onclick="makeGreen('k11')" value="TransactionHandler">
				<input type="button" onclick="makeGreen('k12')" value="TransactionAdvice">
				<input type="button" onclick="makeGreen('k13')" value="NameMatchClassMethodPointCut">
			<h2 style="color:#1E90FF">12.set AOP in applicatioinContext.xml </h2>	
			<h3 style="color:"># changed : applicationContext.xml</h3>
				<input type="button" onclick="makeGreen('l1')" value="applicationContext.xml">
			
			
		</td>
		<td valign="top" bgcolor="#ddfF4ff" >
		<input type="button" onclick="makeClean1()" value="Clean">
		   <iframe name="ifrm" id="ifrm" width="650" height="1200" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes">
		   </iframe>
		</td>
		<td valign="top" bgcolor="#ddfF4ff" >
		<input type="button" onclick="makeClean2()" value="Clean">
		   <iframe name="ifrm1" id="ifrm1" width="650" height="1200" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes"></iframe>
		</td>
	</tr>
</table>


<div id="a1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="a3" style="display: none">

(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.UserService")
		(property name="userDao" ref="userDao"/)
		(property name="transactionManager" ref="transactionManager"/)
	(/bean)
	
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	
(/beans)

</div>
<div id="a4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="a5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="a6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="a7" style="display: none" >
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
public class UserService {
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	========================================================================
	public void upgradeLevels()throws Exception{
		
		TransactionStatus status =
				this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			upgradeLevelsInternal();
			this.transactionManager.commit(status);
		}catch (RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
	}
	
	private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}
	========================================================================
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
	
}

</div>
<div id="a8" style="display: none">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static toby.UserService.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserService.MIN_RECCOMEND_FOR_GOLD;

import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE)
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		userDao.deleteAll();
		
		for(User user : users)userDao.add(user);
		
		userService.upgradeLevels();
		
		
		checkLevelUpgraded(users.get(0), false);
		checkLevelUpgraded(users.get(1),  true);
		checkLevelUpgraded(users.get(2),  false);
		checkLevelUpgraded(users.get(3),  true);
		checkLevelUpgraded(users.get(4),  false);
		
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null) continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=IllegalStateException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		UserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			testUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		checkLevelUpgraded(users.get(1), false);
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	static class TestUserService extends UserService {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
	
}

</div>

<div id="b1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="b3" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	======================================================================
	(bean id ="userService" class="toby.UserServiceTx")
		(property name="transactionManager" ref="transactionManager"/)
		(property name="userService" ref="userServiceImpl"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	======================================================================
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)

(/beans)

</div>
<div id="b4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="b5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="b6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="b7" style="display: none">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
}
</div>

<div id="b8" style="display: none" >

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	==========================================================================
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	==========================================================================
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		userDao.deleteAll();
		
		for(User user : users)userDao.add(user);
		
		userService.upgradeLevels();
		

		checkLevelUpgraded(users.get(0), false);
		checkLevelUpgraded(users.get(1),  true);
		checkLevelUpgraded(users.get(2),  false);
		checkLevelUpgraded(users.get(3),  true);
		checkLevelUpgraded(users.get(4),  false);
		
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null) continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=IllegalStateException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	==========================================================================
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
			
		UserServiceTx txUserService = new UserServiceTx();
		txUserService.setTransactionManager(transactionManager);
		txUserService.setUserService(testUserService);
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			txUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		checkLevelUpgraded(users.get(1), false);
	}
	==========================================================================
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	==========================================================================
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
	==========================================================================
	
}
</div>
<div id="b9" style="display: none">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
}


</div>

<div id="b10" style="display: none">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</div>


<div id="c1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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
<div id="c2" style="display: none">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="c3" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.UserServiceTx")
		(property name="transactionManager" ref="transactionManager"/)
		(property name="userService" ref="userServiceImpl"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)

(/beans)

</div>
<div id="c4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="c5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="c6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="c7" style="display: none">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
}
</div>

<div id="c8" style="display: none" >

package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	====================================================================
	@Test
	public void upgradeLevels() throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		MockUserDao mockUserDao = new MockUserDao(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		
		userServiceImpl.upgradeLevels();
		
		List<User> updated = mockUserDao.getUpdated();
		assertThat(updated.size(),is(2));
		checkUserAndLevel(updated.get(0),"bb",Level.SILVER);
		checkUserAndLevel(updated.get(1),"dd",Level.GOLD);
		
		
	}
	
	private void checkUserAndLevel(User updated, String expectedId, Level expectedLevel){
		assertThat(updated.getId(), is(expectedId));
		assertThat(updated.getLevel(), is(expectedLevel));
	}
	====================================================================
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null)continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=NullPointerException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
			
		UserServiceTx txUserService = new UserServiceTx();
		txUserService.setTransactionManager(transactionManager);
		txUserService.setUserService(testUserService);
		
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			txUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		checkLevelUpgraded(users.get(1), false);
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	==========================================================
	static class MockUserDao implements UserDao{
		
		private List<User> users;
		private List<User> updated = new ArrayList();
		
		private MockUserDao(List<User> users){
			this.users = users;
		}
		
		public List<User> getUpdated(){
			return this.updated;
		}
		
		public List<User> getAll(){
			return this.users;
		}
		
		public void update(User user){
			updated.add(user);
		}
		
		public void add(User user){ throw new UnsupportedOperationException();}
		public void deleteAll(){ throw new UnsupportedOperationException();}
		public User get(String id){ throw new UnsupportedOperationException();}
		public int getCount(){ throw new UnsupportedOperationException();}
		
		
	}
	==========================================================
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
	}
}

</div>
<div id="c9" style="display: none">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
}


</div>

<div id="c10" style="display: none">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</div>

<div id="d1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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
<div id="d2" style="display: none">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="d3" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.UserServiceTx")
		(property name="transactionManager" ref="transactionManager"/)
		(property name="userService" ref="userServiceImpl"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)

(/beans)

</div>
<div id="d4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="d5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="d6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="d7" style="display: none">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
}
</div>

<div id="d8" style="display: none" >
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Matchers.*;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		MockUserDao mockUserDao = new MockUserDao(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		
		userServiceImpl.upgradeLevels();
		
		List<User> updated = mockUserDao.getUpdated();
		assertThat(updated.size(),is(2));
		checkUserAndLevel(updated.get(0),"bb",Level.SILVER);
		checkUserAndLevel(updated.get(1),"dd",Level.GOLD);
		
		
	}
	
	private void checkUserAndLevel(User updated, String expectedId, Level expectedLevel){
		assertThat(updated.getId(), is(expectedId));
		assertThat(updated.getLevel(), is(expectedLevel));
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null)continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=NullPointerException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
			
		UserServiceTx txUserService = new UserServiceTx();
		txUserService.setTransactionManager(transactionManager);
		txUserService.setUserService(testUserService);
		
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			txUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		checkLevelUpgraded(users.get(1), false);
	}
	====================================================================
	@Test
	public void mockUpgradeLevels()throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		UserDao mockUserDao = mock(UserDao.class);
		when(mockUserDao.getAll()).thenReturn(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		userServiceImpl.upgradeLevels();
		
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao).update(users.get(1));
		assertThat(users.get(1).getLevel(),is(Level.SILVER));
		verify(mockUserDao).update(users.get(3));
		assertThat(users.get(3).getLevel(),is(Level.GOLD));
		
	}
	====================================================================
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	static class MockUserDao implements UserDao{
		
		private List<User> users;
		private List<User> updated = new ArrayList();
		
		private MockUserDao(List<User> users){
			this.users = users;
		}
		
		public List<User> getUpdated(){
			return this.updated;
		}
		
		public List<User> getAll(){
			return this.users;
		}
		
		public void update(User user){
			updated.add(user);
		}
		
		public void add(User user){ throw new UnsupportedOperationException();}
		public void deleteAll(){ throw new UnsupportedOperationException();}
		public User get(String id){ throw new UnsupportedOperationException();}
		public int getCount(){ throw new UnsupportedOperationException();}
		
		
	}
	
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
}
</div>
<div id="d9" style="display: none">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
}


</div>

<div id="d10" style="display: none">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</div>

<div id="e1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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
<div id="e2" style="display: none">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="e3" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.UserServiceTx")
		(property name="transactionManager" ref="transactionManager"/)
		(property name="userService" ref="userServiceImpl"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)

(/beans)

</div>
<div id="e4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="e5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="e6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="e7" style="display: none">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
}
</div>

<div id="e8" style="display: none" >
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.lang.reflect.Proxy;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		MockUserDao mockUserDao = new MockUserDao(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		
		userServiceImpl.upgradeLevels();
		
		List<User> updated = mockUserDao.getUpdated();
		assertThat(updated.size(),is(2));
		checkUserAndLevel(updated.get(0),"bb",Level.SILVER);
		checkUserAndLevel(updated.get(1),"dd",Level.GOLD);
		
		
	}
	
	private void checkUserAndLevel(User updated, String expectedId, Level expectedLevel){
		assertThat(updated.getId(), is(expectedId));
		assertThat(updated.getLevel(), is(expectedLevel));
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null)continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=NullPointerException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	==================================================================================
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
			
		TransactionHandler txHandler = new TransactionHandler();
		txHandler.setTarget(testUserService);
		txHandler.setTransactionManager(transactionManager);
		txHandler.setPattern("upgradeLevels");
		
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		UserService txUserService =(UserService)Proxy.newProxyInstance(getClass().getClassLoader(), new Class[]{UserService.class}, txHandler);
		
		checkLevelUpgraded(users.get(1), false);
	}
	==================================================================================
	@Test
	public void mockUpgradeLevels()throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		UserDao mockUserDao = mock(UserDao.class);
		when(mockUserDao.getAll()).thenReturn(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		userServiceImpl.upgradeLevels();
		
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao).update(users.get(1));
		assertThat(users.get(1).getLevel(),is(Level.SILVER));
		verify(mockUserDao).update(users.get(3));
		assertThat(users.get(3).getLevel(),is(Level.GOLD));
		
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	static class MockUserDao implements UserDao{
		
		private List<User> users;
		private List<User> updated = new ArrayList();
		
		private MockUserDao(List<User> users){
			this.users = users;
		}
		
		public List<User> getUpdated(){
			return this.updated;
		}
		
		public List<User> getAll(){
			return this.users;
		}
		
		public void update(User user){
			updated.add(user);
		}
		
		public void add(User user){ throw new UnsupportedOperationException();}
		public void deleteAll(){ throw new UnsupportedOperationException();}
		public User get(String id){ throw new UnsupportedOperationException();}
		public int getCount(){ throw new UnsupportedOperationException();}
		
		
	}
	
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
	
}
</div>
<div id="e9" style="display: none">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
}


</div>

<div id="e10" style="display: none">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</div>

<div id="e11" style="display: none">
package toby;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionHandler implements InvocationHandler{
	
	private Object target; //부가기능을 제공할 타깃 오브젝트
	private PlatformTransactionManager transactionManager; //트랜잭션 기능을 제공하는 데 필요한 트랜잭션 매니저
	private String pattern; //트랜잭션을 적용할 메소드 이름 패턴
	
	public void setTarget(Object target){
		this.target = target;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setPattern(String pattern){
		this.pattern = pattern;
	}
	
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable{
		
		if(method.getName().startsWith(pattern)){
			return invokeInTransaction(method, args);
		}else{
			return method.invoke(target, args);
		}
		
	}
	
	private Object invokeInTransaction(Method method, Object[] args)throws Throwable{
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			Object ret = method.invoke(target, args);
			this.transactionManager.commit(status);
			return ret;
		}catch(InvocationTargetException e){
			this.transactionManager.rollback(status);
			throw e.getTargetException();
		}
	}
	
}

</div>

<div id="f1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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
<div id="f2" style="display: none">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="f3" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	==============================================================================		
	(bean id ="userService" class="toby.TxProxyFactoryBean")
		(property name="target" ref="userServiceImpl"/)
		(property name="transactionManager" ref="transactionManager"/)
		(property name="pattern" value="upgradeLevels"/)
		(property name="serviceInterface" value="toby.UserService"/)
	(/bean)
	==============================================================================
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)

(/beans)

</div>
<div id="f4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="f5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="f6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="f7" style="display: none">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
}
</div>

<div id="f8" style="display: none" >
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	=======================================================================================
	@Autowired ApplicationContext context;
	=======================================================================================
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		MockUserDao mockUserDao = new MockUserDao(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		
		userServiceImpl.upgradeLevels();
		
		List<User> updated = mockUserDao.getUpdated();
		assertThat(updated.size(),is(2));
		checkUserAndLevel(updated.get(0),"bb",Level.SILVER);
		checkUserAndLevel(updated.get(1),"dd",Level.GOLD);
		
		
	}
	
	private void checkUserAndLevel(User updated, String expectedId, Level expectedLevel){
		assertThat(updated.getId(), is(expectedId));
		assertThat(updated.getLevel(), is(expectedLevel));
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null)continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=NullPointerException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	=======================================================================================
	@Test
	@DirtiesContext
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
			
		TxProxyFactoryBean txProxyFactoryBean = 
				context.getBean("&userService",TxProxyFactoryBean.class);
		
		txProxyFactoryBean.setTarget(testUserService);
		UserService txUserService = (UserService)txProxyFactoryBean.getObject();
		
		TransactionHandler txHandler = new TransactionHandler();
		txHandler.setTarget(testUserService);
		txHandler.setTransactionManager(transactionManager);
		txHandler.setPattern("upgradeLevels");
		
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			txUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		
		checkLevelUpgraded(users.get(1), false);
	}
	=======================================================================================
	@Test
	public void mockUpgradeLevels()throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		UserDao mockUserDao = mock(UserDao.class);
		when(mockUserDao.getAll()).thenReturn(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		userServiceImpl.upgradeLevels();
		
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao).update(users.get(1));
		assertThat(users.get(1).getLevel(),is(Level.SILVER));
		verify(mockUserDao).update(users.get(3));
		assertThat(users.get(3).getLevel(),is(Level.GOLD));
		
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	static class MockUserDao implements UserDao{
		
		private List<User> users;
		private List<User> updated = new ArrayList();
		
		private MockUserDao(List<User> users){
			this.users = users;
		}
		
		public List<User> getUpdated(){
			return this.updated;
		}
		
		public List<User> getAll(){
			return this.users;
		}
		
		public void update(User user){
			updated.add(user);
		}
		
		public void add(User user){ throw new UnsupportedOperationException();}
		public void deleteAll(){ throw new UnsupportedOperationException();}
		public User get(String id){ throw new UnsupportedOperationException();}
		public int getCount(){ throw new UnsupportedOperationException();}
		
		
	}
	
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
}
</div>
<div id="f9" style="display: none">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
}


</div>

<div id="f10" style="display: none">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</div>

<div id="f11" style="display: none">
package toby;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionHandler implements InvocationHandler{
	
	private Object target; //부가기능을 제공할 타깃 오브젝트
	private PlatformTransactionManager transactionManager; //트랜잭션 기능을 제공하는 데 필요한 트랜잭션 매니저
	private String pattern; //트랜잭션을 적용할 메소드 이름 패턴
	
	public void setTarget(Object target){
		this.target = target;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setPattern(String pattern){
		this.pattern = pattern;
	}
	
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable{
		
		if(method.getName().startsWith(pattern)){
			return invokeInTransaction(method, args);
		}else{
			return method.invoke(target, args);
		}
		
	}
	
	private Object invokeInTransaction(Method method, Object[] args)throws Throwable{
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			Object ret = method.invoke(target, args);
			this.transactionManager.commit(status);
			return ret;
		}catch(InvocationTargetException e){
			this.transactionManager.rollback(status);
			throw e.getTargetException();
		}
	}
	
}

</div>

<div id="f12" style="display: none">
package toby;

import java.lang.reflect.Proxy;

import org.springframework.beans.factory.FactoryBean;
import org.springframework.transaction.PlatformTransactionManager;

public class TxProxyFactoryBean implements FactoryBean(Object){
	
	Object target;
	PlatformTransactionManager transactionManager;
	String pattern;
	
	Class(?) serviceInterface;
	
	public void setTarget(Object target){
		this.target = target;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setPattern(String pattern){
		this.pattern = pattern;
	}
	
	public void setServiceInterface(Class(?)serviceInterface){
		this.serviceInterface = serviceInterface;
	}
	
	
	public Object getObject()throws Exception{
		TransactionHandler txHandler = new TransactionHandler();
		txHandler.setTarget(target);
		txHandler.setTransactionManager(transactionManager);
		txHandler.setPattern(pattern);
		return Proxy.newProxyInstance(getClass().getClassLoader(),new Class[]{serviceInterface},
				txHandler);
	}
	
	public Class(?)getObjectType(){
		return serviceInterface;
	}
	
	public boolean isSingleton(){
		return false;
	}
}

</div>


<div id="g1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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
<div id="g2" style="display: none">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="g3" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.TxProxyFactoryBean")
		(property name="target" ref="userServiceImpl"/)
		(property name="transactionManager" ref="transactionManager"/)
		(property name="pattern" value="upgradeLevels"/)
		(property name="serviceInterface" value="toby.UserService"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)

(/beans)

</div>
<div id="g4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="g5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="g6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="g7" style="display: none">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
}
</div>

<div id="g8" style="display: none" >
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {

	@Autowired ApplicationContext context;
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		MockUserDao mockUserDao = new MockUserDao(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		
		userServiceImpl.upgradeLevels();
		
		List<User> updated = mockUserDao.getUpdated();
		assertThat(updated.size(),is(2));
		checkUserAndLevel(updated.get(0),"bb",Level.SILVER);
		checkUserAndLevel(updated.get(1),"dd",Level.GOLD);
		
		
	}
	
	private void checkUserAndLevel(User updated, String expectedId, Level expectedLevel){
		assertThat(updated.getId(), is(expectedId));
		assertThat(updated.getLevel(), is(expectedLevel));
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null)continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=NullPointerException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	
	@Test
	@DirtiesContext
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
			
		TxProxyFactoryBean txProxyFactoryBean = 
				context.getBean("&userService",TxProxyFactoryBean.class);
		
		txProxyFactoryBean.setTarget(testUserService);
		UserService txUserService = (UserService)txProxyFactoryBean.getObject();
		
		TransactionHandler txHandler = new TransactionHandler();
		txHandler.setTarget(testUserService);
		txHandler.setTransactionManager(transactionManager);
		txHandler.setPattern("upgradeLevels");
		
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			txUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		
		checkLevelUpgraded(users.get(1), false);
	}
	
	@Test
	public void mockUpgradeLevels()throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		UserDao mockUserDao = mock(UserDao.class);
		when(mockUserDao.getAll()).thenReturn(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		userServiceImpl.upgradeLevels();
		
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao).update(users.get(1));
		assertThat(users.get(1).getLevel(),is(Level.SILVER));
		verify(mockUserDao).update(users.get(3));
		assertThat(users.get(3).getLevel(),is(Level.GOLD));
		
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	static class MockUserDao implements UserDao{
		
		private List<User> users;
		private List<User> updated = new ArrayList();
		
		private MockUserDao(List<User> users){
			this.users = users;
		}
		
		public List<User> getUpdated(){
			return this.updated;
		}
		
		public List<User> getAll(){
			return this.users;
		}
		
		public void update(User user){
			updated.add(user);
		}
		
		public void add(User user){ throw new UnsupportedOperationException();}
		public void deleteAll(){ throw new UnsupportedOperationException();}
		public User get(String id){ throw new UnsupportedOperationException();}
		public int getCount(){ throw new UnsupportedOperationException();}
		
		
	}
	
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
}
</div>
<div id="g9" style="display: none">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
}


</div>

<div id="g10" style="display: none">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</div>

<div id="g11" style="display: none">
package toby;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionHandler implements InvocationHandler{
	
	private Object target; //부가기능을 제공할 타깃 오브젝트
	private PlatformTransactionManager transactionManager; //트랜잭션 기능을 제공하는 데 필요한 트랜잭션 매니저
	private String pattern; //트랜잭션을 적용할 메소드 이름 패턴
	
	public void setTarget(Object target){
		this.target = target;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setPattern(String pattern){
		this.pattern = pattern;
	}
	
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable{
		
		if(method.getName().startsWith(pattern)){
			return invokeInTransaction(method, args);
		}else{
			return method.invoke(target, args);
		}
		
	}
	
	private Object invokeInTransaction(Method method, Object[] args)throws Throwable{
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			Object ret = method.invoke(target, args);
			this.transactionManager.commit(status);
			return ret;
		}catch(InvocationTargetException e){
			this.transactionManager.rollback(status);
			throw e.getTargetException();
		}
	}
	
}

</div>

<div id="g12" style="display: none">
package toby;

import java.lang.reflect.Proxy;

import org.springframework.beans.factory.FactoryBean;
import org.springframework.transaction.PlatformTransactionManager;

public class TxProxyFactoryBean implements FactoryBean(Object){
	
	Object target;
	PlatformTransactionManager transactionManager;
	String pattern;
	
	Class(?) serviceInterface;
	
	public void setTarget(Object target){
		this.target = target;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setPattern(String pattern){
		this.pattern = pattern;
	}
	
	public void setServiceInterface(Class(?)serviceInterface){
		this.serviceInterface = serviceInterface;
	}
	
	
	public Object getObject()throws Exception{
		TransactionHandler txHandler = new TransactionHandler();
		txHandler.setTarget(target);
		txHandler.setTransactionManager(transactionManager);
		txHandler.setPattern(pattern);
		return Proxy.newProxyInstance(getClass().getClassLoader(),new Class[]{serviceInterface},
				txHandler);
	}
	
	public Class(?)getObjectType(){
		return serviceInterface;
	}
	
	public boolean isSingleton(){
		return false;
	}
}

</div>

<div id="g13" style="display: none">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.lang.reflect.Proxy;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.junit.Test;
import org.springframework.aop.framework.ProxyFactoryBean;

public class DynamicProxyTest {
	
	@Test
	public void simpleProxy(){
		Hello proxiedHello = (Hello)Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class[]{Hello.class},
				new UppercaseHandler(new HelloTarget()));
	}
	-------------------------------------------------------------------------------------------------
	@Test
	public void proxyFactoryBean(){
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(new HelloTarget());
		pfBean.addAdvice(new UppercaseAdvice());
		
		Hello proxiedHello = (Hello)pfBean.getObject();
		assertThat(proxiedHello.sayHello("Toby"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		
		
	}
	
	static class UppercaseAdvice implements MethodInterceptor{
		public Object invoke(MethodInvocation invacation)throws Throwable{
			String ret = (String)invacation.proceed();
			return ret.toUpperCase();
		}
	}
	
	static interface Hello{
		String sayHello(String name);
		String sayHi(String name);
		String sayThankYou(String name);
	}
	
	static class HelloTarget implements Hello{
		public String sayHello(String name){
			return "Hello" + name;
		}
		public String sayHi(String name){
			return "Hi" + name;
		}
		public String sayThankYou(String name){
			return "Thank You" + name;
		}
	}
	
	static class UppercaseHandler implements InvocationHandler{
		
		Object target;
		
		public UppercaseHandler(Object target){
			this.target = target;
		}
		
		public Object invoke(Object proxy, Method method, Object[] args)throws Throwable{
			Object ret = (String)method.invoke(target, args);
			if(ret instanceof String){
				return ((String)ret).toUpperCase();
			}else{
				return ret;
			}
		}
	}
	----------------------------------------------------------------------------------------
}

</div>

<div id="h1" style="display: none">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.junit.Test;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.aop.support.NameMatchMethodPointcut;

public class DynamicProxyTest {
	
	@Test
	public void simpleProxy(){
		Hello proxiedHello = (Hello)Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class[]{Hello.class},
				new UppercaseHandler(new HelloTarget()));
	}
	
	@Test
	public void proxyFactoryBean(){
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(new HelloTarget());
		pfBean.addAdvice(new UppercaseAdvice());
		
		Hello proxiedHello = (Hello)pfBean.getObject();
		assertThat(proxiedHello.sayHello("Toby"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		
	}
	---------------------------------------------------------------------------------------------------------
	@Test
	public void pointcutAdvisor(){
		
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(new HelloTarget());
		
		NameMatchMethodPointcut pointcut = new NameMatchMethodPointcut();//메소드 이름을 비교해서 대상을 선정하는 알고리즘을 제공하는 포인트컷 생성
		pointcut.setMappedName("sayH*");// 이름 비교조건 설정, sayH로 시작하는 모든 메소드를 선택하게 한다
		
		pfBean.addAdvisor(new DefaultPointcutAdvisor(pointcut, new UppercaseAdvice()));
		
		Hello proxiedHello = (Hello)pfBean.getObject();
		
		assertThat(proxiedHello.sayHello("tOBY"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		assertThat(proxiedHello.sayThankYou("Toby"),is("Thank YouToby"));
		//메소드이름이 포인트컷의 선정조건에 맞지 않으므로, 부가기능이 적용안됨
		
		
	}
	---------------------------------------------------------------------------------------------------------
	static class UppercaseAdvice implements MethodInterceptor{
		public Object invoke(MethodInvocation invacation)throws Throwable{
			String ret = (String)invacation.proceed();
			return ret.toUpperCase();
		}
	}
	
	static interface Hello{
		String sayHello(String name);
		String sayHi(String name);
		String sayThankYou(String name);
	}
	
	static class HelloTarget implements Hello{
		public String sayHello(String name){
			return "Hello" + name;
		}
		public String sayHi(String name){
			return "Hi" + name;
		}
		public String sayThankYou(String name){
			return "Thank You" + name;
		}
	}
	

    static class UppercaseHandler implements InvocationHandler{
		
		Object target;
		
		public UppercaseHandler(Object target){
			this.target = target;
		}
		
		public Object invoke(Object proxy, Method method, Object[] args)throws Throwable{
			Object ret = (String)method.invoke(target, args);
			if(ret instanceof String){
				return ((String)ret).toUpperCase();
			}else{
				return ret;
			}
		}
	}

	
}

</div>

<div id="i1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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
<div id="i2" style="display: none">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="i3" style="display: none">
<?xml version="1.0" encoding="UTF-8"?>
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	---------------------------------------------------------------------------------------
	(bean id ="userService" class="org.springframework.aop.framework.ProxyFactoryBean")
		(property name="target" ref="userServiceImpl"/)
		(property name="interceptorNames")(!-- 어드바이스와 어드바이저를 동시에 설정해줄수 있는프로 퍼티,
		리스트에 어드바이스나 어드바이저의 빈 아이디를 값으로 넣어주면 된다. 기존의 ref 애트리뷰트를 사용하는 DI와는 방식이 다름에 주의 가능 --)
			(list)
				(value)transactionAdvisor(/value) (!-- 한개이상의 value 가능 --)
			(/list)
		(/property)
	(/bean)
	---------------------------------------------------------------------------------------
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	---------------------------------------------------------------------------------------
	(bean id="transactionAdvice" class="toby.TransactionAdvice")
		(property name="transactionManager" ref="transactionManager"/)
	(/bean)
	
	(bean id="transactionPointcut" class="org.springframework.aop.support.NameMatchMethodPointcut")
		(property name="mappedName" value="upgrade*"/)
	(/bean)
	
	(bean id="transactionAdvisor" class="org.springframework.aop.support.DefaultPointcutAdvisor")
		(property name="advice" ref="transactionAdvice"/)
		(property name="pointcut" ref="transactionPointcut"/)
	(/bean)
	---------------------------------------------------------------------------------------
(/beans)
</div>
<div id="i4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="i5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="i6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="i7" style="display: none">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
}
</div>

<div id="i8" style="display: none" >
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired ApplicationContext context;
	
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		MockUserDao mockUserDao = new MockUserDao(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		
		userServiceImpl.upgradeLevels();
		
		List<User> updated = mockUserDao.getUpdated();
		assertThat(updated.size(),is(2));
		checkUserAndLevel(updated.get(0),"bb",Level.SILVER);
		checkUserAndLevel(updated.get(1),"dd",Level.GOLD);
		
		
	}
	
	private void checkUserAndLevel(User updated, String expectedId, Level expectedLevel){
		assertThat(updated.getId(), is(expectedId));
		assertThat(updated.getLevel(), is(expectedLevel));
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null)continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=NullPointerException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	
	@Test
	@DirtiesContext
	public void upgradeAllofNothing() throws Exception{
		
		TestUserService testUserService = new TestUserService(users.get(3).getId());
		testUserService.setTransactionManager(transactionManager);
		testUserService.setUserDao(this.userDao);
		testUserService.setDataSource(this.dataSource);
		--------------------------------------------------------------------------	
		ProxyFactoryBean txProxyFactoryBean = 
				context.getBean("&userService",ProxyFactoryBean.class);
		--------------------------------------------------------------------------
		txProxyFactoryBean.setTarget(testUserService);
		UserService txUserService = (UserService)txProxyFactoryBean.getObject();
		
		TransactionHandler txHandler = new TransactionHandler();
		txHandler.setTarget(testUserService);
		txHandler.setTransactionManager(transactionManager);
		txHandler.setPattern("upgradeLevels");
		
		
		userDao.deleteAll();
		for(User user : users) userDao.add(user);
		
		try{
			txUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
			
		}
		
		
		checkLevelUpgraded(users.get(1), false);
	}
	
	@Test
	public void mockUpgradeLevels()throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		UserDao mockUserDao = mock(UserDao.class);
		when(mockUserDao.getAll()).thenReturn(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		userServiceImpl.upgradeLevels();
		
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao).update(users.get(1));
		assertThat(users.get(1).getLevel(),is(Level.SILVER));
		verify(mockUserDao).update(users.get(3));
		assertThat(users.get(3).getLevel(),is(Level.GOLD));
		
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	static class MockUserDao implements UserDao{
		
		private List<User> users;
		private List<User> updated = new ArrayList();
		
		private MockUserDao(List<User> users){
			this.users = users;
		}
		
		public List<User> getUpdated(){
			return this.updated;
		}
		
		public List<User> getAll(){
			return this.users;
		}
		
		public void update(User user){
			updated.add(user);
		}
		
		public void add(User user){ throw new UnsupportedOperationException();}
		public void deleteAll(){ throw new UnsupportedOperationException();}
		public User get(String id){ throw new UnsupportedOperationException();}
		public int getCount(){ throw new UnsupportedOperationException();}
		
		
	}
	
	static class TestUserService extends UserServiceImpl {
		
		private String id;
		
		private TestUserService(String id){
			this.id = id;
		}
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
	
	
	
}

</div>
<div id="i9" style="display: none">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
}


</div>

<div id="i10" style="display: none">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</div>

<div id="i11" style="display: none">
package toby;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionHandler implements InvocationHandler{
	
	private Object target; //부가기능을 제공할 타깃 오브젝트
	private PlatformTransactionManager transactionManager; //트랜잭션 기능을 제공하는 데 필요한 트랜잭션 매니저
	private String pattern; //트랜잭션을 적용할 메소드 이름 패턴
	
	public void setTarget(Object target){
		this.target = target;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setPattern(String pattern){
		this.pattern = pattern;
	}
	
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable{
		
		if(method.getName().startsWith(pattern)){
			return invokeInTransaction(method, args);
		}else{
			return method.invoke(target, args);
		}
		
	}
	
	private Object invokeInTransaction(Method method, Object[] args)throws Throwable{
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			Object ret = method.invoke(target, args);
			this.transactionManager.commit(status);
			return ret;
		}catch(InvocationTargetException e){
			this.transactionManager.rollback(status);
			throw e.getTargetException();
		}
	}
	
}

</div>

<div id="i12" style="display: none">
package toby;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionAdvice implements MethodInterceptor{
	
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public Object invoke(MethodInvocation invocation)throws Throwable{
		TransactionStatus status = 
				this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			
			Object ret = invocation.proceed();
			this.transactionManager.commit(status);
			return ret;
			
		}catch(RuntimeException e){
			
			this.transactionManager.rollback(status);
			throw e;
		}
	}
	
}

</div>

<div id="j1" style="display: none">
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.junit.Test;
import org.springframework.aop.ClassFilter;
import org.springframework.aop.Pointcut;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.aop.support.NameMatchMethodPointcut;

public class DynamicProxyTest {
	
	@Test
	public void simpleProxy(){
		Hello proxiedHello = (Hello)Proxy.newProxyInstance(getClass().getClassLoader(),
				new Class[]{Hello.class},
				new UppercaseHandler(new HelloTarget()));
	}
	
	@Test
	public void proxyFactoryBean(){
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(new HelloTarget());
		pfBean.addAdvice(new UppercaseAdvice());
		
		Hello proxiedHello = (Hello)pfBean.getObject();
		assertThat(proxiedHello.sayHello("Toby"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		
	}
	
	@Test
	public void pointcutAdvisor(){
		
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(new HelloTarget());
		
		NameMatchMethodPointcut pointcut = new NameMatchMethodPointcut();//�޼ҵ� �̸��� ���ؼ� ����� �����ϴ� �˰?���� �����ϴ� ����Ʈ�� ��
		pointcut.setMappedName("sayH*");// 이름 비교조건설정, sayH로 시작하는 모든 메소드 선택
		
		pfBean.addAdvisor(new DefaultPointcutAdvisor(pointcut, new UppercaseAdvice()));
		//포인트컷과 어드바이스를 ADVISOR로 묶어서 한번에 추가
		Hello proxiedHello = (Hello)pfBean.getObject();
		
		assertThat(proxiedHello.sayHello("tOBY"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		assertThat(proxiedHello.sayThankYou("Toby"),is("Thank YouToby"));
		//포인트컷이 적용안됨
		
		
	}
	-----------------------------------------------------------------------------------------------------
	@Test
	public void classNamePointcutAdvisor(){
		//포인트컷 준비 
		NameMatchMethodPointcut classMethodPointcut = new NameMatchMethodPointcut(){
			public ClassFilter getClassFilter(){
				return new ClassFilter(){
					public boolean matches(Class(?)) clazz){
						return clazz.getSimpleName().startsWith("HelloT"); //클래스 이름 HelloT인것만 선정
					}
				};
			}
		};
		
		classMethodPointcut.setMappedName("sayH*");//sayH로 시작하는 메소드 이름을 가진메소드만 선정
		
		//테스트
		checkAdviced(new HelloTarget(), classMethodPointcut, true);//적용클래스다
		
		class HelloWorld extends HelloTarget{};
		checkAdviced(new HelloWorld(),classMethodPointcut, false); //적용클래스가 아니다
		
		class HelloToby extends HelloTarget{};
		checkAdviced(new HelloToby(), classMethodPointcut, true);//적용클래스다
	}
	
	private void checkAdviced(Object target, Pointcut pointcut, boolean adviced){//boolean은 적용대상인가를 체크
		
		ProxyFactoryBean pfBean = new ProxyFactoryBean();
		pfBean.setTarget(target);
		pfBean.addAdvisor(new DefaultPointcutAdvisor(pointcut, new UppercaseAdvice()));
		Hello proxiedHello = (Hello)pfBean.getObject();
		
		if(adviced){
			assertThat(proxiedHello.sayHello("Toby"),is("HELLOTOBY"));
			assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
			assertThat(proxiedHello.sayThankYou("Toby"),is("Thank YouToby"));
		}else{
			assertThat(proxiedHello.sayHello("Toby"),is("HelloToby"));
			assertThat(proxiedHello.sayHi("Toby"),is("HiToby"));
			assertThat(proxiedHello.sayThankYou("Toby"),is("Thank YouToby"));
		}
	}
	-----------------------------------------------------------------------------------------------------
	
	
	static class UppercaseAdvice implements MethodInterceptor{
		public Object invoke(MethodInvocation invacation)throws Throwable{
			String ret = (String)invacation.proceed();
			return ret.toUpperCase();
		}
	}
	
	static interface Hello{
		String sayHello(String name);
		String sayHi(String name);
		String sayThankYou(String name);
	}
	
	static class HelloTarget implements Hello{
		public String sayHello(String name){
			return "Hello" + name;
		}
		public String sayHi(String name){
			return "Hi" + name;
		}
		public String sayThankYou(String name){
			return "Thank You" + name;
		}
	}
	

    static class UppercaseHandler implements InvocationHandler{
		
		Object target;
		
		public UppercaseHandler(Object target){
			this.target = target;
		}
		
		public Object invoke(Object proxy, Method method, Object[] args)throws Throwable{
			Object ret = (String)method.invoke(target, args);
			if(ret instanceof String){
				return ((String)ret).toUpperCase();
			}else{
				return ret;
			}
		}
	}

	
}


</div>

<div id="k1" style="display: none;color:#A7B32A">
package toby;

public class User {
	
	Level level;
	int recommend;
	int login;
	String id;
	String name;
	String password;
	String email;
	
	public User(String id, String name, String password, Level level,
			int login, int recommend, String email){
		this.level = level;
		this.login = login;
		this.recommend = recommend;
		this.id = id;
		this.name= name;
		this.password = password;
		this.email = email;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
		if(nextLevel == null){
			throw new IllegalStateException(this.level +"ì ìê·¸ë ì´ë ë¶ê°ë¥");
		}else{
			this.level = nextLevel;
		}
	}
	
	public User(){}
	
	public Level getLevel() {
		return level;
	}

	public void setLevel(Level level) {
		this.level = level;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLogin() {
		return login;
	}

	public void setLogin(int login) {
		this.login = login;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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
<div id="k2" style="display: none">
package toby;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

private JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	
	public void add(final User user){
		
		this.jdbcTemplate.update("insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update("update dao set name = ?, password = ? ,level = ?,login = ?,"
				+ "recommend = ?, email = ? where id = ? ", user.getName(), user.getPassword(),
				user.getLevel().intValue(),user.getLogin(), user.getRecommend(),user.getEmail(),
				user.getId());
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			user.setEmail(rs.getString("email"));
			return user;
		}
	};
	
}

</div>

<div id="k3" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.UserServiceImpl")
		(property name="userDao" ref="userDao"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="transactionAdvice" class="toby.TransactionAdvice")
		(property name="transactionManager" ref="transactionManager"/)
	(/bean)
	-------------------------------------------------------------------------------------------------
	(!-- 포인트컷 등록 --)
	(bean id="transactionPointcut" class="org.springframework.aop.support.NameMatchMethodPointcut")
		(property name="mappedClassName" value="*ServiceImpl"/) (!-- 클래스이름 패턴 --)
		(property name="mappedName" value="upgrade*"/) (!-- 메소드 이름 패턴 --)
		
	(/bean)
	
	(bean id="transactionAdvisor" class="org.springframework.aop.support.DefaultPointcutAdvisor")
		(property name="advice" ref="transactionAdvice"/)
		(property name="pointcut" ref="transactionPointcut"/)
	(/bean)
	
	(!-- 어드바이저를 이용하는 자동 프록시 생성기 등록 --)
	(bean class="org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator"/)
	
	(bean id="testUserService" class="toby.UserServiceTest$TestUserServiceImpl" parent="userService"/)
	 (!-- 스태틱 멤버 클래스는 $로 지정 --)(!-- 프로퍼티 정의를 포한해서 userService 빈의 설정을 상속받느다 --)

	-------------------------------------------------------------------------------------------------
(/beans)
</div>
<div id="k4" style="display: none">
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
	
	@Autowired
	private UserDao dao;
	
	@Autowired
	DataSource dataSource;
	
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
		dao = new UserDaoJdbc();
		
		DataSource dataSource = new SingleConnectionDataSource("jdbc:mysql://localhost/toby","root","1111",true);
		((UserDaoJdbc) dao).setDataSource(dataSource);
		
		this.dao = this.context.getBean("userDao", UserDao.class);
		
		this.user3 = new User("x","x","x",Level.BASIC, 1, 0 ,"x");
		this.user1 = new User("v","v","v",Level.SILVER,55,10,"v");
		this.user2 = new User("z","z","z",Level.GOLD,100,40,"z");
	}
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		dao.add(user2);
		
		assertThat(dao.getCount(),is(2));
		
		User userget1 = dao.get(user1.getId());
		checkSameUser(userget1,user1);
		//assertThat(userget1.getName(), is(user1.getName()));
		//assertThat(userget1.getPassword(),is(user1.getPassword()));
		
		User userget2 = dao.get(user2.getId());
		checkSameUser(userget2,user2);
		//assertThat(userget2.getName(), is(user2.getName()));
		//assertThat(userget2.getPassword(),is(user2.getPassword()));
		
		
		
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
	@Test
	public void update(){
		
		dao.deleteAll();
		
		dao.add(user1);
		dao.add(user2);
		
		user1.setName("jh");
		user1.setPassword("E");
		user1.setLevel(Level.GOLD);
		user1.setLogin(1000);
		user1.setRecommend(999);
		user1.setEmail("rr");
		dao.update(user1);
		
		User user1update = dao.get(user1.getId());
		checkSameUser(user1, user1update);
		User user2same = dao.get(user2.getId());
		checkSameUser(user2, user2same);
	}
	
	private void checkSameUser(User user1, User user2){
		assertThat(user1.getId(), is(user2.getId()));
		assertThat(user1.getName(), is(user2.getName()));
		assertThat(user1.getPassword(), is(user2.getPassword()));
		assertThat(user1.getLevel(),is(user2.getLevel()));
		assertThat(user1.getLogin(),is(user2.getLogin()));
		assertThat(user1.getRecommend(),is(user2.getRecommend()));
		
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}

</div>



<div id="k5" style="display: none">
package toby;

public enum Level {
	GOLD(3,null),SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return next;
	}
	public static Level valueOf(int value){
		switch(value){
		case 1: return BASIC;
		case 2: return SILVER;
		case 3: return GOLD;
		default: throw new AssertionError("unknown"+value);
		}
	}
	
}


</div>
<div id="k6" style="display: none">
package toby;

import java.util.List;

public interface UserDao {
	
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	int getCount();
	public void update(User user1);
	
}
</div>

<div id="k7" style="display: none">
package toby;

public interface UserService {
	
	void add(User user);
	void upgradeLevels();
}
</div>

<div id="k8" style="display: none" >
package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static toby.UserServiceImpl.MIN_LOGCOUNT_FOR_SILVER;
import static toby.UserServiceImpl.MIN_RECCOMEND_FOR_GOLD;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="/toby/applicationContext.xml")
public class UserServiceTest {
	
	@Autowired ApplicationContext context;
	
	@Autowired
	UserServiceImpl userServiceImpl;
	
	@Autowired
	UserService userService;
	----------------------------------------------------------
	@Autowired
	UserService testUserService;
	----------------------------------------------------------
	@Autowired DataSource dataSource;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	@Autowired
	UserDao userDao;
	
	User user;
	
	List<User> users;
	
	@Before
	public void setUp(){
		users = Arrays.asList(new User("aa","aa","p1",Level.BASIC, MIN_LOGCOUNT_FOR_SILVER-1, 0,"aa"),
							  new User("bb","bb","p2",Level.BASIC,MIN_LOGCOUNT_FOR_SILVER,0,"bb"),
							  new User("cc","cc","p3",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,29,"cc"),
							  new User("dd","dd","p4",Level.SILVER,MIN_RECCOMEND_FOR_GOLD,30,"dd"),
							  new User("ee","ee","p5",Level.GOLD,100,Integer.MAX_VALUE,"ee")
							  );
	}
	
	@Test
	public void bean(){
		assertThat(this.userService, is(notNullValue()));
	}
	
	@Test
	public void upgradeLevels() throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		MockUserDao mockUserDao = new MockUserDao(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		
		userServiceImpl.upgradeLevels();
		
		List<User> updated = mockUserDao.getUpdated();
		assertThat(updated.size(),is(2));
		checkUserAndLevel(updated.get(0),"bb",Level.SILVER);
		checkUserAndLevel(updated.get(1),"dd",Level.GOLD);
		
		
	}
	
	private void checkUserAndLevel(User updated, String expectedId, Level expectedLevel){
		assertThat(updated.getId(), is(expectedId));
		assertThat(updated.getLevel(), is(expectedLevel));
	}
	
	@Test
	public void add(){
		
		userDao.deleteAll();
		
		User userWithLevel = users.get(4);
		User userWithoutLevel = users.get(0);
		
		userService.add(userWithLevel);
		userService.add(userWithoutLevel);
		
		User userWithLevelRead = userDao.get(userWithLevel.getId());
		User userWithoutLevelRead = userDao.get(userWithoutLevel.getId());
		
		assertThat(userWithLevelRead.getLevel(), is(userWithLevel.getLevel()));
		assertThat(userWithoutLevelRead.getLevel(),is(Level.BASIC));
	}
	
	@Test()
	public void upgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() == null)continue;
			user.setLevel(level);
			user.upgradeLevel();
			assertThat(user.getLevel(), is(level.nextLevel()));
			
		}
	}
	
	@Test(expected=NullPointerException.class)
	public void cannotUpgradeLevel(){
		Level[] levels = Level.values();
		for(Level level : levels){
			if(level.nextLevel() != null)continue;
			user.setLevel(level);
			user.upgradeLevel();
		}
	}
	
	@Test
	public void upgradeAllofNothing() throws Exception{
		
		userDao.deleteAll();
		
		for(User user: users)userDao.add(user);
		----------------------------------------------------------
		try{
			this.testUserService.upgradeLevels();
			fail("TestUserServiceException expected");
		}catch(TestUserServiceException e){
		----------------------------------------------------------	
		}
		checkLevelUpgraded(users.get(1),false);
	}
	
	@Test
	public void mockUpgradeLevels()throws Exception{
		
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		
		UserDao mockUserDao = mock(UserDao.class);
		when(mockUserDao.getAll()).thenReturn(this.users);
		userServiceImpl.setUserDao(mockUserDao);
		
		userServiceImpl.upgradeLevels();
		
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao, times(2)).update(any(User.class));
		verify(mockUserDao).update(users.get(1));
		assertThat(users.get(1).getLevel(),is(Level.SILVER));
		verify(mockUserDao).update(users.get(3));
		assertThat(users.get(3).getLevel(),is(Level.GOLD));
		
	}
	
	private void checkLevelUpgraded(User user, boolean upgraded){
		User userUpdate = userDao.get(user.getId());
		if(upgraded){
			assertThat(userUpdate.getLevel(), is(user.getLevel().nextLevel()));
		}else{
			assertThat(userUpdate.getLevel(), is(user.getLevel()));
		}
	}
	
	private void checkLevel(User user, Level expectedLevel){
		User userUpdate = userDao.get(user.getId());
		assertThat(userUpdate.getLevel(),is(expectedLevel));
	}
	
	static class MockUserDao implements UserDao{
		
		private List<User> users;
		private List<User> updated = new ArrayList();
		
		private MockUserDao(List<User> users){
			this.users = users;
		}
		
		public List<User> getUpdated(){
			return this.updated;
		}
		
		public List<User> getAll(){
			return this.users;
		}
		
		public void update(User user){
			updated.add(user);
		}
		
		public void add(User user){ throw new UnsupportedOperationException();}
		public void deleteAll(){ throw new UnsupportedOperationException();}
		public User get(String id){ throw new UnsupportedOperationException();}
		public int getCount(){ throw new UnsupportedOperationException();}
		
		
	}
	
	static class TestUserServiceImpl extends UserServiceImpl {
		
		private String id ="p3";
		
		protected void upgradeLevel(User user){
			if(user.getId().equals(this.id))throw new TestUserServiceException();
			super.upgradeLevel(user);
		}
	}
	
	static class TestUserServiceException extends RuntimeException{
		
	}
	
	
	
}

</div>
<div id="k9" style="display: none">
package toby;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceImpl implements UserService{
	
	UserDao userDao;
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	
	public void upgradeLevels(){
		
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
		
	}
	
	/*private void upgradeLevelsInternal(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){
				upgradeLevel(user);
			}
		}
	}*/
	
	protected void upgradeLevel(User user){
		
		user.upgradeLevel();
		userDao.update(user);
		//sendUpgradeEMail(user);
		
	}
	public static final int MIN_LOGCOUNT_FOR_SILVER = 50;
	public static final int MIN_RECCOMEND_FOR_GOLD = 30;
	
	
	private boolean canUpgradeLevel(User user){
		
		Level currentLevel = user.getLevel();
		
		switch(currentLevel){
			case BASIC : return (user.getLogin() >= MIN_LOGCOUNT_FOR_SILVER);
			case SILVER: return (user.getRecommend() >= MIN_RECCOMEND_FOR_GOLD);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknow" + currentLevel);
		
		}
	}
	
	public void add(User user){
		if(user.getLevel() == null) user.setLevel(Level.BASIC);
		userDao.add(user);
	}
}


</div>

<div id="k10" style="display: none">
package toby;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class UserServiceTx implements UserService{
	
	UserService userService;
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public void add(User user){
		userService.add(user);
	}
	
	public void upgradeLevels(){
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			userService.upgradeLevels();
			this.transactionManager.commit(status);
		}catch(RuntimeException e){
			this.transactionManager.rollback(status);
			throw e;
		}
		
		userService.upgradeLevels();
	}
	
}

</div>

<div id="k11" style="display: none">
package toby;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionHandler implements InvocationHandler{
	
	private Object target; //부가기능을 제공할 타깃 오브젝트
	private PlatformTransactionManager transactionManager; //트랜잭션 기능을 제공하는 데 필요한 트랜잭션 매니저
	private String pattern; //트랜잭션을 적용할 메소드 이름 패턴
	
	public void setTarget(Object target){
		this.target = target;
	}
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public void setPattern(String pattern){
		this.pattern = pattern;
	}
	
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable{
		
		if(method.getName().startsWith(pattern)){
			return invokeInTransaction(method, args);
		}else{
			return method.invoke(target, args);
		}
		
	}
	
	private Object invokeInTransaction(Method method, Object[] args)throws Throwable{
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			Object ret = method.invoke(target, args);
			this.transactionManager.commit(status);
			return ret;
		}catch(InvocationTargetException e){
			this.transactionManager.rollback(status);
			throw e.getTargetException();
		}
	}
	
}

</div>

<div id="k12" style="display: none">
package toby;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TransactionAdvice implements MethodInterceptor{
	
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager = transactionManager;
	}
	
	public Object invoke(MethodInvocation invocation)throws Throwable{
		TransactionStatus status = 
				this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try{
			
			Object ret = invocation.proceed();
			this.transactionManager.commit(status);
			return ret;
			
		}catch(RuntimeException e){
			
			this.transactionManager.rollback(status);
			throw e;
		}
	}
	
}

</div>

<div id="k13" style="display: none">
package toby;

import org.springframework.aop.ClassFilter;
import org.springframework.aop.support.NameMatchMethodPointcut;
import org.springframework.util.PatternMatchUtils;

public class NameMatchClassMethodPointcut extends NameMatchMethodPointcut{
	
	public void setMappedClassName(String mappedClassName){
		this.setClassFilter(new SimpleClassFilter(mappedClassName)); //모든 클래스를 다 허용하던 디폴트 클래스 필터를 프로터티 받은 클래스이름을 이용해서 필터를 만들어 덮어씌운다
	}
	
	static class SimpleClassFilter implements ClassFilter{
		
		String mappedName;
		
		private SimpleClassFilter(String mappedName){
			this.mappedName = mappedName;
		}
		
		public boolean matches(Class(?) clazz){
			return PatternMatchUtils.simpleMatch(mappedName, clazz.getSimpleName());//와일드카드(*)가 들어간 문자열 비교를 지원하는 유틸 메소드
		}
	}
	
}

</div>

<div id="l1" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	----------------------------------------------------------------------------
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
			http://www.springframework.org/schema/aop
			http://www.springframework.org/schema/aop/spring-aop-3.0.xsd")
			
	(aop:config) (!-- aop설정을 담는 부모태그 --)
		(aop:pointcut expression="execution(* *..*ServiceImpl.upgrade*(..))" id="transactionPointcut"/)
		(!-- expression의 표현식으로 프로퍼티로 가진 aspectJExpressionPointcut을 빈으로 등록 --)
		(aop:advisor advice-ref="transactionAdvice" pointcut-ref="transactionPointcut"/)
		(!-- advice와 pointcut의 ref를 프로퍼티로 갖는 DefaultBeanFactoryPointcutAdvisor --)
	(/aop:config)
	----------------------------------------------------------------------------
	(bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource")
		(property name="driverClass" value ="com.mysql.jdbc.Driver"/)
		(property name="url" value = "jdbc:mysql://localhost/toby"/)
		(property name="username" value="root"/)
		(property name="password" value="1111"/)
	(/bean)
	
	(bean id ="userService" class="toby.UserServiceImpl")
		(property name="userDao" ref="userDao"/)
	(/bean)
	
	(bean id="userServiceImpl" class="toby.UserServiceImpl")
			(property name="userDao" ref="userDao"/)
	(/bean)
	
	
	(bean id = "transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
	(/bean)
	
	(bean id="transactionAdvice" class="toby.TransactionAdvice")
		(property name="transactionManager" ref="transactionManager"/)
	(/bean)
	
	(!-- 포인트컷 등록 --)
	(bean id="transactionPointcut" class="org.springframework.aop.support.NameMatchMethodPointcut")
		(property name="mappedClassName" value="*ServiceImpl"/) (!-- 클래스이름 패턴 --)
		(property name="mappedName" value="upgrade*"/) (!-- 메소드 이름 패턴 --)
		
	(/bean)
	
	(bean id="transactionAdvisor" class="org.springframework.aop.support.DefaultPointcutAdvisor")
		(property name="advice" ref="transactionAdvice"/)
		(property name="pointcut" ref="transactionPointcut"/)
	(/bean)
	
	(!-- 어드바이저를 이용하는 자동 프록시 생성기 등록 --)
	(bean class="org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator"/)
	
	(bean id="testUserService" class="toby.UserServiceTest$TestUserServiceImpl" parent="userService"/)
	 (!-- 스태틱 멤버 클래스는 $로 지정 --)(!-- 프로퍼티 정의를 포한해서 userService 빈의 설정을 상속받느다 --)

	
(/beans)
</div>

</body>
</html>