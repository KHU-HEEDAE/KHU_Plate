package KHUHEEDAE.KHUPLATE.repository;

import KHUHEEDAE.KHUPLATE.domain.Review;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review,Long> {
    List<Review> findAllByFoodId();
    List<Review> findAllOrderByDateDesc();

}
