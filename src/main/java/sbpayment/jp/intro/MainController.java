package sbpayment.jp.intro;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MainController {

	@Autowired
	private JdbcTemplate jdbc;

	@GetMapping("/test_credit_title")
	public String test_credit_title() {
		jdbc.update("DELETE FROM creditcard_service_user WHERE creditcard_id = 99");
		jdbc.update("DELETE FROM creditcard_service_result");
//		jdbc.update("ALTER TABLE creditcard_service_result DROP COLUMN score");
		return "test_credit_title";
	}

	@GetMapping("/test_credit_select1")
	public String test_credit_select1(Model model) {
		jdbc.update("DELETE FROM creditcard_service_user WHERE service_id BETWEEN 1 AND 17");
		return "test_credit_select1";
	}

	@GetMapping("/test_credit_select2")
	public String test_credit_select2(Model model) {
		jdbc.update("DELETE FROM creditcard_service_user WHERE service_id BETWEEN 21 AND 27");
		return "test_credit_select2";
	}

	@GetMapping("/test_credit_select3")
	public String test_credit_select3(Model model) {
		jdbc.update("DELETE FROM creditcard_service_user WHERE service_id BETWEEN 31 AND 34");
		jdbc.update("DELETE FROM creditcard_service_user WHERE service_id BETWEEN 41 AND 43");
		jdbc.update("DELETE FROM creditcard_service_user WHERE service_id BETWEEN 51 AND 53");
		jdbc.update("DELETE FROM creditcard_service_user WHERE service_id BETWEEN 61 AND 65");
		return "test_credit_select3";
	}

	@GetMapping("/test_credit_result")
	public String test_credit_result() {
		return "test_credit_result";
	}

	@GetMapping("/test_credit_result_syosai/{name}")
	public String test_credit_result_syosai(@PathVariable("name") String name, Model model) {
		List<Map<String, Object>> content = jdbc.queryForList(
				"SELECT content FROM service WHERE id IN (SELECT service_id FROM creditcard_service WHERE creditcard_id = (SELECT id FROM creditcard WHERE name = ?));",
				name);
		model.addAttribute("creditcard_name",
				jdbc.queryForList("SELECT * FROM creditcard WHERE name = ?", name).get(0).get("name"));
		for (int i = 0; i < content.size(); i++) {
			model.addAttribute("creditcard_service", content);
		}
		return "test_credit_result_syosai";
	}


	@PostMapping("/test_credit_select2")
	public String test_credit_select2(int service_id[], RedirectAttributes attr) {
		jdbc.update("DELETE FROM creditcard_service_user WHERE creditcard_id = 99");
		for (int i = 0; i < service_id.length; i++) {
			jdbc.update("INSERT INTO creditcard_service_user (creditcard_id,service_id) values(99,?);", service_id[i]);
		}
		return "redirect:/test_credit_select2";
	}

	@PostMapping("/test_credit_select3")
	public String test_credit_select3(int service_id[], RedirectAttributes attr) {
		for (int i = 0; i < service_id.length; i++) {
			jdbc.update("INSERT INTO creditcard_service_user (creditcard_id,service_id) values(99,?);", service_id[i]);
		}
		return "redirect:/test_credit_select3";
	}

	// String cn = card_name.get();
	@PostMapping("/test_credit_result")
	public String test_credit_result(int service_id[], RedirectAttributes attr) {
		for (int i = 0; i < service_id.length; i++) {
			jdbc.update("INSERT INTO creditcard_service_user (creditcard_id,service_id) VALUES(99,?);", service_id[i]);
		}
		Map<String, Object> sum_user = jdbc
				.queryForList(
						"SELECT COUNT(service_id) AS sum_user FROM creditcard_service_user WHERE service_id != 0 GROUP BY creditcard_id")
				.get(0);
		double nscore_user = 1 / Math.sqrt(Double.valueOf(sum_user.get("sum_user").toString()));
		System.out.println();
		System.out.println("nscore_user(1/平方根）:  " + nscore_user);
		System.out.println("-------------------------------------------------------------");

		// jdbc.update("ALTER TABLE creditcard_service_result DROP COLUMN score");
		int creditcard_id_max = jdbc.queryForObject("SELECT MAX(creditcard_id) FROM creditcard_service", Integer.class);
		// List<Double> scoreList = new ArrayList<>();
		for (int i = 1; i < creditcard_id_max + 1; i++) {
			Map<String, Object> csu_count = jdbc.queryForList(
					"SELECT COUNT(creditcard_service.creditcard_id) AS csu_count FROM creditcard_service INNER JOIN creditcard_service_user ON creditcard_service.service_id = creditcard_service_user.service_id WHERE creditcard_service.creditcard_id = ?",
					i).get(0);
			System.out.println("マッチしているサービス数:  " + csu_count);
			Map<String, Object> sum = jdbc.queryForList(
					"SELECT creditcard_id,COUNT(service_id) AS sum FROM creditcard_service GROUP BY creditcard_id")
					.get(i - 1);
			System.out.println("クレジットカードIDとスコア合計  " + sum);
			double norm = Math.sqrt(Double.valueOf(sum.get("sum").toString()));
			System.out.println("norm(平方根):  " + norm);
			double nscore = 1 / norm;
			System.out.println("nscore(1/平方根）:  " + nscore);
			double score = Double.valueOf(csu_count.get("csu_count").toString()) * nscore * nscore_user*100;
			System.out.println("score:  " + score);
			// System.out.println();
			System.out.println("-------------------------------------------------------------");

//			jdbc.update("INSERT INTO creditcard_service_result (score) VALUES(?) ON CONFLICT ON CONSTRAINT csr_pkey DO UPDATE SET score = ?", String.format("%.3f", score));
			jdbc.update("INSERT INTO creditcard_service_result (creditcard_id, score) VALUES(?,?);",i ,String.format("%.1f", score));
//			jdbc.update("UPDATE creditcard_service_result SET score = ?;", String.format("%.3f", score));
//			jdbc.update("UPDATE creditcard_service_result SET creditcard_id = (SELECT id FROM creditcard");

			List<Map<String, Object>> result = jdbc.queryForList(
					"SELECT ROW_NUMBER() OVER() AS RANK, * FROM  (SELECT name, score FROM creditcard_service_result JOIN creditcard ON creditcard_service_result.creditcard_id = creditcard.id ORDER BY score DESC) WHERE ROW_NUMBER() OVER() BETWEEN 1 AND 10;");
			for (int j = 0; j < result.size(); j++) {
				result.get(j).put("link", "test_credit_result_syosai/" + result.get(j).get("name"));
			}
			System.out.println(result);
			attr.addFlashAttribute("result_table", result);
			
			
			double std_sum = 0;
			double vars = 0;
			for(int j=0; j<result.size(); j++) {
	            std_sum += (double) result.get(j).get("score");
	        }
	        double std_ave = ( (double)std_sum )/result.size();
	        for (int j=0; j<result.size(); j++) {
	            vars += (((double) result.get(j).get("score") - std_ave)*((double) result.get(j).get("score") - std_ave));
	        }
	       double std = Math.sqrt(vars/result.size());
	       System.out.println("std:  "+std);
			
			
			// scoreList.add(score);
		}
		
		// Collections.sort(scoreList, Collections.reverseOrder());
		// attr.addFlashAttribute("scores",scoreList);

		return "redirect:/test_credit_result";
	}


}
