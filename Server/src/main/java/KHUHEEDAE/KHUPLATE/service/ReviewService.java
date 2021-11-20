package KHUHEEDAE.KHUPLATE.service;

import KHUHEEDAE.KHUPLATE.domain.Food;
import KHUHEEDAE.KHUPLATE.domain.Review;
import KHUHEEDAE.KHUPLATE.dto.ReviewDTO;
import KHUHEEDAE.KHUPLATE.repository.FoodRepository;
import KHUHEEDAE.KHUPLATE.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final FoodRepository foodRepository;

    public ReviewService(ReviewRepository reviewRepository, FoodRepository foodRepository) {
        this.reviewRepository = reviewRepository;
        this.foodRepository = foodRepository;
    }

    //최신리뷰순으로 조회
    public List<Review> findAll(){
        return reviewRepository.findAll();
    }

    public void write(Review review,Long foodId){
        Food food = foodRepository.findById(foodId).get();
        food.addReview(review);
        review.setFood(food);
        reviewRepository.save(review);
    }

    public void delete(Long reviewId){
        Optional<Review> review= reviewRepository.findById(reviewId);
        reviewRepository.delete(review.get());
    }

    public void update(String content, float rate, Long reviewId){
        Optional<Review> review= reviewRepository.findById(reviewId);
        review.get().setContent(content);
        review.get().setRate(rate);
    }
}
