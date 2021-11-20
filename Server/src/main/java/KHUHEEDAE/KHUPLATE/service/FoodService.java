package KHUHEEDAE.KHUPLATE.service;

import KHUHEEDAE.KHUPLATE.domain.Food;
import KHUHEEDAE.KHUPLATE.dto.FoodDTO;
import KHUHEEDAE.KHUPLATE.repository.CategoryRepository;
import KHUHEEDAE.KHUPLATE.repository.FoodRepository;
import KHUHEEDAE.KHUPLATE.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class FoodService {
    private final FoodRepository foodRepository;
    private final ReviewRepository reviewRepository;
    private final CategoryRepository categoryRepository;

    public FoodService(FoodRepository foodRepository, ReviewRepository reviewRepository, CategoryRepository categoryRepository) {
        this.foodRepository = foodRepository;
        this.reviewRepository = reviewRepository;
        this.categoryRepository = categoryRepository;
    }

    public List<Food> findAll(){
        return foodRepository.findAll();
    }

    public Food findOne(Long foodId){
        Optional<Food> food = foodRepository.findById(foodId);
        return food.get();
    }

    public List<Food> findAnyByPriority(Long priorityId){
        if(priorityId==0) return foodRepository.findAll();
        else if(priorityId==1) return foodRepository.findAllByOrderByRateDesc();
        else if(priorityId==2) return foodRepository.findAllByOrderByReviewNumDesc();
        else return null;
    }
    public List<Food> findAllByCategory(Long categoryId){
        return foodRepository.findAllByCategoryId(categoryId);
    }
    public List<Food> findAllByCategoryOrderByRate(Long categoryId){
        return foodRepository.findAllByCategoryIdOrderByRateDesc(categoryId);
    }
    public List<Food> findAllByCategoryOrderByReview(Long categoryId){
        return foodRepository.findAllByCategoryIdOrderByReviewNumDesc(categoryId);
    }

    public List<FoodDTO> searchAll(String keyword){
        List<Food> foodList = foodRepository.findByNameContaining(keyword);
        List<FoodDTO> foodDTOList = new ArrayList<>();
        for(Food food : foodList){
            foodDTOList.add(new FoodDTO(food));
        }
        return foodDTOList;
    }
}
