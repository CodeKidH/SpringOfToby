<%@include file="include.jsp"%>
<html>
<body style="background:#3E5968">
<h1 style="color:#FCF9F9">Chapter5 - AOP</h1>

<h2 style="color:#FCF9F9">1.Reflection Test - How to use a Mehtod in Reflect API</h2>
<h3 style="color:#FCF9F9"># Dynamic Proxy Use a Reflection to Make a proxy</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[ReflectionTest]':'[ReflectionTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>ReflectionTest</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package ReflectTest;

import java.lang.reflect.Method;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class ReflectionTest {
	
	@Test
	public void invokedMethod() throws Exception{
		
		String name = "Spring";
		
		//length()
		assertThat(name.length(),is(6));
		
		Method lengthMethod = String.class.getMethod("length");
		assertThat((Integer)lengthMethod.invoke(name),is(6)); // int length = name.legnth();
		
		
		//charAt()
		assertThat(name.charAt(0), is('S'));
		
		Method charAtMethod = String.class.getMethod("charAt",int.class);
		assertThat((Character)charAtMethod.invoke(name, 0),is('S'));
		
	}
}

</font>
</pre>
</div>


<h2 style="color:#FCF9F9">2.Proxy Class- Just Use a Proxy</h2>
<h3 style="color:#FCF9F9">Proxy can control target</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Hello]':'[Hello]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Hello</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package ReflectAndProxyTest;

public interface Hello {
	
	String sayHello(String name);
	String sayHi(String name);
	String sayThankYou(String name);
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[HelloTarget]':'[HelloTarget]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>HelloTarget</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package ReflectAndProxyTest;

public class HelloTarget implements Hello{
	
	public String sayHello(String name){
		return "Hello" + name;
	}
	
	public String sayHi(String name){
		return "Hi" + name;
	}
	
	public String sayThankYou(String name){
		return "Thank you" + name;
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Client]':'[Client]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Client</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package ReflectAndProxyTest;
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
		
		Hello proxiedHello = new HelloUppercase(new HelloTarget());
		assertThat(proxiedHello.sayHello("Toby"),is("HELLOTOBY"));
		assertThat(proxiedHello.sayHi("Toby"),is("HITOBY"));
		assertThat(proxiedHello.sayThankYou("Toby"),is("THANK YOUTOBY"));
		
	}
	
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[HelloUppercase]':'[HelloUppercase]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>HelloUppercase</a><div style="DISPLAY: none">package toby;
<h3 style="color:#FCF9F9">#Proxy</h3>
<pre style="color:#A7B32A">
<font size="4">
package ReflectAndProxyTest;

public class HelloUppercase implements Hello{
	
	Hello hello;
	
	public HelloUppercase(Hello hello){
		this.hello = hello;
	}
	
	public String sayHello(String name){
		return hello.sayHello(name).toUpperCase();
	}
	
	public String sayHi(String name){
		return hello.sayHi(name).toUpperCase();
	}
	
	public String sayThankYou(String name){
		return hello.sayThankYou(name).toUpperCase();
	}
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">3.Proxy Class- Dynamic Proxy</h2>
<h3 style="color:#FCF9F9"></h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Hello]':'[Hello]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Hello</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package ReflectAndProxyTest;

public interface Hello {
	
	String sayHello(String name);
	String sayHi(String name);
	String sayThankYou(String name);
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[HelloTarget]':'[HelloTarget]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>HelloTarget</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
package ReflectAndProxyTest;

public class HelloTarget implements Hello{
	
	public String sayHello(String name){
		return "Hello" + name;
	}
	
	public String sayHi(String name){
		return "Hi" + name;
	}
	
	public String sayThankYou(String name){
		return "Thank you" + name;
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Client]':'[Client]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Client</a><div style="DISPLAY: none">package toby;
<pre style="color:#A7B32A">
<font size="4">
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
	================================================================================
	@Test
	public void helloUppercase(){
		
		Hello proxiedHello = (Hello)Proxy.newProxyInstance(getClass().getClassLoader(),
																new Class[]{Hello.class}
												, new UppercaseHandler(new HelloTarget()));
	}
	================================================================================
	Create Dynamic Proxy
	================================================================================
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[HelloUppercase]':'[HelloUppercase]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>HelloUppercase</a><div style="DISPLAY: none">package toby;
<h3 style="color:#FCF9F9">#Dynamic proxy use this</h3>
<pre style="color:#A7B32A">
<font size="4">
package ReflectAndProxyTest;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class UppercaseHandler implements InvocationHandler{
	
	Hello target;
	
	public UppercaseHandler(Hello target){
		this.target = target;
	}
	
	public Object invoke(Object proxy, Method method, Object[] args)throws Throwable{
		String ret = (String)method.invoke(target, args);
		return ret.toUpperCase();
	}
}

</font>
</pre>
</div>

<h2 style="color:#FCF9F9">4.Factory Bean for Dynamic Proxy</h2>
<h3 style="color:#FCF9F9">Dynamic proxy object do not apply to Spring bean so We use Factory bean</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[MessageFactoryBean]':'[MessageFactoryBean]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>MessageFactoryBean</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package test;
it is judged
import org.springframework.beans.factory.FactoryBean;

public class MessageFactoryBean implements FactoryBean<Message>{
	
	String text;
	
	public void setText(String text){
		this.text = text;
	}
	
	public Class(? extends Message)getObjectType(){ ----->> it notify us object type
		return Message.class;
	}
	
	public boolean isSingleton(){  ----->> it is judged whether Singleton or not
		return false;
	}

	public Message getObject() throws Exception { ----->> create bean object and return
		return Message.newMessage(this.text);
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Message]':'[Message]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Message</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package test;

public class Message {
	
	String text;
	
	private Message(String text){
		this.text = text;
	}
	
	public String getText(){
		return text;
	}
	
	public static Message newMessage(String text){
		return new Message(text);
	}
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[FactoryBeanTest]':'[FactoryBeanTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>FactoryBeanTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package test;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class FactoryBeanTest {
	
	@Autowired
	ApplicationContext context;
	
	@Test
	public void getMessageFromFactoryBean(){
		Object message = context.getBean("message");
		assertThat((Message)message, is(Message.class));
		assertThat(((Message)message).getText(),is("Factory Bean"));
		
	}
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[FactoryBeanTest-context.xml]':'[FactoryBeanTest-context.xml]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>FactoryBeanTest-context.xml</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	
	(bean id="message" class="test.MessageFactoryBean")
		(property name="text" value="Factory Bean"/)
	(/bean)
	
(/beans)

</font>
</pre>
</div>

</body>
</html>

