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

	@GetMapping("/credit_top")
	public String credit_top() {
		return "credit_top";
	}

	@GetMapping("/credit_select1")
	public String credit_select1(Model model) {
		return "credit_select1";
	}

	@GetMapping("/credit_select2")
	public String credit_select2(Model model) {
		return "credit_select2";
	}

	@GetMapping("/credit_select3")
	public String credit_select3(Model model) {
		return "credit_select3";
	}

	@GetMapping("/credit_result")
	public String credit_result() {
		
		return "credit_result";
	}

	@GetMapping("/credit_result_syosai/{name}")
	public String credit_result_syosai(@PathVariable("name") String name, Model model) {
		//サービス名の取得
		List<Map<String, Object>> content = jdbc.queryForList(
				"SELECT content FROM service WHERE id IN (SELECT service_id FROM credit_card_service WHERE credit_card_id = (SELECT id FROM credit_card WHERE name = ?));",
				name);
		model.addAttribute("credit_card_name",
				jdbc.queryForList("SELECT * FROM credit_card WHERE name = ?", name).get(0).get("name"));
		for (int i = 0; i < content.size(); i++) {
			model.addAttribute("credit_card_service", content);
		}
		return "credit_result_syosai";
	}

	@PostMapping("/credit_select2")
	public String credit_select2(int service_id[], RedirectAttributes attr) {
		jdbc.update("DELETE FROM credit_card_service_user WHERE credit_card_id = 99 AND service_id BETWEEN 1 AND 17");
		//複数選択
		for (int i = 0; i < service_id.length; i++) {
			jdbc.update("INSERT INTO credit_card_service_user (credit_card_id,service_id) values(99,?);", service_id[i]);
		}
		return "redirect:/credit_select2";
	}

	@PostMapping("/credit_select3")
	public String test_credit_select3(int service_id[], RedirectAttributes attr) {
		jdbc.update("DELETE FROM credit_card_service_user WHERE credit_card_id = 99 AND service_id BETWEEN 21 AND 27");
		//複数選択
		for (int i = 0; i < service_id.length; i++) {
			jdbc.update("INSERT INTO credit_card_service_user (credit_card_id,service_id) values(99,?);", service_id[i]);
		}
		return "redirect:/credit_select3";
	}

	@PostMapping("/credit_result")
	public String credit_result(int service_id[], RedirectAttributes attr) {
		jdbc.update("DELETE FROM credit_card_service_user WHERE credit_card_id = 99 AND service_id BETWEEN 31 AND 34");
		jdbc.update("DELETE FROM credit_card_service_user WHERE credit_card_id = 99 AND service_id BETWEEN 41 AND 43");
		jdbc.update("DELETE FROM credit_card_service_user WHERE credit_card_id = 99 AND service_id BETWEEN 51 AND 53");
		jdbc.update("DELETE FROM credit_card_service_user WHERE credit_card_id = 99 AND service_id BETWEEN 61 AND 65");
		jdbc.update("DELETE FROM credit_card_service_result");
		jdbc.update("DELETE FROM credit_card_service_result_zscore");
		//複数選択
		for (int i = 0; i < service_id.length; i++) {
			jdbc.update("INSERT INTO credit_card_service_user (credit_card_id,service_id) VALUES(99,?);", service_id[i]);
		}
		
		//ユーザー情報の計算
		Map<String, Object> sum_user = jdbc.queryForList(
				"SELECT COUNT(service_id) AS sum_user FROM credit_card_service_user WHERE service_id != 0 GROUP BY credit_card_id")
				.get(0);
		double nscore_user = 1 / Math.sqrt(Double.valueOf(sum_user.get("sum_user").toString()));
		System.out.println();
		System.out.println("nscore_user(1/平方根）:  " + nscore_user);
		System.out.println("-------------------------------------------------------------");

		int credit_card_id_max = jdbc.queryForObject("SELECT MAX(credit_card_id) FROM credit_card_service", Integer.class);
		double std_sum = 0;
		double vars = 0;

		// List<Double> scoreList = new ArrayList<>();
		for (int i = 1; i < credit_card_id_max + 1; i++) {
			//マッチ数の算出と計算
			Map<String, Object> csu_count = jdbc.queryForList(
					"SELECT COUNT(credit_card_service.credit_card_id) AS csu_count FROM credit_card_service INNER JOIN credit_card_service_user ON credit_card_service.service_id = credit_card_service_user.service_id WHERE credit_card_service.credit_card_id = ?",
					i).get(0);
			System.out.println("マッチしているサービス数:  " + csu_count);
			Map<String, Object> sum = jdbc.queryForList(
					"SELECT credit_card_id,COUNT(service_id) AS sum FROM credit_card_service GROUP BY credit_card_id")
					.get(i - 1);
			System.out.println("クレジットカードIDとスコア合計  " + sum);
			double norm = Math.sqrt(Double.valueOf(sum.get("sum").toString()));
			System.out.println("norm(平方根):  " + norm);
			double nscore = 1 / norm;
			System.out.println("nscore(1/平方根）:  " + nscore);
			double score = Double.valueOf(csu_count.get("csu_count").toString()) * nscore * nscore_user * 100;
			System.out.println("score:  " + score);
			// System.out.println();
			System.out.println("-------------------------------------------------------------");

			std_sum += score;	//標準偏差算出のため

			jdbc.update("INSERT INTO credit_card_service_result (credit_card_id, score) VALUES(?,?);", i, String.format("%.1f", score));

			// scoreList.add(score);
		}

		//ｚスコアの計算
		double std_ave = ((double) std_sum) / credit_card_id_max;

		List<Map<String, Object>> result_table_score = jdbc.queryForList("SELECT score FROM credit_card_service_result");

		for (int i = 0; i < result_table_score.size(); i++) {
			vars += (((double) result_table_score.get(i).get("score") - std_ave)
					* ((double) result_table_score.get(i).get("score") - std_ave));
		}
		double std = Math.sqrt(vars / credit_card_id_max);
		for (int i = 0; i < result_table_score.size(); i++) {
			double zscore = Double.valueOf(((double) result_table_score.get(i).get("score") - std_ave) / std);

			jdbc.update("INSERT INTO credit_card_service_result_zscore (credit_card_id, zscore) VALUES(?,?);", i + 1,
					String.format("%.3f", zscore));

		}

		//トップテンの呼出し
		List<Map<String, Object>> result = jdbc
				.queryForList("SELECT ROW_NUMBER() OVER() AS RANK, * FROM  (SELECT name, score, zscore FROM \r\n"
						+ "(SELECT credit_card_service_result.credit_card_id, score, zscore FROM credit_card_service_result_zscore JOIN credit_card_service_result ON credit_card_service_result_zscore.credit_card_id = credit_card_service_result.credit_card_id) AS csrz  \r\n"
						+ "JOIN credit_card ON csrz.credit_card_id = credit_card.id ORDER BY score DESC) \r\n"
						+ "WHERE ROW_NUMBER() OVER() BETWEEN 1 AND 10;");
		for (int j = 0; j < result.size(); j++) {
			result.get(j).put("link", "credit_result_syosai/" + result.get(j).get("name"));
		}
		System.out.println(result);
		attr.addFlashAttribute("result_table", result);

		// Collections.sort(scoreList, Collections.reverseOrder());
		// attr.addFlashAttribute("scores",scoreList);

		return "redirect:/credit_result";
	}

}
