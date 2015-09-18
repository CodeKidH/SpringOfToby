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

<h1 style="color:">1.IOC Container and DI</h1>

<table border="1" width="100%">
	<colgroup>
		<col width="600"/>
		<col width="600"/>
	</colgroup>
	<tr>
		<td valign="top" width="30%">
			<h2 style="color:#1E90FF">1. Sort of IOC Container - Java</h2>
			<H3 style="color:">#IOC Container is a contextApplication</H3>
			<H3 style="color:">#We use a meta info that made of java and IOC use it</H3>
				<input type="button" onclick="makeGreen('a1')" value="Hello">
				<input type="button" onclick="makeGreen('a2')" value="Printer(I)">
				<input type="button" onclick="makeGreen('a3')" value="StringPrinter">
				<input type="button" onclick="makeGreen('a4')" value="ConsolePrinter">
				<input type="button" onclick="makeGreen('a5')" value="Main">
			<H2 style="color:#1E90FF">2. Sort of IOC Container - GenericApplicatioinContext, GenericXmlApplicationContext</H2>
			<H3 style="color:">#changed - Main, xml</H3>
				<input type="button" onclick="makeGreen('b1')" value="Hello">
				<input type="button" onclick="makeGreen('b2')" value="Printer(I)">
				<input type="button" onclick="makeGreen('b3')" value="StringPrinter">
				<input type="button" onclick="makeGreen('b4')" value="ConsolePrinter">
				<input type="button" onclick="makeGreen('b5')" value="Main">
				<input type="button" onclick="makeGreen('b6')" value="applicationContext.xml">
			<H2 style="color:#1E90FF">3. structure of tree of context</H2>
			<H3 style="color:">#changed - Main, parent.xml, child.xml</H3>
				<input type="button" onclick="makeGreen('c1')" value="Hello">
				<input type="button" onclick="makeGreen('c2')" value="Printer(I)">
				<input type="button" onclick="makeGreen('c3')" value="StringPrinter">
				<input type="button" onclick="makeGreen('c4')" value="ConsolePrinter">
				<input type="button" onclick="makeGreen('c5')" value="Main">
				<input type="button" onclick="makeGreen('c7')" value="childContext.xml">
				<input type="button" onclick="makeGreen('c6')" value="parentContext.xml">
			<H2 style="color:#1E90FF">4. Register root ApplicationContext</H2>
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

package chapter2;

public class Hello {
	
	String name;
	Printer printer;
	
	public String sayHello(){
		return "Hello" + name;
	}
	
	public void print(){
		this.printer.print(sayHello());
	}
	
	public void setName(String name){
		this.name = name;
	}
	
	public void setPrinter(Printer printer){
		this.printer = printer;
	}
}

</div>
<div id="a2" style="display: none">
package chapter2;

public interface Printer {
	
	void print(String message);
}

</div>

<div id="a3" style="display: none" >
package chapter2;

public class ConsolePrinter implements Printer{
	
	public void print(String message){
		System.out.println(message);
	}
}

</div>
<div id="a4" style="display: none">
package chapter2;

public class StringPrinter implements Printer{
	
	private StringBuffer buffer = new StringBuffer();
	
	public void print(String message){
		this.buffer.append(message);
	}
	
	public String toString(){
		return this.buffer.toString();
	}
}

</div>

<div id="a5" style="display: none">
package chapter2;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.RuntimeBeanReference;
import org.springframework.beans.factory.support.RootBeanDefinition;
import org.springframework.context.support.StaticApplicationContext;

public class Main {
	
