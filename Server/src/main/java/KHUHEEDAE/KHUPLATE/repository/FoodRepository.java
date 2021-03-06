package KHUHEEDAE.KHUPLATE.repository;

import KHUHEEDAE.KHUPLATE.domain.Food;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FoodRepository extends JpaRepository<Food,Long> {
    Food save(Food food);
    List<Food> findAllByCategoryId(Long id);
    List<Food> findAllByOrderByRateDesc();
    List<Food> findAllByOrderByReviewNumDesc();
    List<Food> findAllByCategoryIdOrderByRateDesc(Long id);
    List<Food> findAllByCategoryIdOrderByReviewNumDesc(Long id);
    List<Food> findByNameContaining(String keyword);
}
