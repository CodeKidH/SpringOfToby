<%@include file="include.jsp"%>
<html>
<body style="background:#041303">
<h1 style="color:#FCF9F9">Chapter3_1 - Template</h1>


<h2 style="color:#FCF9F9">1.Simple Template/CallBack Pattern</h2>
<h3 style="color:#FCF9F9"><Changed : UserDao ></h3>
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


</body>
</html>

