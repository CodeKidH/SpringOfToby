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
