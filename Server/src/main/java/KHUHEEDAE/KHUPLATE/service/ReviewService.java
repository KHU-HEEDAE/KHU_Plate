package KHUHEEDAE.KHUPLATE.service;

import KHUHEEDAE.KHUPLATE.domain.Review;
import KHUHEEDAE.KHUPLATE.dto.ReviewDTO;
import KHUHEEDAE.KHUPLATE.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ReviewService {

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    private final ReviewRepository reviewRepository;

    public List<Review> findAll(){
        return reviewRepository.findAll();
    }

    public void write(Review review){
        reviewRepository.save(review);
    }

    public void  delete(Long reviewId){
        Optional<Review> review= reviewRepository.findById(reviewId);
        reviewRepository.delete(review.get());
    }

    public void update(String content, int rate, Long reviewId){
        Optional<Review> review= reviewRepository.findById(reviewId);
        review.get().setContent(content);
        review.get().setRate(rate);
    }
}
