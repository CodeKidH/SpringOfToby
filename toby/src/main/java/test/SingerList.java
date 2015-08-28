package test;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class SingerList implements Iterable<String>{
	
	private List<String> list = new ArrayList<String>();
	
	public void add(String name){
		list.add(name);
	}
	
	public Iterator<String> iterator(){
		return list.iterator();/*new Iterator<String>(){
			int seq = 0;
			
			public boolean hasNext(){
				return seq < list.size();
			}
			
			public String next(){
				return list.get(seq++);
			}
			
			public void remove(){
				throw new UnsupportedOperationException();
			}
		};*/
	}
	
	public static void main(String[]args){
		
		SingerList singer = new SingerList();
		singer.add("me");
		singer.add("gee");
		singer.add("davie");
		
		Iterator<String> iterator = singer.iterator();
		
		while(iterator.hasNext()){
			String e = iterator.next();
			System.out.println(e);
		}
	}
	
	
}
