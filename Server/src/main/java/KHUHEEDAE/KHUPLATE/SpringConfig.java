package KHUHEEDAE.KHUPLATE;

import KHUHEEDAE.KHUPLATE.repository.FoodRepository;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringConfig {

    private final FoodRepository foodRepository;

    public SpringConfig(FoodRepository foodRepository) {
        this.foodRepository = foodRepository;
    }



}
