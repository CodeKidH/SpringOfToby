<%@include file="include.jsp"%>
<html>
<body style="background:#041303">
<h1 style="color:#FCF9F9">Chapter3_1 - Template</h1>


<h2 style="color:#FCF9F9">1.Simple Template/CallBack Pattern - Calculator and CalcSumTest</h2>
<h3 style="color:#FCF9F9"></h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[CalcSumTest]':'[CalcSumTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>CalcSumTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.io.IOException;

import org.junit.Test;

public class CalcSumTest {
	
	@Test
	public void sumOfNumbers() throws IOException{
		Calculator calculator = new Calculator();
		int sum = calculator.calcSum(getClass().getResource("numbers.txt").getPath());
		assertThat(sum,is(45));
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Calculator]':'[Calculator]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Calculator</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Calculator {
	public Integer calcSum(String filepath)throws IOException{
		BufferedReader br = new BufferedReader(new FileReader(filepath));
		Integer sum = 0;
		String line = null;
		while((line = br.readLine())!=null){
			sum += Integer.valueOf(line);
		}
		
		br.close();
		return sum;
	}
}

</font>
</pre>
</div>


<h2 style="color:#FCF9F9">2.Simple Template/CallBack Pattern - Apply function of try/catch/finally</h2>
<h3 style="color:#FCF9F9">#changed : Calculator</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[CalcSumTest]':'[CalcSumTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>CalcSumTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.io.IOException;

import org.junit.Test;

public class CalcSumTest {
	
	@Test
	public void sumOfNumbers() throws IOException{
		Calculator calculator = new Calculator();
		int sum = calculator.calcSum(getClass().getResource("numbers.txt").getPath());
		assertThat(sum,is(45));
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Calculator]':'[Calculator]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Calculator</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Calculator {
	public Integer calcSum(String filepath)throws IOException{
		
		BufferedReader br = null;
		
		try{
			br = new BufferedReader(new FileReader(filepath));
			Integer sum = 0;
			String line = null;
			while((line = br.readLine())!=null){
				sum += Integer.valueOf(line);
			}
			
			return sum;
			
		}catch(IOException e){
			System.out.println(e.getMessage());
			throw e;
		}finally{
			if(br != null){
				try{
					br.close();
				}catch(IOException e){
					System.out.println(e.getMessage());
				}
			}
		}
		
	}
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">3.Simple Template/CallBack Pattern - Apply function of callback and multiply</h2>
<h3 style="color:#FCF9F9">#changed : Calculator, CalcSumeTest, BufferedReaderCallback</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[CalcSumTest]':'[CalcSumTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>CalcSumTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.io.IOException;

import org.junit.Before;
import org.junit.Test;

public class CalcSumTest {
	=======================================================================
	Calculator calculator;
	String numFilepath;
	
	@Before
	public void setUp(){
		this.calculator = new Calculator();
		this.numFilepath = getClass().getResource("numbers.txt").getPath();
	}
	
	
	@Test
	public void sumOfNumbers() throws IOException{
		assertThat(calculator.calcSum(this.numFilepath),is(10));
	}
	
	@Test
	public void multipleOfNumbers()throws IOException{
		assertThat(calculator.calcMultiply(this.numFilepath),is(24));
	}
	
	=======================================================================
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Calculator]':'[Calculator]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Calculator</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Calculator {
	======================================================================================
	public Integer calcSum(String filepath)throws IOException{
		
		BufferedReaderCallback sumCallback = new BufferedReaderCallback(){
			public Integer doSomethingWithReader(BufferedReader br)throws IOException{
				Integer sum = 0;
				String line = null;
				while((line = br.readLine()) != null){
					sum += Integer.valueOf(line);
				}
				return sum;
			}
		};
		return fileReadTemplate(filepath, sumCallback);
		
	}
	
	
	public Integer calcMultiply(String filepath)throws IOException{
		BufferedReaderCallback multiplyCallback = new BufferedReaderCallback(){
			public Integer doSomethingWithReader(BufferedReader br)throws IOException{
				Integer multiply = 1;
				String line = null;
				while((line = br.readLine()) != null){
					multiply *= Integer.valueOf(line);
				}
				return multiply;
			}
		};
		return fileReadTemplate(filepath, multiplyCallback);
	}
	
	
	public Integer fileReadTemplate(String filepath, BufferedReaderCallback callback)throws IOException{
		
		BufferedReader br = null;
		
		try{
			br = new BufferedReader(new FileReader(filepath));
			int ret = callback.doSomethingWithReader(br);
			return ret;
			
		}catch(IOException e){
			System.out.println(e.getMessage());
			throw e;
		}finally{
			if(br != null){
				try{
					br.close();
				}catch(IOException e){
					System.out.println(e.getMessage());
				}
			}
		}
		
	}
}
======================================================================================

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[BufferedReaderCallback]':'[BufferedReaderCallback]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>BufferedReaderCallback</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import java.io.BufferedReader;
import java.io.IOException;

public interface BufferedReaderCallback {
	Integer doSomethingWithReader(BufferedReader br) throws IOException;
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">4.Simple Template/CallBack Pattern - Make a Template of ReadLine and Improve a Calculator</h2>
<h3 style="color:#FCF9F9">#changed : Calculator, BufferedReaderCallback, LineCallback</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[CalcSumTest]':'[CalcSumTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>CalcSumTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.io.IOException;

import org.junit.Before;
import org.junit.Test;

public class CalcSumTest {
	Calculator calculator;
	String numFilepath;
	
	@Before
	public void setUp(){
		this.calculator = new Calculator();
		this.numFilepath = getClass().getResource("numbers.txt").getPath();
	}
	
	
	@Test
	public void sumOfNumbers() throws IOException{
		assertThat(calculator.calcSum(this.numFilepath),is(10));
	}
	
	@Test
	public void multipleOfNumbers()throws IOException{
		assertThat(calculator.calcMultiply(this.numFilepath),is(24));
	}
	
}


</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Calculator]':'[Calculator]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Calculator</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Calculator {
	===================================================================
	public Integer calcSum(String filepath)throws IOException{
		
		LineCallback sumCallback = new LineCallback(){
			public Integer doSomethingWithLine(String line, Integer value){
				return value + Integer.valueOf(line);
			}
		};
	return lineReadTemplate(filepath, sumCallback, 0);
		
	}
	
	
	public Integer calcMultiply(String filepath)throws IOException{
		
		LineCallback multiCallback = new LineCallback(){
			public Integer doSomethingWithLine(String line, Integer value){
				return value + Integer.valueOf(line);
			}
		};
		
		return lineReadTemplate(filepath, multiCallback, 1);
	}
	===================================================================
	
	===================================================================
	public Integer lineReadTemplate(String filepath, LineCallback callback, int initVal)throws IOException{
		BufferedReader br = null;
		
		try{
			br = new BufferedReader(new FileReader(filepath));
			Integer res = initVal;
			String line = null;
			while((line = br.readLine()) != null){
				res = callback.doSomethingWithLine(line, res);
			}
			return res;
		}catch(IOException e){
			throw e;
		}finally{
			if(br != null){
				try{
					br.close();
				}catch(IOException e){
					System.out.println(e.getMessage());
				}
			}
		}
	}
	===================================================================
	
}

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[LineCallback]':'[LineCallback]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>LineCallback</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

public interface LineCallback {
	Integer doSomethingWithLine(String line, Integer value);
}


</font>
</pre>
</div>

<h2 style="color:#FCF9F9">5.Simple Template/CallBack Pattern - Use a Generics and add a function of String</h2>
<h3 style="color:#FCF9F9">#changed : Calculator, CalcSumTest, LineCallback</h3>
<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[CalcSumTest]':'[CalcSumTest]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>CalcSumTest</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.io.IOException;

import org.junit.Before;
import org.junit.Test;

public class CalcSumTest {
	
	Calculator calculator;
	String numFilepath;
	
	@Before
	public void setUp(){
		this.calculator = new Calculator();
		this.numFilepath = getClass().getResource("numbers.txt").getPath();
	}
	
	
	@Test
	public void sumOfNumbers() throws IOException{
		assertThat(calculator.calcSum(this.numFilepath),is(10));
	}
	
	@Test
	public void multipleOfNumbers()throws IOException{
		assertThat(calculator.calcMultiply(this.numFilepath),is(24));
	}
	
	@Test
	public void concatenateStrings()throws IOException{
		assertThat(calculator.concatenate(this.numFilepath),is("1234"));
	}
}

</font>
</pre>
</div>

<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[Calculator]':'[Calculator]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>Calculator</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Calculator {
	
	public Integer calcSum(String filepath)throws IOException{
		
		LineCallback<Integer> sumCallback = new LineCallback<Integer>(){
			public Integer doSomethingWithLine(String line, Integer value){
				return value + Integer.valueOf(line);
			}
		};
	return lineReadTemplate(filepath, sumCallback, 0);
		
	}
	
	
	public Integer calcMultiply(String filepath)throws IOException{
		
		LineCallback<Integer> multiCallback = new LineCallback<Integer>(){
			public Integer doSomethingWithLine(String line, Integer value){
				return value * Integer.valueOf(line);
			}
		};
		
		return lineReadTemplate(filepath, multiCallback, 1);
	}
	
	public String concatenate(String filepath)throws IOException{
		LineCallback<String> concatenateCallback = new LineCallback<String>(){
			public String doSomethingWithLine(String line, String value){
				return value + line;
			}
		};
		return lineReadTemplate(filepath, concatenateCallback,"");
	}
	
	
	
	public<T> T lineReadTemplate(String filepath, LineCallback<T> callback, T initVal)throws IOException{
		BufferedReader br = null;
		
		try{
			br = new BufferedReader(new FileReader(filepath));
			T res = initVal;
			String line = null;
			while((line = br.readLine()) != null){
				res = callback.doSomethingWithLine(line, res);
			}
			return res;
		}catch(IOException e){
			throw e;
		}finally{
			if(br != null){
				try{
					br.close();
				}catch(IOException e){
					System.out.println(e.getMessage());
				}
			}
		}
	}
	
	
}

</font>
</pre>
</div>


<a class="more" onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'[LineCallback]':'[LineCallback]';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0);" onfocus='blur()'>LineCallback</a><div style="DISPLAY: none">
<pre style="color:#A7B32A">
<font size="4">
package simple;

public interface LineCallback<T> {
	T doSomethingWithLine(String line, T value);
}


</font>
</pre>
</div>






</body>
</html>