	@Test
	public void registerBeanWithDependency(){
		
		StaticApplicationContext ac = new StaticApplicationContext();
		
		ac.registerBeanDefinition("printer", new RootBeanDefinition(StringPrinter.class));
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		helloDef.getPropertyValues().addPropertyValue("printer",new RuntimeBeanReference("printer"));
		
		ac.registerBeanDefinition("hello",helloDef);
		
		Hello hello = ac.getBean("hello",Hello.class);
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	
	@Test
	public void bean1(){
		StaticApplicationContext ac = new StaticApplicationContext();
		//ioc 컨테이너 생성, 생성과 동시에 컨테이너로 동작
		ac.registerSingleton("hello2",Hello.class);
		//Hello 클래스를 hello2라는 이름의 싱글콘 컨테이너로 등록
		Hello hello2 = ac.getBean("hello2",Hello.class);
		//ioc 컨테이너가 등록한 빈을 생성했는지 확인하기 위해 빈을 요청
		assertThat(hello2,is(notNullValue()));
		
		
		
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		//빈 클래스 Hello 지정, 빈 메타정보를 담은 오브젝트를 만든다.
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		//빈의 name 프로터티에 들어갈 값지정
		ac.registerBeanDefinition("hello3", helloDef);
		//앞에 설정한 메타정보를 hello3이라는 이름을 가진 빈으로해서 등록
		Hello hello3 = ac.getBean("hello3",Hello.class);
		
		assertThat(hello3.sayHello(),is("HelloSpring"));
		assertThat(hello3,is(not(hello2)));
		assertThat(ac.getBeanFactory().getBeanDefinitionCount(), is(2));
		
	}
	
	public static void main(String[]args){
		
	}
}

</div>

<div id="b1" style="display: none">

package chapter2;

public class Hello {
	
	String name;
	Printer printer;
	
	public String sayHello(){
		return "Hello" + name;
	}
	
	public void print(){
		this.printer.print(sayHello());
	}
	
	public void setName(String name){
		this.name = name;
	}
	
	public void setPrinter(Printer printer){
		this.printer = printer;
	}
}

</div>
<div id="b2" style="display: none">
package chapter2;

public interface Printer {
	
	void print(String message);
}

</div>

<div id="b3" style="display: none" >
package chapter2;

public class ConsolePrinter implements Printer{
	
	public void print(String message){
		System.out.println(message);
	}
}

</div>
<div id="b4" style="display: none">
package chapter2;

public class StringPrinter implements Printer{
	
	private StringBuffer buffer = new StringBuffer();
	
	public void print(String message){
		this.buffer.append(message);
	}
	
	public String toString(){
		return this.buffer.toString();
	}
}

</div>

<div id="b5" style="display: none">
package chapter2;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.RuntimeBeanReference;
import org.springframework.beans.factory.support.RootBeanDefinition;
import org.springframework.context.support.StaticApplicationContext;

public class Main {
	
