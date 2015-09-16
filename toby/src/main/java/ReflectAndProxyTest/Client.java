package ReflectAndProxyTest;
import java.lang.reflect.Proxy;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class Client {
	
	
	@Test
	public void simpleProxy(){
		
		Hello hello = new HelloTarget();
		assertThat(hello.sayHello("Toby"),is("HelloToby"));
		assertThat(hello.sayHi("Toby"),is("HiToby"));
		assertThat(hello.sayThankYou("Toby"),is("Thank youToby"));
		
	}
	
	@Test
	public void helloUppercase(){
		
		Hello proxiedHello = (Hello)Proxy.newProxyInstance(getClass().getClassLoader(),
																new Class[]{Hello.class}
												, new UppercaseHandler(new HelloTarget()));
		
		/*Hello proxiedHello = new HelloUppercase(new HelloTarget());
		assertThat(proxiedHello.sayHello("Toby"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		assertThat(proxiedHello.sayThankYou("Toby"),is("THANK YOUTOBY"));*/
		
	}
	
}
