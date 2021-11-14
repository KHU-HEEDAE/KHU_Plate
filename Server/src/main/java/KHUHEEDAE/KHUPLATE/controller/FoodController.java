package KHUHEEDAE.KHUPLATE.controller;

import KHUHEEDAE.KHUPLATE.domain.Food;
import KHUHEEDAE.KHUPLATE.dto.FoodDTO;
import KHUHEEDAE.KHUPLATE.dto.FoodDetailDTO;
import KHUHEEDAE.KHUPLATE.service.FoodService;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("api")
public class FoodController {

    private FoodService foodService;

    public FoodController(FoodService foodService) {
        this.foodService = foodService;
    }

    //전체음식점조회
    @GetMapping("/food")
    public List<FoodDTO> viewAllFoodList(){
        List<Food> foodList = foodService.findAll();
        List<FoodDTO> result = foodList.stream()
                .filter(food -> food!=null)
                .map(FoodDTO::new)
                .collect(Collectors.toList());
        return result;
    }

    //카테고리별 음식점조회
    @GetMapping("/food/category/{category_id}/{priority_id}")
    public List<FoodDTO> viewCategoryFoodList(@PathVariable("category_id") Long categoryId, @PathVariable("priority_id") Long priorityId){
        List<Food> foodList = new ArrayList<>();
        if(priorityId==0) foodList = foodService.findAllByCategory(categoryId); //아무거나
        else if(priorityId==1) foodList = foodService.findAllByCategoryOrderByRate(categoryId); //별점높은순
        else if(priorityId==2) foodList = foodService.findAllByCategoryOrderByReview(categoryId); //리뷰개수순

        List<FoodDTO> result = foodList.stream()
                .filter(food -> food!=null)
                .map(FoodDTO::new)
                .collect(Collectors.toList());
        return result;
    }

    //특정 음식점조회
    @GetMapping("/food/{food_id}")
    public FoodDetailDTO viewFood(@PathVariable("food_id") Long foodId){
        Food food = foodService.findOne(foodId);
        return new FoodDetailDTO(food);
    }

    //음식점 이름 검색
    @GetMapping("/search")
    public List<FoodDTO> searchFoodList(@RequestParam("keyword") String keyword){
        List<FoodDTO> foodList = foodService.searchAll(keyword);
        return foodList;
    }
}
