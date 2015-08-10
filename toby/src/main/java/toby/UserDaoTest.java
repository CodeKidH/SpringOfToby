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
	
	@Autowired
	UserDao dao;
	private User user1;
	private User user2;
	private User user3;
	
	@Before
	public void setUp(){
		System.out.println(this.context);
		System.out.println(this);
		
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
