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

<h1 style="color:">Chapter6 - Core Skill of Spring</h1>

<table border="1" width="100%">
	<colgroup>
		<col width="600"/>
		<col width="600"/>
	</colgroup>
	<tr>
		<td valign="top" width="30%">
			<h2 style="color:#1E90FF">1.separate sql from dao - add()</h2>
			<h3 style="color:"># changed : UserDaoJdbc, applicationContext.xml</h3>
				<input type="button" onclick="makeGreen('a1')" value="User">
				<input type="button" onclick="makeGreen('a2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('a3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('a4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('a5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('a6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('a7')" value="UserService">
				<input type="button" onclick="makeGreen('a8')" value="UserServiceTest">
			<h2 style="color:#1E90FF">2.separate sql from dao - Use a Map</h2>
			<h3 style="color:"># changed : UserDaoJdbc, applicationContext.xml</h3>
				<input type="button" onclick="makeGreen('b1')" value="User">
				<input type="button" onclick="makeGreen('b2')" value="UserDaoJdbc">
				<input type="button" onclick="makeGreen('b3')" value="applicationContext.xml">
				<input type="button" onclick="makeGreen('b4')" value="UserDaoTest">
				<input type="button" onclick="makeGreen('b5')" value="Level(enum)">
				<input type="button" onclick="makeGreen('b6')" value="UserDao(I)">
				<input type="button" onclick="makeGreen('b7')" value="UserService">
				<input type="button" onclick="makeGreen('b8')" value="UserServiceTest">
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
	------------------------------------------------------------------
	private String sqlAdd;
	
	public void setSqlAdd(String sqlAdd){
		this.sqlAdd = sqlAdd;
	}
	------------------------------------------------------------------

	
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	public void add(final User user){
		------------------------------------------------------------------
		this.jdbcTemplate.update(
				this.sqlAdd
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
		------------------------------------------------------------------
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
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
			http://www.springframework.org/schema/aop
			http://www.springframework.org/schema/aop/spring-aop-3.0.xsd")
			

	
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
	---------------------------------------------------------------------
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
		(property name="sqlAdd" value = "insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"/)
	(/bean)
	---------------------------------------------------------------------
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
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoJdbc implements UserDao{

	private JdbcTemplate jdbcTemplate;
	---------------------------------------------------------------
	private Map<String, String> sqlMap;
	
	public void setSqlMap(Map<String, String>sqlMap){
		this.sqlMap = sqlMap;
	}

	---------------------------------------------------------------
	@Autowired
	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		
	}
	
	public void add(final User user){
		---------------------------------------------------------------
		this.jdbcTemplate.update(
				this.sqlMap.get("add")
				,user.getId(),user.getName(),user.getPassword(), user.getLevel().intValue(),
				user.getLogin(),user.getRecommend(),user.getEmail());
	}
	---------------------------------------------------------------
	public User get(String id){
		return this.jdbcTemplate.queryForObject(this.sqlMap.get("get"),
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update(this.sqlMap.get("deleteAll"));
				
	}	
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt(this.sqlMap.get("getCount"));
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query(this.sqlMap.get("getAll"), 
					this.userMapper
				);
				
	}
	
	public void update(User user){
		this.jdbcTemplate.update(this.sqlMap.get("update"), user.getName(), user.getPassword(),
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
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
			http://www.springframework.org/schema/aop
			http://www.springframework.org/schema/aop/spring-aop-3.0.xsd")
			

	
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
	----------------------------------------------------------------------------------------------------
	(bean id="userDao" class="toby.UserDaoJdbc")
		(property name="dataSource" ref="dataSource"/)
		(property name="sqlMap")
			(map)
				(entry key="add" value="insert into dao(id,name,password,level,login,recommend,email)value(?,?,?,?,?,?,?)"/)
				(entry key="get" value="select * from dao where id = ?"/)
				(entry key="getAll" value="select * from dao order by id"/)
				(entry key="deleteAll" value="delete from dao"/)
				(entry key="getCount" value="select count(*) from dao"/)
				(entry key="update" value="update dao set name = ?, password = ? ,level = ?,login = ?,recommend = ?, email = ? where id = ?"/)
			(/map)
		(/property) 
	(/bean)
	----------------------------------------------------------------------------------------------------
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

<div id="b7" style="display: none" >
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
<div id="b8" style="display: none">
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


</body>
</html>