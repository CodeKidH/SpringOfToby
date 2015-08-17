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
	
	
	public void add(final User user)throws ClassNotFoundException, SQLException{
		
		this.jdbcTemplate.update("insert into dao(id,name,password)value(?,?,?)",user.getId(),user.getName(),user.getPassword());
	}
	
	public User get(String id)throws  SQLException{
		return this.jdbcTemplate.queryForObject("select * from dao where id = ?",
					new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll() throws SQLException{
		this.jdbcTemplate.update("delete from dao");
				
	}	
	
	
	
	public int getCount() throws SQLException{
		return this.jdbcTemplate.queryForInt("select count(*) from dao");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from dao order by id", 
					this.userMapper
				);
				
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>() {
		public User mapRow(ResultSet rs, int rowNum)throws SQLException{
			User user = new User();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			return user;
		}
	};
	
	
	
}
