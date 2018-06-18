package sbpayment.jp.intro;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MainController {


	@Autowired
	private JdbcTemplate jdbc;

	@GetMapping("/test_credit_title")
	public String test_credit_title() {
	return "test_credit_title";
	}	
	
	@GetMapping("/test_credit_select1")
	public String test_credit_select1(Model model) {
	return "test_credit_select1";
	}
	
	@GetMapping("/test_credit_result")
	public String test_credit_result() {
	return "test_credit_result";
	}
	
//	int creditcard_id_max;
	@PostMapping("/test_credit_result")
	public String test_credit_result(int service_id[], RedirectAttributes attr) {
		jdbc.update("DELETE FROM creditcard_service_user WHERE creditcard_id = 99");
		for (int i=0; i<service_id.length; i++) {
			jdbc.update("INSERT INTO creditcard_service_user (creditcard_id,service_id) values(99,?);", service_id[i]);
		}
		Map<String,Object> sum_user = jdbc.queryForList("SELECT COUNT(service_id) AS sum_user FROM creditcard_service_user GROUP BY creditcard_id").get(0);
		double nscore_user = 1/Math.sqrt(Double.valueOf(sum_user.get("sum_user").toString()));
		System.out.println();
		System.out.println("nscore_user:  "+nscore_user);
		System.out.println("-------------------------------------------------------------");
		
		int creditcard_id_max = jdbc.queryForObject("SELECT MAX(creditcard_id) FROM creditcard_service", Integer.class);
		List<Double> scoreList = new ArrayList<>();
		for(int i=1; i<creditcard_id_max+1; i++) {
			Map<String,Object> csu_count = jdbc.queryForList("SELECT COUNT(creditcard_service.creditcard_id) AS csu_count FROM creditcard_service INNER JOIN creditcard_service_user ON creditcard_service.service_id = creditcard_service_user.service_id WHERE creditcard_service.creditcard_id = ?", i).get(0);
			System.out.println("マッチしているサービス数:  "+csu_count);
			Map<String,Object> sum = jdbc.queryForList("SELECT creditcard_id,COUNT(service_id) AS sum FROM creditcard_service GROUP BY creditcard_id").get(i-1);
			System.out.println("クレジットカードIDとスコア合計  "+sum);
			double norm = Math.sqrt(Double.valueOf(sum.get("sum").toString()));
			System.out.println("norm(平方根):  "+norm);
			double nscore = 1/norm;
			System.out.println("nscore(1/平方根）:  "+nscore);
			double score = Double.valueOf(csu_count.get("csu_count").toString())*nscore*nscore_user;
			System.out.println("score:  "+score);
			System.out.println("-------------------------------------------------------------");

			scoreList.add(score);			
			}
		
		Collections.sort(scoreList, Collections.reverseOrder());
		attr.addFlashAttribute("scores",scoreList);
		
		
	

		return "redirect:/test_credit_result";
	}
}


	/*
	@GetMapping("/form")
	public String sample(String name, int age, Model model) {

	model.addAttribute("name", name);
	model.addAttribute("age", age);
	
	//DB挿入
	jdbc.update("insert into DBTest (name,age) values(?,?);", name,age);
	
//	model.addAttribute("name1",jdbc.queryForList("SELECT * FROM DBTest").get(1));
//	model.addAttribute("name2",jdbc.queryForList("SELECT * FROM DBTest").get(1).get("name"));
	model.addAttribute("DBTests",jdbc.queryForList("SELECT * FROM DBTest"));
	
	//DB更新
//	jdbc.update("UPDATE DBTest SET name = ?,age = ?", name,age);
//    Map<String, Object> DBTest = jdbc.queryForList("SELECT * FROM DBTest where name = ?", name).get(0);
	
	return "hello";
	}
	*/

	