	@Test
	public void registerBeanWithDependency(){
		
		StaticApplicationContext ac = new StaticApplicationContext();
		
		ac.registerBeanDefinition("printer", new RootBeanDefinition(StringPrinter.class));
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		helloDef.getPropertyValues().addPropertyValue("printer",new RuntimeBeanReference("printer"));
		
		ac.registerBeanDefinition("hello",helloDef);
		
		Hello hello = ac.getBean("hello",Hello.class);
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	
	@Test
	public void bean1(){
		StaticApplicationContext ac = new StaticApplicationContext();
		//ioc 컨테이너 생성, 생성과 동시에 컨테이너로 동작
		ac.registerSingleton("hello2",Hello.class);
		//Hello 클래스를 hello2라는 이름의 싱글콘 컨테이너로 등록
		Hello hello2 = ac.getBean("hello2",Hello.class);
		//ioc 컨테이너가 등록한 빈을 생성했는지 확인하기 위해 빈을 요청
		assertThat(hello2,is(notNullValue()));
		
		
		
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		//빈 클래스 Hello 지정, 빈 메타정보를 담은 오브젝트를 만든다.
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		//빈의 name 프로터티에 들어갈 값지정
		ac.registerBeanDefinition("hello3", helloDef);
		//앞에 설정한 메타정보를 hello3이라는 이름을 가진 빈으로해서 등록
		Hello hello3 = ac.getBean("hello3",Hello.class);
		
		assertThat(hello3.sayHello(),is("HelloSpring"));
		assertThat(hello3,is(not(hello2)));
		assertThat(ac.getBeanFactory().getBeanDefinitionCount(), is(2));
		
	}
	--------------------------------------------------------------------
	@Test
	public void genericApplicationContext(){
		GenericApplicationContext ac = new GenericApplicationContext();
		XmlBeanDefinitionReader reader = new XmlBeanDefinitionReader(ac);
		reader.loadBeanDefinitions("applicationContext.xml");
		//XmlBeanDefinitionReader는 기본적으로 클래스 패스로 정의된 리소스로부터 파일을 읽는다
		
		ac.refresh();
		//모든 메타정보가 등록이 완료됐으니 애플리케이션 컨테이너를 초기화하라는 명령이다.
		
		Hello hello = ac.getBean("hello",Hello.class);
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	
	|
	|
	|  Simple
	|
	v
	@Test
	public void GenericXmlApplicationContext(){
		GenericApplicationContext ac =new GenericXmlApplicationContext(
				"chapter2/applicationContext.xml"); //한줄로 생략
		
		Hello hello = ac.getBean("hello",Hello.class);
		
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	--------------------------------------------------------------------
	public static void main(String[]args){
		
	}
}

</div>
<div id="b6" style="display: none">
(?xml version="1.0" encoding="UTF-8"?)
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
	
	
	(bean id="hello" class="chapter2.Hello")
		(property name="name" value="Spring"/)
		(property name="printer" ref="printer"/)
	(/bean)		
	
	(bean id="printer" class="chapter2.StringPrinter"/)
	
			
(/beans)

</div>

<div id="c1" style="display: none">

package chapter2;

public class Hello {
	
	String name;
	Printer printer;
	
	public String sayHello(){
		return "Hello" + name;
	}
	
	public void print(){
		this.printer.print(sayHello());
	}
	
	public void setName(String name){
		this.name = name;
	}
	
	public void setPrinter(Printer printer){
		this.printer = printer;
	}
}

</div>
<div id="c2" style="display: none">
package chapter2;

public interface Printer {
	
	void print(String message);
}

</div>

<div id="c3" style="display: none" >
package chapter2;

public class ConsolePrinter implements Printer{
	
	public void print(String message){
		System.out.println(message);
	}
}

</div>
<div id="c4" style="display: none">
package chapter2;

public class StringPrinter implements Printer{
	
	private StringBuffer buffer = new StringBuffer();
	
	public void print(String message){
		this.buffer.append(message);
	}
	
	public String toString(){
		return this.buffer.toString();
	}
}

</div>

<div id="c5" style="display: none">
package chapter2;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.RuntimeBeanReference;
import org.springframework.beans.factory.support.RootBeanDefinition;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.context.support.StaticApplicationContext;
import org.springframework.util.ClassUtils;
import org.springframework.util.StringUtils;

//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = "/chapter2/applicationContext.xml")
public class Main {
	
	//@Autowired
	//ApplicationContext applicationContext;
	
	@Test
	public void registerBeanWithDependency(){
		
		StaticApplicationContext ac = new StaticApplicationContext();
		
		ac.registerBeanDefinition("printer", new RootBeanDefinition(StringPrinter.class));
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		helloDef.getPropertyValues().addPropertyValue("printer",new RuntimeBeanReference("printer"));
		
		ac.registerBeanDefinition("hello",helloDef);
		
		Hello hello = ac.getBean("hello",Hello.class);
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	
	@Test
	public void bean1(){
		StaticApplicationContext ac = new StaticApplicationContext();
		//ioc 컨테이너 생성, 생성과 동시에 컨테이너로 동작
		ac.registerSingleton("hello2",Hello.class);
		//Hello 클래스를 hello2라는 이름의 싱글콘 컨테이너로 등록
		Hello hello2 = ac.getBean("hello2",Hello.class);
		//ioc 컨테이너가 등록한 빈을 생성했는지 확인하기 위해 빈을 요청
		assertThat(hello2,is(notNullValue()));
		
		
		//===============================================================
		
		BeanDefinition helloDef = new RootBeanDefinition(Hello.class);
		//빈 클래스 Hello 지정, 빈 메타정보를 담은 오브젝트를 만든다.
		helloDef.getPropertyValues().addPropertyValue("name","Spring");
		//빈의 name 프로터티에 들어갈 값지정
		ac.registerBeanDefinition("hello3", helloDef);
		//앞에 설정한 메타정보를 hello3이라는 이름을 가진 빈으로해서 등록
		Hello hello3 = ac.getBean("hello3",Hello.class);
		
		assertThat(hello3.sayHello(),is("HelloSpring"));
		assertThat(hello3,is(not(hello2)));
		assertThat(ac.getBeanFactory().getBeanDefinitionCount(), is(2));
		
	}
	
	@Test
	public void genericApplicationContext(){
		GenericApplicationContext ac = new GenericApplicationContext();
		XmlBeanDefinitionReader reader = new XmlBeanDefinitionReader(ac);
		reader.loadBeanDefinitions("chapter2/applicationContext.xml");
		//XmlBeanDefinitionReader는 기본적으로 클래스 패스로 정의된 리소스로부터 파일을 읽는다
		
		ac.refresh();
		//모든 메타정보가 등록이 완료됐으니 애플리케이션 컨테이너를 초기화하라는 명령이다.
		
		Hello hello = ac.getBean("hello",Hello.class);
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	
	@Test
	public void GenericXmlApplicationContext(){
		GenericApplicationContext ac =new GenericXmlApplicationContext(
				"chapter2/applicationContext.xml");
		
		Hello hello = ac.getBean("hello",Hello.class);
		
		hello.print();
		
		assertThat(ac.getBean("printer").toString(), is("HelloSpring"));
	}
	-------------------------------------------------------------------------------------
	@Test
	public void treeOfContext(){
		String basePath = StringUtils.cleanPath(ClassUtils.classPackageAsResourcePath(getClass()))+"/";
		//현재 클래스의 패키지 정보를 클래스 패스형식으로 만들어서 미리저장
		
		ApplicationContext parent= new GenericXmlApplicationContext(basePath+"parentContext.xml");
		
		GenericApplicationContext child = new GenericApplicationContext(parent);
		
		XmlBeanDefinitionReader reader = new XmlBeanDefinitionReader(child);
		reader.loadBeanDefinitions(basePath + "childContext.xml");
		child.refresh(); // reader로 읽었으면 꼭 초기화 해야함
		
		Printer printer = child.getBean("printer",Printer.class); //childContext
		Printer printer1 = parent.getBean("printer",Printer.class);
		assertThat(printer, is(notNullValue()));
		----------------------------------------------------------------------
		
		Hello hello = child.getBean("hello",Hello.class);
		assertThat(hello, is(notNullValue()));
		
		hello.print();
		assertThat(printer.toString(), is("Hellochild"));
		-----------------------------------------------------------------------
		
		Hello hello1 = parent.getBean("hello",Hello.class);
		assertThat(hello1, is(notNullValue()));
		
		hello1.print();
		assertThat(printer1.toString(),is("HelloParent"));
		
		
		
	}
	-------------------------------------------------------------------------------------
	public static void main(String[]args){
		
		
	}
	
}


</div>
<div id="c6" style="display: none">
<?xml version="1.0" encoding="UTF-8"?>
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
			
			(bean id="printer" class="chapter2.StringPrinter"/)
			
			(bean id="hello" class="chapter2.Hello")
				(property name="name" value="Parent"/)
				(property name="printer" ref="printer"/)
			(/bean)
(/beans)
</div>

<div id="c7" style="display: none">
<?xml version="1.0" encoding="UTF-8"?>
(beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans-3.0.xsd")
			
			
			(bean id="hello" class="chapter2.Hello")
				(property name="name" value="Parent"/)
				(property name="printer" ref="printer"/)
			(/bean)
(/beans)
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