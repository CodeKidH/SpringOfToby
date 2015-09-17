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


<table border="1" width="100%">
	<colgroup>
		<col width="600"/>
		<col width="600"/>
	</colgroup>
	<tr>
		<td valign="top" width="30%">
			<h2 style="color:">1.IOC Container and DI</h2>
			<H3 style="color:">#IOC Container is a contextApplication</H3>
			<H3 style="color:">#We use a meta info that made of java and IOC use it</H3>
				<input type="button" onclick="makeGreen('a1')" value="Hello">
				<input type="button" onclick="makeGreen('a2')" value="Printer(I)">
				<input type="button" onclick="makeGreen('a3')" value="StringPrinter">
				<input type="button" onclick="makeGreen('a4')" value="ConsolePrinter">
				<input type="button" onclick="makeGreen('a5')" value="Main">
			<H2 style="color:">2.Sort of IOC Container - GenericApplicatioinContext</H2>
			<H3 style="color:">#changed - Main, xml</H3>
				<input type="button" onclick="makeGreen('b1')" value="Hello">
				<input type="button" onclick="makeGreen('b2')" value="Printer(I)">
				<input type="button" onclick="makeGreen('b3')" value="StringPrinter">
				<input type="button" onclick="makeGreen('b4')" value="ConsolePrinter">
				<input type="button" onclick="makeGreen('b5')" value="Main">
				<input type="button" onclick="makeGreen('b6')" value="applicationContext.xml">
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
</body>
</html>