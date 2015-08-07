package toby;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;

import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class UserDaoTest {
	
	@Test
	public void addAndGet()throws SQLException, ClassNotFoundException{
		
		ApplicationContext context = new GenericXmlApplicationContext("toby/applicationContext.xml");
		UserDao dao = context.getBean("userDao",UserDao.class);
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		User user = new User();
		user.setId("q");
		user.setName("q");
		user.setPassword("q");
		
		dao.add(user);
		
		User user2 = dao.get(user.getId());
		
		assertThat(user2.getName(), is(user.getName()));
		assertThat(user2.getPassword(),is(user.getPassword()));
		
	}
	
	@Test
	public void count()throws SQLException, ClassNotFoundException{
		
		ApplicationContext context = new GenericXmlApplicationContext("toby/applicationContext.xml");
		UserDao dao = context.getBean("userDao",UserDao.class);
		
		User user3 = new User("x","x","x");
		User user1 = new User("v","v","v");
		User user2 = new User("z","z","z");
		
		dao.deleteAll();
		assertThat(dao.getCount(),is(0));
		
		dao.add(user1);
		assertThat(dao.getCount(),is(1));
		

		dao.add(user2);
		assertThat(dao.getCount(),is(2));
		

		dao.add(user3);
		assertThat(dao.getCount(),is(3));
	}
	
	public static void main(String[]args)throws ClassNotFoundException, SQLException {
		JUnitCore.main("toby.UserDaoTest");
	}
}
