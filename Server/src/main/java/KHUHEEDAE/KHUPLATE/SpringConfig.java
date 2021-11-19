package KHUHEEDAE.KHUPLATE;

import KHUHEEDAE.KHUPLATE.repository.CategoryRepository;
import KHUHEEDAE.KHUPLATE.repository.FoodRepository;
import KHUHEEDAE.KHUPLATE.repository.ReviewRepository;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringConfig {

    private final FoodRepository foodRepository;
    private final CategoryRepository categoryRepository;
    private final ReviewRepository reviewRepository;

    public SpringConfig(FoodRepository foodRepository, CategoryRepository categoryRepository, ReviewRepository reviewRepository) {
        this.foodRepository = foodRepository;
        this.categoryRepository = categoryRepository;
        this.reviewRepository = reviewRepository;
    }
}
